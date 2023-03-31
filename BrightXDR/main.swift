//
//  main.swift
//  BrightXDR
//
//  Created by Dmitry Starkov on 31/03/2023.
//

import Cocoa

// Initialize the NSApplication
let app = NSApplication.shared

// Initialize AppDelegate
let delegate = AppDelegate()

// Link the delegate to app
app.delegate = delegate

// Load the Objective-C runtime and initialize the AppKit framework
_ = __NSApplicationLoad()

// Start the main event loop of the application
NSApp.run()
