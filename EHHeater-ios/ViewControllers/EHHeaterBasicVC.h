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
@property (nonatomic, weak) IBOutlet UIView *ehStatusbar;       //当iOS7时，显示此条，已让statusbar看起来是黑色的 !!
@property (nonatomic, weak) IBOutlet UIButton *navLeftBtn;
@property (nonatomic, weak) IBOutlet UILabel *navTitleLabel;
@property (nonatomic, weak) IBOutlet UIButton *navRightBtn;
- (IBAction)ehNavigationItemPressed:(UIButton *)item;
- (void)ehSetUpNavigationItems;

/**
 *  设置相关
 */
- (void)configerSubViews;

@end
