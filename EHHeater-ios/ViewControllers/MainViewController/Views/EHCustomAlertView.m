//
//  EHPowerSetView.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHCustomAlertView.h"

@implementation EHCustomAlertView


+ (instancetype)loadFromNib{
    EHCustomAlertView *alertView = [[EHCustomAlertView alloc] init];
    return alertView;
}

#pragma mark -- Public

- (void)showInAppWindow{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    self.frame = window.bounds;
    if (![self isDescendantOfView:window]) {
        [UIView transitionWithView:window duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.showing = YES;
            [window addSubview:self];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)dismiss{
    self.showing = NO;
    [self removeFromSuperview];
}

@end
