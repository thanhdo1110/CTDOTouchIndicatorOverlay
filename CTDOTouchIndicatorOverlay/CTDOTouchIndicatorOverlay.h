//
//  CTDOTouchIndicatorOverlay.h
//  CTDOTouchIndicatorOverlay
//
//  Created by Đỗ Trung Thành on 14/6/25.
//  Tweak để kích hoạt thư viện hiển thị chấm chạm.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTDOTouchIndicatorOverlay : NSObject

+ (instancetype)sharedInstance;

- (void)handleEvent:(UIEvent *)event inWindow:(UIWindow *)window;

+ (void)setEnabled:(BOOL)enabled;
+ (BOOL)isEnabled;

+ (void)setIndicatorSize:(CGFloat)size;
+ (CGFloat)indicatorSize;

+ (void)setIndicatorColor:(UIColor *)color;
+ (UIColor *)indicatorColor;

+ (void)setIndicatorRGBColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

+ (void)setVisibilityMode:(NSInteger)mode;
+ (NSInteger)visibilityMode;

@end

NS_ASSUME_NONNULL_END