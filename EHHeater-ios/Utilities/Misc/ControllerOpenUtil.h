//
//  ControllerOpenUtil.h
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define controllerUtil  ([ControllerOpenUtil shareInstance])

@interface ControllerOpenUtil : NSObject

+ (ControllerOpenUtil *)shareInstance;

//加载App主界面
- (void)appLanuchMainViewController:(UIWindow *)appWindow;

@end
