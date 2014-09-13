//
//  EHCommunicator.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ehCommunicator      ([EHCommunicator shareInstance])

@interface EHCommunicator : NSObject

@property (nonatomic, strong) NSMutableArray *devices;
@property (nonatomic, assign) int connId;
@property (assign, nonatomic) NSString* passcode;
@property (nonatomic, copy) NSString *lastResponse;

+ (EHCommunicator *)shareInstance;


- (void)turnOnOrOff:(BOOL)on ofDevice:(int)connId;

@end
