//
//  DeviceUtil.h
//  xUtility
//
//  Created by Cliff on 12-11-10.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SUPPORT_IPHONE5
#define deviceUtil ([DeviceUtil shareInstance])
#define wrapName(name) ([[DeviceUtil shareInstance] wrap:(name)])
#define wrapImage(name) ([[DeviceUtil shareInstance] wrapImage:(name)])
#define wrap_ImageName(name) ([UIImage imageNamed:wrapImage(name)])

#define kWidth_iPhone       320
#define kHeight_iPhone4     480
#define kHeight_iPhone5     568
#define kHeight_iPhone      ([[DeviceUtil shareInstance] iPhone5]?kHeight_iPhone5:kHeight_iPhone4)
#define kHeight_iPhone5_Plus 88
#define kHeight_iPhone_Plus ([[DeviceUtil shareInstance] iPhone5]?kHeight_iPhone5_Plus:0)


#define kWidth_iPad         768
#define kHeight_iPad        1024

#define kDeviceWidth ([[DeviceUtil shareInstance] deviceWidth])
#define kDeviceHeight ([[DeviceUtil shareInstance] deviceHigh])

#define bottomBarRect_iPhone4 CGRectMake(0, 436, kWidth_iPhone, 50)
#define bottomBarRect_iPhone5 CGRectMake(0, 436 + 88, kWidth_iPhone, 50)
#define bottomBarRect_iPhone ([[DeviceUtil shareInstance] iPhone5]?bottomBarRect_iPhone5:bottomBarRect_iPhone4)
#define bottomBarRect_iPad CGRectMake(0, kHeight_iPad - 88, kWidth_iPad, 108)
#define kBottomBarButtonWidth_iPhone 107
#define kBottomBarButtonHeight_iPhone 50
#define kBottomBarButtonWidth_iPad 232
#define kBottomBarButtonHeight_iPad 95



@interface DeviceUtil : NSObject

+ (DeviceUtil *)shareInstance;

- (NSString*)wrap:(NSString*)name;
- (NSString*)wrapImage:(NSString*)name;

- (float) deviceWidth;
- (float) deviceHigh;

- (BOOL)iPhone;
- (BOOL)iPhone5;
- (NSString *) platform;


@end
