//
//  iOSTool.m
//  party-rocker
//
//  Created by Lin Dan on 13-11-20.
//  Copyright (c) 2013年 XPG. All rights reserved.
//

#import "iOSTool.h"

@implementation iOSTool

+ (BOOL)iOS7Device{
    double sysVersion = [[UIDevice currentDevice]systemVersion].doubleValue;
    return (sysVersion >= 7.0);
}

+ (BOOL)iOS5AndEalierDevice{
    double sysVersion = [[UIDevice currentDevice]systemVersion].doubleValue;
    return (sysVersion < 6.0);
}

@end
