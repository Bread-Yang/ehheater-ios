//
//  EHCommunicator.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHCommunicator.h"

#import "SdkDelegate.h"
#import "AppUtil.h"
#import "EHDeviceFeedbackService.h"
#import "EHDeviceManager.h"
#include "utils.h"

@interface EHCommunicator(){
    SdkDelegate *_pDelegate;
}
@property (nonatomic, weak) NSTimer *findDeviceTimer;   //用于定时搜索设备

@end

@implementation EHCommunicator
SingleInstance(EHCommunicator);

#pragma mark -- Life cycle

- (id)init{
    self = [super init];
    if (self) {
        self.devices = [NSMutableArray array];
        _pDelegate = SdkDelegate::GetInstance();
        [self addNotificationObserver];
        [self startResearchTimer];
    }
    return self;
}

- (void)dealloc{
    [self removeNotifyObserver];
}

#pragma mark -- Notify

- (void)didFoundDeviceNotify:(NSNotification *)notify{
    NSValue *value = notify.object;
    [self.devices addObject:value];
    XpgEndpoint *point = (XpgEndpoint *)[value pointerValue];
    NSString *macAdr = [NSString stringWithUTF8String:point->szMac];
    if ([macAdr isEqualToString:kTemp_Connect_MAC]) {
        point->port = kTemp_Port;
        xpgcConnect(*point);
    }
}

- (void)didConnectDeviceNotify:(NSNotification *)notitfy{
    int connId = [notitfy.object intValue];
    self.connId = connId;
    NSLog(@"连接设备成功  %i",connId);
    [self stopResearchTimer];
    
    SendPasscodeReq(self.connId);
    SendStateReq(self.connId);
}

- (void)didReceiveDeviceResponse:(NSNotification *)notify{
    NSString *log = [notify object];
    self.lastResponse = log;
    NSData *data  = [NSData dataWithBytes:[self.lastResponse UTF8String] length:self.lastResponse.length];
    [deviceMG.currentHeater refreshStatusByData:data];
}

- (void)addNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFoundDeviceNotify:) name:kNotify_DidFoundDevice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didConnectDeviceNotify:) name:kNotify_DidConnectDevice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveDeviceResponse:) name:kNotify_DidReceiceResponse object:nil];
}

- (void)removeNotifyObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotify_DidFoundDevice object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotify_DidConnectDevice object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotify_DidReceiceResponse object:nil];
}

#pragma mark -- Device Search

- (void)researchDeviceTimerFired:(NSTimer *)timer{
    [self.devices removeAllObjects];
    xpgcFindDevice();
}

- (void)startResearchTimer{
    [self stopResearchTimer];
    self.findDeviceTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(researchDeviceTimerFired:) userInfo:nil repeats:YES];
}

- (void)stopResearchTimer{
    if (self.findDeviceTimer && [self.findDeviceTimer isValid]) {
        [self.findDeviceTimer invalidate];
        self.findDeviceTimer = nil;
    }
}

#pragma mark -- 设备控制
#pragma mark -- Device Control

- (void)turnOnOrOff:(BOOL)on ofDevice:(int)connId{
    SendOnOffReq(connId, on);
}

@end
