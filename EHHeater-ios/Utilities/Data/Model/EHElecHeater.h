//
//  EHElecHeater.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

/**
 *  电热水器数据模型
 */

#import <Foundation/Foundation.h>

@protocol EHElecHeaterDelegate;
@interface EHElecHeater : NSObject

@property (nonatomic, copy) NSString *macAddress;
@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, assign) int connId;

@property (nonatomic, weak) id<EHElecHeaterDelegate>delegate;

- (void)sendTurnOnCommand;
- (void)sendTurnOffCommand;

//收到设备反馈后，需要调用这个
- (void)changeHeaterOnOffStatue:(BOOL)on;

- (void)giveUpDelegate:(id<EHElecHeaterDelegate>)delegate;

- (void)refreshStatusByData:(NSData *)data;

@end

@protocol EHElecHeaterDelegate <NSObject>

- (void)elecHeaterStatusChanged:(EHElecHeater *)heater;   //设备开关回调

@end
