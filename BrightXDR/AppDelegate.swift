//
//  AppDelegate.swift
//  BrightXDR
//
//  Created by Dmitry Starkov on 31/03/2023.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    // The overlay window
    private var window: NSWindow!

    // The MTKView instance
    private var metalView: MetalView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let mainScreen = NSScreen.main else { return }

        // let splitViewRect = NSRect(x: mainScreen.frame.width/2, y: 0, width: mainScreen.frame.width/2, height: mainScreen.frame.height)
        let fullScreenRect = NSRect(x: 0, y: 0, width: mainScreen.frame.width, height: mainScreen.frame.height)

        // Create a new transparent, borderless window
        window = NSWindow(contentRect: fullScreenRect, styleMask: [.borderless], backing: .buffered, defer: false)
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        // Ignore all mouse events
        window.ignoresMouseEvents = true

        // Set the window's level to mainMenu to make it float above all other windows
        // Requires "Application is agent (UIElement)" set to "YES" in info.plist for system-wide support
        // The maximum possible values is NSWindow.Level(rawValue: Int(CGShieldingWindowLevel() + 19))
        window.level = NSWindow.Level.mainMenu

        // Allow window to overlay in Mission Control and Spaces
        window.collectionBehavior = [.stationary, .canJoinAllSpaces, .fullScreenAuxiliary, .ignoresCycle, .managed]

        // Keep visible all time (required for overlays)
        window.hidesOnDeactivate = false

        // Add metal view with HDR overlay
        guard let view = window.contentView else { return }
        metalView = MetalView(frame: view.bounds, frameRate: 3)
        metalView.autoresizingMask = [.width, .height]
        view.addSubview(metalView)

        // Present the window
        window.makeKeyAndOrderFront(nil)
    }
}
