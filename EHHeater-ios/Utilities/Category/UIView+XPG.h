//
//  UIView+XPG.h
//  SmartKitchen
//
//  Created by Lin Dan on 13-12-17.
//  Copyright (c) 2013年 danplin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    View_Direction_Top = 0,
    View_Direction_Left,
    View_Direction_Bottom,
    View_Direction_Right
}SKViewAnimateDirection;

@interface UIView (XPG)

- (void)resetBoundsSize:(CGSize)value;

- (void)drawBorder:(UIColor *)color;
- (void)drawCornerWithRadius:(CGFloat)radius;

- (CGPoint)frameOrignal;
- (CGSize)boundsSize;
- (CGFloat)boundsWidth;
- (CGFloat)boundsWidthHalf;
- (CGFloat)boundsHeight;
- (CGFloat)boundsHeightHalf;
- (CGFloat)frameX;
- (CGFloat)frameY;
- (CGFloat)centerX;
- (CGFloat)centerY;


- (UIImage *)captureViewContext;
- (void)addLeftRightShadow;
- (void)addSmartKitchenShadowWithInset:(UIEdgeInsets)insets;

- (void)layerAddRotatingAnimation;
- (void)layerPauseAnimation;
- (void)layerResumeAnimation;

- (void)animateGoInFromDirection:(SKViewAnimateDirection)direction;
- (void)animateGoOutOfDirection:(SKViewAnimateDirection)direction;

@end
