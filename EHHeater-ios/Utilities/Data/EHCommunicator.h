//
//  EHCommunicator.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ehCommunicator      ([EHCommunicator shareInstance])

@protocol EHCommunicateDelegate;
@interface EHCommunicator : NSObject

@property (nonatomic, strong) NSMutableArray *devices;
@property (nonatomic, assign) int connId;
@property (assign, nonatomic) NSString* passcode;
@property (nonatomic, strong) NSData *lastResponse;

+ (EHCommunicator *)shareInstance;

- (void)turnOnOrOff:(BOOL)on ofDevice:(int)connId;

#pragma mark -- Account Manager
- (void)registerAccount:(NSString *)account andPassword:(NSString *)password;

/**
 *  Easylink
 */
- (void)sendEasylink:(NSString *)ssid andPassword:(NSString *)psw;

/**
 *  代理
 */
@property (nonatomic, weak) id<EHCommunicateDelegate>delegate;

- (void)resignDelegate:(id<EHCommunicateDelegate>)delegate;

@end


@protocol EHCommunicateDelegate <NSObject>

@optional
- (void)communicator:(EHCommunicator *)manager registerResult:(BOOL)success;

@end