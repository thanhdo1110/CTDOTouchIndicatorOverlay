# CTDOTouchIndicatorOverlay

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/thanhdo1110/CTDOTouchIndicatorOverlay)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/thanhdo1110/CTDOTouchIndicatorOverlay/blob/main/LICENSE)
[![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)](https://github.com/thanhdo1110/CTDOTouchIndicatorOverlay)

[English](README_EN.md) | **Tiếng Việt**

## 🌟 Tính Năng

- Hiển thị chỉ báo chạm cho ứng dụng iOS
- Tùy chỉnh kích thước và màu sắc chỉ báo
- Nhiều chế độ hiển thị
- Hiệu ứng mượt mà và gợn sóng
- Tương thích với ghi màn hình
- Dễ dàng tích hợp vào dự án hiện có

## 📱 Demo

![Demo](demo.gif)

## 🔧 Cài Đặt

### Sử Dụng Theos

1. Thêm vào file `control`:
```
Depends: mobilesubstrate (>= 0.9.5000)
```

2. Thêm vào file `Makefile`:
```makefile
CTDOTouchIndicatorOverlay_FILES = Tweak.xm
CTDOTouchIndicatorOverlay_CFLAGS = -fobjc-arc
CTDOTouchIndicatorOverlay_FRAMEWORKS = UIKit
```

3. Tạo file `Tweak.xm`:
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

## 🛠️ Sử Dụng

### Thiết Lập Cơ Bản
```objc
// Bật chỉ báo chạm
[CTDOTouchIndicatorOverlay setEnabled:YES];

// Đặt kích thước chỉ báo
[CTDOTouchIndicatorOverlay setIndicatorSize:20.0];

// Đặt màu chỉ báo
[CTDOTouchIndicatorOverlay setIndicatorRGBColorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0];

// Đặt chế độ hiển thị (0: Luôn hiển thị, 1: Chỉ hiển thị khi ghi màn hình)
[CTDOTouchIndicatorOverlay setVisibilityMode:0];
```

## 📝 Tài Liệu API

### Các Phương Thức

| Phương Thức | Mô Tả |
|------------|-------|
| `setEnabled:` | Bật/tắt chỉ báo chạm |
| `setIndicatorSize:` | Đặt kích thước chỉ báo |
| `setIndicatorColor:` | Đặt màu chỉ báo |
| `setIndicatorRGBColorWithRed:green:blue:alpha:` | Đặt màu RGB cho chỉ báo |
| `setVisibilityMode:` | Đặt chế độ hiển thị |

## 👥 Tác Giả

- **Đỗ Trung Thành (dothanh1110)** - *Công việc ban đầu* - [GitHub](https://github.com/thanhdo1110)
- **CTDO Team** - *Phát triển và Hỗ trợ*

## 📞 Liên Hệ

- Telegram: [@ctdotech](https://t.me/ctdotech)
- Telegram: [@dothanh1110](https://t.me/dothanh1110)
- YouTube: [thanhdo1110](https://youtube.com/thanhdo1110)
- Website: [ctdo.net](https://ctdo.net)

## 📄 Bản Quyền

© 2025 CTDO Team. All rights reserved.

