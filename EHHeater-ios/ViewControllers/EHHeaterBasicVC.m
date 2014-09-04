//
//  EHHeaterVC.m
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHHeaterBasicVC.h"

@interface EHHeaterBasicVC ()

@property (nonatomic, strong) UIButton *navLeftView;
@property (nonatomic, strong) UIButton *navRightView;

@end

@implementation EHHeaterBasicVC

#pragma mark -- Life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self ehSetUpNavigationItems];
    [self configerSubViews];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (![iOSTool iOS5AndEalierDevice]) {
        if ([self.view window] == nil)// 是否是正在使用的视图
        {
            // Add code to preserve data stored in the views that might be
            // needed later.
            // Add code to clean up other strong references to the view in
            // the view hierarchy.
            self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
        }
    }
}

#pragma mark -- Accessor 

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    [self.navTitleLabel setText:title];
}

#pragma makr -- Public

- (void)ehSetUpNavigationItems{
    //Override
}

- (IBAction)ehNavigationItemPressed:(UIButton *)item{
    //Override point
    if (item == self.navLeftBtn) {
        EHLog(@"左按钮点击");
    }else if (item == self.navRightBtn){
        EHLog(@"右按钮点击");
    }
}

/**
 *  设置相关
 */
- (void)configerSubViews{
    if (IS_IOS7) {
        [self.ehStatusbar setHidden:NO];
    }
}

#pragma mark -- Private


#pragma mark -- Statusbar

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    if (IS_IOS7) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
