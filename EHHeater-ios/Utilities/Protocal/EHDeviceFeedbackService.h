//
//  EHDeviceFeedbackService.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define deviceFeedback      ([EHDeviceFeedbackService shareInstance])

@interface EHDeviceFeedbackService : NSObject

+ (EHDeviceFeedbackService *)shareInstance;


//热水器 - 开、关状态
- (BOOL)isHeaterOn:(NSData *)data;

@end
