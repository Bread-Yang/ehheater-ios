//
//  ConfigManager.h
//  xUtility
//
//  Created by Cliff on 12-10-17.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define configManager ([ConfigManager shareInstance])

#define CONFIG_SHAREHANDE @"Config_ShareHand"
#define CONFIG_SAMPLE_RATE @"SampleRate"


@interface ConfigManager : NSObject

+ (ConfigManager*)shareInstance;
- (void)setValue:(NSString*)value forKey:(NSString*)key;
- (void)setValueOnce:(NSString*)value forKey:(NSString*)key;
- (NSString*)value:(NSString*)key;
- (void)clear:(NSString*)key;

@end
