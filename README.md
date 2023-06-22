# Bright XDR 
__BrightXDR__ is a proof-of-concept implementation that demonstrates how to upscale display content to XDR/HDR extra brightness on macOS. This is a demo showing one of possible implementations. The display is brighter compared to Vivid.

> The main idea behind this project is to provide an open source and free-to-use alternative to existing apps that offer similar functionality for a price of up to &euro;20. I believe that everyone should have access to powerful tools that enhance their display experience, regardless of their budget.

## About 
The app uses MetalKit to overlay the CIImage with a transparent color in EDR color space over the display windows while applying color blending filter.

## Preview 
> Screen captured on maximum system brightness with __Apple XDR (P3-1600 nits)__ display preset.

| [Window](../../tree/swiftui-window) | Split View |
| ------------ | ------------ |
|<img src="https://user-images.githubusercontent.com/21260939/228393300-34f48989-ba81-45a0-9364-3b66252f6a36.jpg" alt="Screenshot" width="400">|<img src="https://user-images.githubusercontent.com/21260939/229236909-6b904565-9dc3-48b5-ab00-96c7667c9301.jpg" alt="Screenshot2" width="590">|

## Requirements
Supported devices: Apple MacBook Pro with 14 or 16 inches and Apple Pro Display XDR.

## Limitations
- __Mission Control & Spaces__
  - HDR brightness disabled during switching between Spaces.
  - White screen can appear on desktop or Spaces previews (thumbnails).
  - White screen can appear while video playback.

## Literature

If you're interested in learning more about the technologies used in this app, check out these articles and videos:
- [Generating an Animation with a Core Image Render Destination](https://developer.apple.com/documentation/coreimage/generating_an_animation_with_a_core_image_render_destination)
- [WWDC 2022 Session 10114: Display EDR content with Core Image, Metal, and SwiftUI](https://developer.apple.com/videos/play/wwdc2022/10114/)
- [WWDC 2022 Session 10113: Explore EDR on iOS](https://developer.apple.com/videos/play/wwdc2022/10113/)
- [Funky Overlay Window: Floating NSWindow using Obj-C](https://developer.apple.com/library/archive/samplecode/FunkyOverlayWindow/Introduction/Intro.html)

## Alternatives

If you're looking for alternative applications that provide similar functionality, you might want to check out:
- [Vivid](https://www.getvivid.app/)
- [Lunar](https://github.com/alin23/Lunar)
- [BetterDisplay](https://github.com/waydabber/BetterDisplay)
- [TotalXDR](https://junebytes.com/totalxdr)
