//
//  MetalView.swift
//  BrightXDR
//
//  Created by Dmitry Starkov on 28/03/2023.
//

import SwiftUI
import MetalKit

/// SwiftUI view displaying transparent HDR content to enable EDR display mode
struct MetalView: NSViewRepresentable {
    let contrast: Float // values from 1.0 to 3.0, with 2.5 is optimal for higher brightness
    let brightness: Float // values from 1.0 to 3.0, with 2.5 is optimal
    
    init(contrast: Float = 2.5, brightness: Float = 2.5) {
        self.contrast = contrast
        self.brightness = brightness
    }
    
    func makeNSView(context: Context) -> MTKView {
        let view = MTKView(frame: .zero, device: context.coordinator.device)
        view.delegate = context.coordinator
        
        // Add transparent window effect
        view.addSubview(TransparentWindow())
        
        // Allow the view to display its contents outside of the framebuffer and bind the delegate to the coordinator
        view.framebufferOnly = false
        view.preferredFramesPerSecond = 1
                        
        // Enable EDR
        view.colorPixelFormat = MTLPixelFormat.rgba16Float
        view.colorspace = CGColorSpace(name: CGColorSpace.extendedLinearDisplayP3)
        if let layer = view.layer as? CAMetalLayer {
            layer.wantsExtendedDynamicRangeContent = true
            layer.isOpaque = false
            
            // Blend EDR layer with background
            layer.compositingFilter = "multiplyBlendMode"
        }

        return view
    }
    
    func updateNSView(_ view: MTKView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(contrast: contrast, brightness: brightness)
    }
    
    class Coordinator: NSObject, MTKViewDelegate {
        let device: MTLDevice? = MTLCreateSystemDefaultDevice()
        var rendered: Bool = false
        
        let contrast: Float
        let brightness: Float
        
        init(contrast: Float, brightness: Float) {
            self.contrast = contrast
            self.brightness = brightness
        }
            
        func draw(in view: MTKView) {
            guard !rendered else { return }
            
            // Create a command queue
            guard let commandQueue = self.device?.makeCommandQueue() else { return }
            
            // Create a new command buffer and get the drawable object to render into
            guard let commandBuffer = commandQueue.makeCommandBuffer(), let drawable = view.currentDrawable else { return }
 
            // Create a color and an image with EDR support
            guard let colorSpace = CGColorSpace(name: CGColorSpace.extendedLinearDisplayP3),
                  let color = CIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0, colorSpace: colorSpace) else {
                return
            }
            let transparent = CIImage(color: color)
            
            // Initialize filter to adjust brightness level
            guard let colorControlsFilter = CIFilter(name: "CIColorControls") else { return }
            colorControlsFilter.setValue(transparent, forKey: kCIInputImageKey)
            colorControlsFilter.setValue(contrast, forKey: kCIInputContrastKey)
            colorControlsFilter.setValue(brightness, forKey: kCIInputBrightnessKey)
            guard let image = colorControlsFilter.outputImage else { return }
            
            // Create a CIContext for rendering a CIImage to a destination using Metal
            let renderContext = CIContext(mtlCommandQueue: commandQueue, options: [
                .name: "BrightXDRContext",
                .workingColorSpace: colorSpace,
                .workingFormat: CIFormat.RGBAf,
                .cacheIntermediates: true,
                .allowLowPower: false,
            ])

            // Render the CIImage
            renderContext.render(image, to: drawable.texture, commandBuffer: commandBuffer, bounds: CGRect(origin: CGPoint.zero, size: view.drawableSize), colorSpace: colorSpace)
            
            // Present the drawable to the screen
            commandBuffer.present(drawable)
            
            // Commit the command buffer for execution on the GPU
            commandBuffer.commit()
            
            // Render an image only once
            self.rendered = true
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    }
}

struct MetalView_Previews: PreviewProvider {
    static var previews: some View {
        MetalView()
    }
}
