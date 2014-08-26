//
//  EHHeaterVC.h
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

/**
 * 项目ViewController的父类
 */

#import <UIKit/UIKit.h>

@interface EHHeaterVC : UIViewController

/**
 * 导航栏相关
 */
@property (nonatomic, strong) UIBarButtonItem *ehNavLeftItem;
@property (nonatomic, strong) UIBarButtonItem *ehNavRightItem;
@property (nonatomic, copy) NSString *navLeftTitle;
@property (nonatomic, copy) NSString *navRightTitle;
- (void)ehNavigationItemPressed:(UIBarButtonItem *)item;
- (void)ehSetUpNavigationItems;

@end
