//
//  LDNetworkUtil.h
//  SmartKitchen
//
//  Created by Lin Dan on 3/24/14.
//  Copyright (c) 2014 danplin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

#define ldNetworkUtil   ([LDNetworkUtil shareInstance])

@protocol LDNetWorkUtilDelegate;
@interface LDNetworkUtil : NSObject

@property (nonatomic, weak) id<LDNetWorkUtilDelegate>delegate;
@property (nonatomic, assign) BOOL canConnectInternet;

+ (LDNetworkUtil *)shareInstance;

- (void)checkNetWorkEnvironment;

//如果有，返回当前连接wifi名称。无则返回nil
- (NSString *)connectedWifiName;

//判断是否有连接WIFI或者移动网络。
- (BOOL)isConnectWifiOrWAN;

- (BOOL)isConnectWifi;

@end

@protocol LDNetWorkUtilDelegate <NSObject>

- (void)networkDidChangeStatus:(LDNetworkUtil *)netUtil;

@end
