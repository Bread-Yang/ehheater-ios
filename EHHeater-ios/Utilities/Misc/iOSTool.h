//
//  iOSTool.h
//  party-rocker
//
//  Created by Lin Dan on 13-11-20.
//  Copyright (c) 2013年 XPG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iOSTool : NSObject

#define IS_IOS7 ([iOSTool iOS7Device])

+ (BOOL)iOS7Device;

+ (BOOL)iOS5AndEalierDevice;

@end
