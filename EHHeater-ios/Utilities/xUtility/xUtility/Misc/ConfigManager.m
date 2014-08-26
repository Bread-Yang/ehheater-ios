//
//  ConfigManager.m
//  xUtility
//
//  Created by Cliff on 12-10-17.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import "ConfigManager.h"
#import "Common.h"

@implementation ConfigManager

SingleInstance(ConfigManager)

- (void)setValue:(NSString*)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setValueOnce:(NSString*)value forKey:(NSString*)key
{
    if (![self value:key])
    {
        [self setValue:value forKey:key];
    }
}

- (NSString*)value:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

- (void)clear:(NSString*)key
{
    
    if ([self value:key])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

@end
