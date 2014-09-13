//
//  EHPowerSetView.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHCustomAlertView : UIView

@property (nonatomic, assign) BOOL showing;

+ (instancetype)loadFromNib;

- (void)showInAppWindow;
- (void)dismiss;

@end
