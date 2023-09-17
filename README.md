# CancelableCircularProgressView for SwiftUI

CancelableCircularProgressView is a SwiftUI view that combines a circular progress indicator with a cancel (stop) icon overlay. This can be useful in scenarios where you want to indicate an ongoing process that the user has the option to stop or cancel.

## Features

- Customizable line width of the progress circle.
- Customizable size for the cancel (stop) icon.
- Supports changing the background and foreground colors of the progress circle.
- Built with native SwiftUI components for smooth integration and animations.

## Requirements

- iOS 13.0 or later
- SwiftUI

## Usage

```swift
CancelableCircularProgressView(value: 0.5)
```

This initializes a `CancelableCircularProgressView` with a 50% progress. The view will use default parameters for line width, icon size, and colors.

See Preview for CancelableCircularProgressView for actual use case.

### Customization

You can customize the `CancelableCircularProgressView` by using the following parameters:

- `value`: The progress value which ranges from `0.0` (no progress) to `1.0` (full progress).
- `lineWidth`: The thickness of the progress circle line.
- `iconSize`: The size for the cancel (stop) icon.
- `backgroundColor`: The color of the base circle (which shows the max possible progress).
- `foregroundColor`: The color of the actual progress.

For example:

```swift
CancelableCircularProgressView(value: 0.75, lineWidth: 10, iconSize: 50, backgroundColor: .red, foregroundColor: .blue)
```

## Implementation Details

The component is made up of two primary views:

1. `CircularProgressView`: This view is responsible for rendering the actual circular progress. It uses the SwiftUI `Circle` shape, combined with modifiers and animations to achieve the desired progress effect.

2. `CancelableCircularProgressView`: This is the main view that combines `CircularProgressView` with an overlay of a cancel (stop) icon. It utilizes a `ZStack` to layer the progress circle and the stop icon.

