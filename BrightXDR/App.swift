//
//  App.swift
//  BrightXDR
//
//  Created by Dmitry Starkov on 28/03/2023.
//

import SwiftUI

@main
struct BrightXDRApp: App {
    var body: some Scene {
        WindowGroup {
            MetalView(contrast: 2.5, brightness: 2.5)
        }
    }
}
