//
//  EHConstant.h
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#ifndef EHHeater_ios_EHConstant_h
#define EHHeater_ios_EHConstant_h

/**
 *     Import
 */
//#import <xUtility.h>
#import "EHLocalizableKeys.h"
#import "iOSTool.h"

#import "NSObject+XPG.h"
#import "UIColor+XPG.h"
#import "UIView+XPG.h"
#import "UIButton+XPG.h"
#import "UIImage+XPG.h"

//Debug Log 控制，用SKLog代替NSLog,需要显示log时不注释DEBUG_LOG，不需要log时，注释即可
#define DEBUG_LOG
//Log控制
#ifdef  DEBUG_LOG
#define EHLog(...) NSLog(__VA_ARGS__)
#else
#define EHLog(...) {}
#endif

/**
 * 通知key
 */
#define kNotify_DidFoundDevice      @"XPG_SDK_DID_FOUND_DEVICE"
#define kNotify_DidConnectDevice    @"XPG_SDK_DID_CONNECT_DEVICE"
#define kNotify_DidReceiceResponse  @"XPG_SDK_DID_RECEIVE_RESPONSE"

/**
 * Storyboard 界面跳转segue ID
 */
#define kLogin_2_Register           @"goToRegister"
#define kRegister_2_Init            @"register2Init"
#define kLogin2MainVC               @"login2MainVC"
#define kInit_2_Connect             @"init2Connect"
#define kTurnOn_2_Control           @"turnOn2ControlVC"
#define kBespoke2Edit               @"bespoke2Edit"

/**
 *  临时
 */
#define kTemp_Connect_MAC           @"C8934642E4C7"     //默认的链接的热水器wifi的mac地址
#define kTemp_Port                  12416

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// 实现单例宏
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#define SingleInstance(Clazz)           \
+(Clazz*)shareInstance {                \
\
static Clazz *instance = nil;       \
static dispatch_once_t _once;       \
\
dispatch_once(&_once, ^{            \
instance = [[self alloc] init]; \
});                                 \
return instance;                    \
}

#endif
