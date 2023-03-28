# Bright XDR 
__BrightXDR__ is a macOS SwiftUI proof-of-concept implementation that demonstrates how to upscale display content to XDR/HDR extra brightness on a selected part of the display. This is a demo showing one of possible implementations.

> The main idea behind this project is to provide an open source and free-to-use alternative to existing apps that offer similar functionality for a price of up to &euro;20. I believe that everyone should have access to powerful tools that enhance their display experience, regardless of their budget.

## About 
The app uses MetalKit to overlay the CIImage with a solid color in EDR color space based on the maximum headroom available right over the screen windows.

## Preview 
Both screenshots captured on maximum brightness of display with __Apple XDR (P3-1600 nits)__ preset.
| Screenshot 1 | Screenshot 2 |
| ------------ | ------------ |
|<img src="https://user-images.githubusercontent.com/21260939/228224887-3da133cf-8495-4c90-ac3d-536ba51a4f53.jpg" alt="Screenshot" width="400">|<img src="https://user-images.githubusercontent.com/21260939/228225471-c4d97fcf-30e1-470d-9f18-f10768cb2a58.jpg" alt="Screenshot2" width="400">|

## Requirements
Possible supported devices: Apple MacBook Pro with 14 or 16 inches and Apple Pro Display XDR.

## TODO
- Calibrate output colors: The current implementation uses a white ultra-bright color with an alpha of 0.5 overlaying the display pixels, which can lead to color inaccuracy and brightness losses. This needs to be addressed.
- Fullscreen & System-wide (overlay): The app currently works on a selected part of the display only. It needs to be extended to support fullscreen and system-wide overlay.
- Performance: The app needs to be optimized for better performance and to reduce resource usage.

## Literature

If you're interested in learning more about the technologies used in this app, check out these articles and videos:
- [Generating an Animation with a Core Image Render Destination](https://developer.apple.com/documentation/coreimage/generating_an_animation_with_a_core_image_render_destination)
- [WWDC 2022 Session 10114: Display EDR content with Core Image, Metal, and SwiftUI](https://developer.apple.com/videos/play/wwdc2022/10114/)
- [WWDC 2022 Session 10113: Explore EDR on iOS](https://developer.apple.com/videos/play/wwdc2022/10113/)

## Alternatives

If you're looking for alternative applications that provide similar functionality, you might want to check out:
- [Vivid](https://www.getvivid.app/)
- [Lunar](https://github.com/alin23/Lunar)
- [BetterDisplay](https://github.com/waydabber/BetterDisplay)
- [TotalXDR](https://junebytes.com/totalxdr)
