//
//  EHDeviceFeedbackService.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHDeviceFeedbackService.h"

@implementation EHDeviceFeedbackService
SingleInstance(EHDeviceFeedbackService);

//热水器 - 开、关状态
- (BOOL)isHeaterOn:(NSData *)data{
    BOOL result = NO;
    if (data.length > 5) {
        int byte = 0;
        [data getBytes:&byte range:NSMakeRange(5, 1)];
        result = (byte == 0x01);
    }
    return result;
}

@end
