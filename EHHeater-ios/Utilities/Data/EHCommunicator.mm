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
#import "EasyLink.h"

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
    NSLog(@"找到设备 mac地址 : %s",point->szMac);
    if ([macAdr isEqualToString:kTemp_Connect_MAC]) {
        point->port = kTemp_Port;
        xpgcConnectAsync(*point);
    }
}

- (void)didConnectDeviceNotify:(NSNotification *)notitfy{
    int connId = [notitfy.object intValue];
    self.connId = connId;
    NSLog(@"连接设备成功  %i",connId);
    [self stopResearchTimer];
    
    [NSThread sleepForTimeInterval:2];
    SendPasscodeReq(self.connId); //传passcode后，才可控制？
//    SendStateReq(self.connId);  //状态查询？
}

- (void)didReceiveDeviceResponse:(NSNotification *)notify{
    NSData *resp = [notify object];
    self.lastResponse = resp;
    [deviceMG.currentHeater refreshStatusByData:resp];
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
    Byte byte = on ? 0x01 : 0x00;
    SendOnOffReq(connId, byte);
}

#pragma mark -- Account Manager
/**
 *  账号
 */
- (void)registerAccount:(NSString *)account andPassword:(NSString *)password{
//    XPG_RESULT result = xpgcRegister("987654321", "123456789");
    XPG_RESULT result = xpgcRegister([account UTF8String], [password UTF8String]);
    BOOL success = NO;
    if (result == ERROR_NONE) {
        success = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(communicator:registerResult:)]) {
        [self.delegate communicator:self registerResult:success];
    }
    EHLog(@"注册账号 = %@",success ? @"成功" : @"失败");
}

/**
 *  Easylink
 */
#pragma mark -- Easylink

- (void)sendEasylink:(NSString *)ssid andPassword:(NSString *)psw{
    [[EasyLink shareInstance] startWithSSID:ssid password:psw];
    [self performSelector:@selector(stopEasylink) withObject:nil afterDelay:30];
}

- (void)stopEasylink{
    if ([[EasyLink shareInstance] isSearching]) {
        [[EasyLink shareInstance] stop];
    }
}

#pragma mark -- Delegate

- (void)resignDelegate:(id<EHCommunicateDelegate>)delegate{
    if (self.delegate == delegate) {
        self.delegate = nil;
    }
}

@end
