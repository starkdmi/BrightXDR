//
//  ContentView.swift
//  BrightXDR
//
//  Created by Dmitry Starkov on 28/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State var maxEDR: CGFloat = 0.0
    @State var maxPotentialEDR: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            TransparentWindow()
            
            HStack {
                VStack {
                    // Current maximum color component value for the screen
                    // If no content on screen provides extended dynamic range (EDR) values, the value of this property is 1.0.
                    // If any content onscreen has requested EDR, the value may be greater than 1.0, depending on the capabilities of the display hardware and other conditions.
                    // Only rendering contexts that support EDR can use values greater than 1.0.
                    Text("Max EDR: \(String(format: "%.2f", maxEDR))").padding(.top, 8)
                    Rectangle().fill(.clear).border(Color.white)
                }
                
                VStack {
                    // EDR Headroom ~= Display Peak Brightness / Current SDR Brightness
                    // SDR equals 100 nit, and peak brightness is 1600 nit --> 16.0x is EDR headroom
                    // If this property is greater than 1.0, the screen supports EDR values.
                    // If the screen doesn't support EDR values, the value is 1.0.
                    Text("Max Potential EDR: \(String(format: "%.2f", maxPotentialEDR))").padding(.top, 8)
                    MetalView()
                    //.blendMode(BlendMode.multiply) // implemented via compositingFilter of CAMetalLayer
                        .border(Color.white)
                }
            }
            .onAppear(perform: reloadStats)
            .onReceive(NotificationCenter.default.publisher(for: NSApplication.didChangeScreenParametersNotification), perform: { _ in
                reloadStats()
            })
        }
    }
    
    private func reloadStats() {
        guard let mainScreen = NSScreen.main else { return }
        self.maxEDR = mainScreen.maximumExtendedDynamicRangeColorComponentValue
        self.maxPotentialEDR = mainScreen.maximumPotentialExtendedDynamicRangeColorComponentValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
