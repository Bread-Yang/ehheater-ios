//
//  EHDeviceManager.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHDeviceManager.h"

//#import "EHElecHeater.h"

@interface EHDeviceManager()

@end

@implementation EHDeviceManager
SingleInstance(EHDeviceManager)

- (instancetype)init{
    self = [super init];
    if (self) {
        self.currentHeater = [[EHElecHeater alloc] init];
    }
    return self;
}

@end
