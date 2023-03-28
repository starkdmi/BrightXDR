//
//  TransparentWindow.swift
//  BrightXDR
//
//  Created by Dmitry Starkov on 28/03/2023.
//

import SwiftUI

/// AppKit implementation
class TransparentWindowView: NSView {
    override func viewDidMoveToWindow() {
        window?.backgroundColor = .clear
        super.viewDidMoveToWindow()
    }
}

/// Transparent view allow overlaying UI elements on top of other windows or the desktop background
struct TransparentWindow: NSViewRepresentable {
    func makeNSView(context: Self.Context) -> NSView {
        return TransparentWindowView()
    }
    
    func updateNSView(_ nsView: NSView, context: Context) { }
}

struct TransparentWindow_Previews: PreviewProvider {
    static var previews: some View {
        TransparentWindow()
    }
}
