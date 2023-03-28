//
//  MetalView.swift
//  BrightXDR
//
//  Created by Dmitry Starkov on 28/03/2023.
//

import SwiftUI
import MetalKit

// SwiftUI view displaying static semi-transparent HDR content to enable EDR display mode
struct MetalView: NSViewRepresentable {
    func makeNSView(context: Context) -> MTKView {
        let view = MTKView(frame: .zero, device: context.coordinator.device)
        
        // Allow the view to display its contents outside of the framebuffer and bind the delegate to the coordinator
        view.framebufferOnly = false
        view.preferredFramesPerSecond = 1
        view.delegate = context.coordinator
                        
        // Enable EDR
        view.colorPixelFormat = MTLPixelFormat.rgba16Float
        view.colorspace = CGColorSpace(name: CGColorSpace.extendedLinearSRGB)
        if let layer = view.layer as? CAMetalLayer {
            layer.wantsExtendedDynamicRangeContent = true
            layer.isOpaque = false
            
            // Blend EDR layer with background
            layer.compositingFilter = "multiplyBlendMode" // multiplyBlendMode, overlayBlendMode
        }

        return view
    }
    
    func updateNSView(_ view: MTKView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MTKViewDelegate {
        let device: MTLDevice? = MTLCreateSystemDefaultDevice()
        var rendered: Bool = false
            
        func draw(in view: MTKView) {
            guard !rendered else { return }
            
            // Create a command queue
            guard let commandQueue = self.device?.makeCommandQueue() else { return }
            
            // Create a new command buffer and get the drawable object to render into
            guard let commandBuffer = commandQueue.makeCommandBuffer(), let drawable = view.currentDrawable else { return }
            
            // Get the EDR Headroom ~= Display Peak Brightness / Current SDR Brightness
            // If this property is greater than 1.0, the screen supports EDR values
            let headroom = NSScreen.main?.maximumPotentialExtendedDynamicRangeColorComponentValue ?? 1.0
            
            // Create a color and an image with EDR support
            guard let colorSpace = CGColorSpace(name: CGColorSpace.extendedLinearSRGB),
                  let color = CIColor(red: headroom, green: headroom, blue: headroom, alpha: 0.5, colorSpace: colorSpace) else {
                return
            }
            let image = CIImage(color: color)
            
            // Create a CIContext for rendering a CIImage to a destination using Metal
            let renderContext = CIContext(mtlCommandQueue: commandQueue, options: [
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
