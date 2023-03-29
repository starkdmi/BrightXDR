//
//  TransparentWindow.swift
//  BrightXDR
//
//  Created by Dmitry Starkov on 28/03/2023.
//

import AppKit

/// Transparent view allow overlaying UI elements on top of other windows or the desktop background
class TransparentWindow: NSView {
    override func viewDidMoveToWindow() {
        window?.backgroundColor = .clear
        super.viewDidMoveToWindow()
    }
}
