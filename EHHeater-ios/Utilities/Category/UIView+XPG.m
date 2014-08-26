//
//  UIView+XPG.m
//  SmartKitchen
//
//  Created by Lin Dan on 13-12-17.
//  Copyright (c) 2013年 danplin. All rights reserved.
//

#import "UIView+XPG.h"

@implementation UIView (XPG)

- (void)resetBoundsSize:(CGSize)value{
    CGRect boun = self.bounds;
    boun.size = value;
    [self setBounds:boun];
}

- (void)drawBorder:(UIColor *)color{
    [self.layer setBorderColor:[color CGColor]];
    [self.layer setBorderWidth:1.0];
}

- (void)drawCornerWithRadius:(CGFloat)radius{
    [self.layer setCornerRadius:radius];
}

#pragma mark -- Position and Size

- (CGPoint)frameOrignal{
    return self.frame.origin;
}

- (CGSize)boundsSize{
    return self.bounds.size;
}

- (CGFloat)boundsWidth{
    return self.bounds.size.width;
}

- (CGFloat)boundsWidthHalf{
    return (self.bounds.size.width / 2.0);
}

- (CGFloat)boundsHeight{
    return self.bounds.size.height;
}

- (CGFloat)boundsHeightHalf{
    return ([self boundsHeight] / 2.0);
}

- (CGFloat)frameX{
    return self.frame.origin.x;
}

- (CGFloat)frameY{
    return self.frame.origin.y;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}


#pragma mark -- 截图

- (UIImage *)captureViewContext{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);
    [self.layer renderInContext:ctx];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark -- 阴影

- (void)addLeftRightShadow{
    [self addSmartKitchenShadowWithInset:UIEdgeInsetsMake(0, 3, 0, 3)];
}

- (void)addSmartKitchenShadowWithInset:(UIEdgeInsets)insets{
    
    if (insets.top != 0) {
        [self addShadowLayerOfDirection:0 withRadius:insets.top];
    }
    if (insets.bottom != 0){
        [self addShadowLayerOfDirection:1 withRadius:insets.bottom];
    }
    if (insets.left != 0){
        [self addShadowLayerOfDirection:2 withRadius:insets.left];
    }
    if (insets.right != 0){
        [self addShadowLayerOfDirection:3 withRadius:insets.right];
    }
}

//direction : 0-top 1-bottom 2-left 3-right
- (void)addShadowLayerOfDirection:(int)direction withRadius:(CGFloat)radius{
    if (direction < 0 || direction > 3) {
        return;
    }
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    CGRect frame = CGRectZero;
    switch (direction) {
        case 0:
        {
            startPoint = CGPointMake(0.5, 0);
            endPoint = CGPointMake(0.5, 1);
            frame = CGRectMake(0, -radius, self.boundsWidth, radius);
            break;
        }
        case 1:
        {
            startPoint = CGPointMake(0.5, 1);
            endPoint = CGPointMake(0.5, 0);
            frame = CGRectMake(0, self.boundsHeight, self.boundsWidth, radius);
            break;
        }
        case 2:
        {
            startPoint = CGPointMake(1, 0.5);
            endPoint = CGPointMake(0, 0.5);
            frame = CGRectMake(-radius, 0, radius, self.boundsHeight);
            break;
        }
        case 3:
        {
            startPoint = CGPointMake(0, 0.5);
            endPoint = CGPointMake(1, 0.5);
            frame = CGRectMake(self.boundsWidth, 0, radius, self.boundsHeight);
            break;
        }
        default:
            break;
    }
    UIColor *darkColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    UIColor *lightColor = [UIColor clearColor];
    CAGradientLayer *shadowLayer = [CAGradientLayer layer];
    [shadowLayer setStartPoint:startPoint];
    [shadowLayer setEndPoint:endPoint];
    [shadowLayer setFrame:frame];
    [shadowLayer setColors:@[(id)[darkColor CGColor],(id)[lightColor CGColor]]];
    [self.layer insertSublayer:shadowLayer atIndex:0];
}

#pragma mark -- 自旋动画

- (void)layerAddRotatingAnimation{
    CABasicAnimation* rotationAnimation = (CABasicAnimation *)[self.layer animationForKey:@"rotationAnimation"];
    if (!rotationAnimation) {
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 2;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = MAXFLOAT;
        [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
}

- (void)layerPauseAnimation{
    CALayer *layer = self.layer;
    CAAnimation *animation = [layer animationForKey:@"rotationAnimation"];
    if (!animation) {
        [self layerAddRotatingAnimation];
    }
    if (layer.speed >= 1) {
        CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
        layer.speed = 0.0;
        layer.timeOffset = pausedTime;
    }
}

- (void)layerResumeAnimation{
    CALayer *layer = self.layer;
    CAAnimation *animation = [layer animationForKey:@"rotationAnimation"];
    if (!animation) {
        [self layerAddRotatingAnimation];
    }
    if (layer.speed < 1.0) {
        CFTimeInterval pauseTime = [layer timeOffset];
        layer.speed = 1.0;
        layer.timeOffset = 0.0;
        layer.beginTime = 0.0;
        CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pauseTime;
        layer.beginTime = timeSincePause;
    }
}


#pragma mark -- Animation

- (CGRect)rectOfGoInFromDirection:(SKViewAnimateDirection)direction ofStep:(int)step{
    CGRect finalRect = self.frame;
    CGRect result = finalRect;
    CGFloat pad1 = 10;
    CGFloat pad2 = 5;
    switch (direction) {
        case View_Direction_Top:
        case View_Direction_Bottom:{
            //上 和 下
            BOOL top = (direction == View_Direction_Top);
            switch (step) {
                case 0:{ result.origin.y = top ? (-finalRect.size.height) : (self.superview.boundsHeight); break;}
                case 1:{ result.origin.y = top ? (finalRect.origin.y + pad1) : (finalRect.origin.y - pad1); break;}
                case 2:{ result.origin.y = top ? (finalRect.origin.y - pad2) : (finalRect.origin.y + pad2); break;}
                default:
                    break;
            }
            break;
        }
        case View_Direction_Left:
        case View_Direction_Right:{
            //左 和 右
            BOOL left = (direction == View_Direction_Left);
            switch (step) {
                case 0:{ result.origin.x = left ? (-finalRect.size.width) : (self.superview.boundsWidth); break;}
                case 1:{ result.origin.x = left ? (finalRect.origin.x + pad1) : (finalRect.origin.x - pad1); break;}
                case 2:{ result.origin.x = left ? (finalRect.origin.x - pad2) : (finalRect.origin.x + pad2); break;}
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    return result;
}

- (void)animateGoInFromDirection:(SKViewAnimateDirection)direction{
    if (self.superview == nil) {
        return;
    }
    CGRect finalRect = self.frame;
    CGRect rect1 = [self rectOfGoInFromDirection:direction ofStep:0];
    CGRect rect2 = [self rectOfGoInFromDirection:direction ofStep:1];
    CGRect rect3 = [self rectOfGoInFromDirection:direction ofStep:2];
    [self setFrame:rect1];
    [UIView animateWithDuration:0.38 animations:^{
        [self setFrame:rect2];
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.18 animations:^{
           [self setFrame:rect3];
       } completion:^(BOOL finished) {
          [UIView animateWithDuration:0.18 animations:^{
              [self setFrame:finalRect];
          }];
       }];
    }];
}


- (void)animateGoOutOfDirection:(SKViewAnimateDirection)direction{
    CGRect currentRect = self.frame;
    CGRect aimRect = [self rectOfGoInFromDirection:direction ofStep:0];
    [UIView animateWithDuration:0.38 animations:^{
        [self setFrame:aimRect];
    } completion:^(BOOL finished) {
        [self setFrame:currentRect];
    }];
}

@end
