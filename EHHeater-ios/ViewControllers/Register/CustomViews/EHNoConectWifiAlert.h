//
//  EHNoConectWifiAlert.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-4.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EHNoConnectWifiAlertDelegate;
@interface EHNoConectWifiAlert : UIView

@property (nonatomic, weak) id<EHNoConnectWifiAlertDelegate>delegate;
@property (nonatomic, assign) BOOL showing;

+ (instancetype)loadFromNib;

- (void)showInAppWindow;
- (void)dismiss;

@end

@protocol EHNoConnectWifiAlertDelegate <NSObject>

- (void)noConnectWifiAlertPressedCancel:(EHNoConectWifiAlert *)alert;

@end
