# CTDOTouchIndicatorOverlay

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/thanhdo1110/CTDOTouchIndicatorOverlay)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/thanhdo1110/CTDOTouchIndicatorOverlay/blob/main/LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://github.com/thanhdo1110/CTDOTouchIndicatorOverlay)

**English** | [Tiếng Việt](README.md)

## 🌟 Features

- Touch indicator overlay for iOS applications
- Customizable indicator size and color
- Multiple visibility modes
- Smooth animations and ripple effects
- Screen recording compatibility
- Easy integration with existing projects

## 📱 Demo

![Demo](demo.gif)

## 🔧 Installation

### Using Theos

1. Add the following to your `control` file:
```
Depends: mobilesubstrate (>= 0.9.5000)
```

2. Add the following to your `Makefile`:
```makefile
CTDOTouchIndicatorOverlay_FILES = Tweak.xm
CTDOTouchIndicatorOverlay_CFLAGS = -fobjc-arc
CTDOTouchIndicatorOverlay_FRAMEWORKS = UIKit
```

3. Create a `Tweak.xm` file:
```objc
#import "CTDOTouchIndicatorOverlay.h"

@interface CTDOTouchIndicatorOverlayInitializer : NSObject
@end

@implementation CTDOTouchIndicatorOverlayInitializer

+ (void)load {
    dispatch_async(dispatch_get_main_queue(), ^{
        [CTDOTouchIndicatorOverlay setEnabled:YES]; // ON TWEAK, OFF TWEAK      
        [CTDOTouchIndicatorOverlay setIndicatorSize:17.0]; // SIZE OF INDICATOR 
        [CTDOTouchIndicatorOverlay setVisibilityMode:0]; // 0: normal, 1: visible during recording
            [CTDOTouchIndicatorOverlay setIndicatorRGBColorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0]; // COLOR OF INDICATOR
        });
}

@end

%hook UIWindow

- (void)sendEvent:(UIEvent *)event {
    [[CTDOTouchIndicatorOverlay sharedInstance] handleEvent:event inWindow:self];
    %orig;
}

%end

```

## 🛠️ Usage

### Basic Setup
```objc
// Enable the touch indicator
[CTDOTouchIndicatorOverlay setEnabled:YES];

// Set indicator size
[CTDOTouchIndicatorOverlay setIndicatorSize:20.0];

// Set indicator color
[CTDOTouchIndicatorOverlay setIndicatorRGBColorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0];

// Set visibility mode (0: Always visible, 1: Visible only during screen recording)
[CTDOTouchIndicatorOverlay setVisibilityMode:0];
```

## 📝 API Reference

### Methods

| Method | Description |
|--------|-------------|
| `setEnabled:` | Enable/disable the touch indicator |
| `setIndicatorSize:` | Set the size of the touch indicator |
| `setIndicatorColor:` | Set the color of the touch indicator |
| `setIndicatorRGBColorWithRed:green:blue:alpha:` | Set the RGB color of the touch indicator |
| `setVisibilityMode:` | Set the visibility mode |

## 👥 Authors

- **Đỗ Trung Thành (dothanh1110)** - *Initial work* - [GitHub](https://github.com/thanhdo1110)
- **CTDO Team** - *Development and Support*

## 📞 Contact

- Telegram: [@ctdotech](https://t.me/ctdotech)
- Telegram: [@dothanh1110](https://t.me/dothanh1110)
- YouTube: [thanhdo1110](https://youtube.com/thanhdo1110)
- Website: [ctdo.net](https://ctdo.net)

## 📄 Copyright

© 2025 CTDO Team. All rights reserved. 