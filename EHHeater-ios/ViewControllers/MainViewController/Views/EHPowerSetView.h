//
//  EHPowerSetView.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHCustomAlertView.h"

@protocol EHPowerSetViewDelegate;
@interface EHPowerSetView : EHCustomAlertView

@property (nonatomic, weak) id<EHPowerSetViewDelegate>delegate;

@end

@protocol EHPowerSetViewDelegate <NSObject>

- (void)powerSetViewDidPressedConfirm:(EHPowerSetView *)view;

@end
