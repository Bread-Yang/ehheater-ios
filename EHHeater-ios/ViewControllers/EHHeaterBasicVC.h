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

@interface EHHeaterBasicVC : UIViewController

/**
 * 导航栏相关
 */
@property (nonatomic, weak) UIButton *navLeftBtn;
@property (nonatomic, weak) UIButton *navRightBtn;
- (void)ehNavigationItemPressed:(UIButton *)item;
- (void)ehSetUpNavigationItems;

@end
