//
//  CTDOTouchIndicatorOverlay.m
//  CTDOTouchIndicatorOverlay
//
//  Created by Đỗ Trung Thành on 14/6/25.
//  Tweak để kích hoạt thư viện hiển thị chấm chạm.
//

#import "CTDOTouchIndicatorOverlay.h"


@interface CTDOTouchIndicatorOverlay ()

@property (nonatomic, strong) NSMapTable<UITouch *, UIView *> *activeTouches;

+ (instancetype)sharedInstance;
- (void)handleEvent:(UIEvent *)event inWindow:(UIWindow *)window;

@end


@implementation CTDOTouchIndicatorOverlay

static BOOL _enabled = NO;
static CGFloat _indicatorSize = 20.0;
static UIColor *_indicatorColor;
static NSInteger _visibilityMode = 0; 


#pragma mark - Singleton

+ (instancetype)sharedInstance {
    static CTDOTouchIndicatorOverlay *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _activeTouches = [NSMapTable weakToStrongObjectsMapTable];
        if (!_indicatorColor) {
            _indicatorColor = [UIColor colorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0];
        }
    }
    return self;
}

#pragma mark - Public Class Methods

+ (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
}

+ (BOOL)isEnabled {
    return _enabled;
}

+ (void)setIndicatorSize:(CGFloat)size {
    _indicatorSize = size;
}

+ (CGFloat)indicatorSize {
    return _indicatorSize;
}

+ (void)setIndicatorColor:(UIColor *)color {
    _indicatorColor = color;
}

+ (UIColor *)indicatorColor {
    return _indicatorColor;
}

+ (void)setIndicatorRGBColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    if (_visibilityMode == 0) {
        _indicatorColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
}

+ (void)setVisibilityMode:(NSInteger)mode {
    _visibilityMode = mode;
    [self _updateIndicatorColor];
}

+ (NSInteger)visibilityMode {
    return _visibilityMode;
}

+ (void)_updateIndicatorColor {
    switch (_visibilityMode) {
        case 1: 
            _indicatorColor = [UIColor colorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:0.0];
            break;
        default: 
            _indicatorColor = [UIColor colorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0];
            break;
    }
}


#pragma mark - Event Handling (Logic chính)

- (void)handleEvent:(UIEvent *)event inWindow:(UIWindow *)window {
    if (![CTDOTouchIndicatorOverlay isEnabled] || event.type != UIEventTypeTouches) {
        return;
    }

    NSSet<UITouch *> *allTouches = [event allTouches];
    
    for (UITouch *touch in allTouches) {
        switch (touch.phase) {
            case UITouchPhaseBegan:
                [self _touchesBegan:touch inWindow:window];
                break;
            case UITouchPhaseMoved:
                [self _touchesMoved:touch inWindow:window];
                break;
            case UITouchPhaseEnded:
                [self _touchesEnded:touch inWindow:window];
                break;
            case UITouchPhaseCancelled:
                [self _touchesCancelled:touch inWindow:window];
                break;
            default:
                break;
        }
    }
}


#pragma mark - Private Touch Handling Methods

- (void)_touchesBegan:(UITouch *)touch inWindow:(UIWindow *)window {
    CGPoint point = [touch locationInView:window];
    
    CGFloat size = [CTDOTouchIndicatorOverlay indicatorSize];
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    indicatorView.center = point;
    
    if (_visibilityMode == 1) {
        indicatorView.backgroundColor = [UIScreen mainScreen].isCaptured ? 
            [UIColor colorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:1.0] :
            [UIColor colorWithRed:0.6196 green:0.6196 blue:0.6196 alpha:0.0];
    } else {
        indicatorView.backgroundColor = [CTDOTouchIndicatorOverlay indicatorColor];
    }
    
    indicatorView.layer.cornerRadius = size / 2.0;
    indicatorView.layer.shadowColor = [UIColor blackColor].CGColor;
    indicatorView.layer.shadowOffset = CGSizeMake(0, 1);
    indicatorView.layer.shadowRadius = 3.0;
    indicatorView.layer.shadowOpacity = 0.5;
    indicatorView.userInteractionEnabled = NO;
    
    CAShapeLayer *rippleLayer = [CAShapeLayer layer];
    rippleLayer.frame = indicatorView.bounds;
    rippleLayer.path = [UIBezierPath bezierPathWithOvalInRect:indicatorView.bounds].CGPath;
    rippleLayer.fillColor = [UIColor clearColor].CGColor;
    rippleLayer.strokeColor = indicatorView.backgroundColor.CGColor;
    rippleLayer.lineWidth = 2.0;
    rippleLayer.opacity = 0.0;
    [indicatorView.layer addSublayer:rippleLayer];
    
    [window addSubview:indicatorView];
    [self.activeTouches setObject:indicatorView forKey:touch];
    
    CABasicAnimation *rippleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    rippleAnimation.fromValue = @(1.0);
    rippleAnimation.toValue = @(2.0);
    rippleAnimation.duration = 0.3;
    rippleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(0.8);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 0.3;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[rippleAnimation, opacityAnimation];
    animationGroup.duration = 0.3;
    animationGroup.repeatCount = HUGE_VALF;
    animationGroup.removedOnCompletion = NO;
    
    [rippleLayer addAnimation:animationGroup forKey:@"ripple"];
}

- (void)_touchesMoved:(UITouch *)touch inWindow:(UIWindow *)window {
    UIView *indicatorView = [self.activeTouches objectForKey:touch];
    if (indicatorView) {
        [UIView animateWithDuration:0.05
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
            indicatorView.center = [touch locationInView:window];
        } completion:nil];
    }
}

- (void)_touchesEnded:(UITouch *)touch inWindow:(UIWindow *)window {
    UIView *indicatorView = [self.activeTouches objectForKey:touch];
    if (indicatorView) {
        [self.activeTouches removeObjectForKey:touch];
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            indicatorView.transform = CGAffineTransformMakeScale(1.5, 1.5);
            indicatorView.alpha = 0;
        } completion:^(BOOL finished) {
            [indicatorView removeFromSuperview];
        }];
    }
}

- (void)_touchesCancelled:(UITouch *)touch inWindow:(UIWindow *)window {
    [self _touchesEnded:touch inWindow:window];
}

@end