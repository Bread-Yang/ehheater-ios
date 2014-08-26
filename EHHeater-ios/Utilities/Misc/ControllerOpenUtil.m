//
//  ControllerOpenUtil.m
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "ControllerOpenUtil.h"
#import "EHMainVC.h"

@implementation ControllerOpenUtil

SingleInstance(ControllerOpenUtil);

- (void)appLanuchMainViewController:(UIWindow *)appWindow{
    EHMainVC *mainVC = [[EHMainVC alloc] initWithNibName:[EHMainVC objClassName] bundle:nil];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    [appWindow setRootViewController:rootNav];
}

@end
