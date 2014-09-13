//
//  EHDeviceManager.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EHElecHeater.h"

#define deviceMG    ([EHDeviceManager shareInstance])

@interface EHDeviceManager : NSObject

@property (nonatomic, strong) EHElecHeater *currentHeater;

+ (EHDeviceManager *)shareInstance;

@end
