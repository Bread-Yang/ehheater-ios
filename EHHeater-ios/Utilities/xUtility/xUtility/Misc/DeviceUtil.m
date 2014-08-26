//
//  DeviceUtil.m
//  xUtility
//
//  Created by Cliff on 12-11-10.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import "DeviceUtil.h"
#import "Common.h"
#import <sys/sysctl.h>

@implementation DeviceUtil

SingleInstance(DeviceUtil)

#pragma  mark - private
- (NSString*)device
{
#ifdef IPHONE_VERSION_ONLY
    return @"iPhone";
#else
    if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        return @"iPad";
    else
        return @"iPhone";
#endif
}

- (BOOL)iPhone
{
#ifdef IPHONE_VERSION_ONLY
    return YES;
#else
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
#endif
}

- (BOOL)iPhone5
{
#ifdef IPHONE_VERSION_ONLY
    #ifdef SUPPORT_IPHONE5
    return [[UIScreen mainScreen] bounds].size.height > 500;
    #else
    return NO;
    #endif
#else
    if ([self iPhone])
    {
    #ifdef SUPPORT_IPHONE5
        return [[UIScreen mainScreen] bounds].size.height > 500;
    #else
        return NO;
    #endif
    }
    else
        return NO;
#endif
}



#pragma  mark - public
- (NSString*)wrap:(NSString*)name
{
    return [NSString stringWithFormat:@"%@_%@", name, [self device]] ;
}

- (NSString*)wrapImage:(NSString*)name
{
    NSString *device = [self device];
    
    if ([device isEqualToString:@"iPhone"])
        return name;
    
    return [NSString stringWithFormat:@"%@_%@", name, device] ;
}

- (float) deviceHigh
{
    return [self iPhone]?kHeight_iPhone:kHeight_iPad;
}

- (float) deviceWidth
{
    return [self iPhone]?kWidth_iPhone:kWidth_iPad;
}

- (NSString *) platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}
@end
