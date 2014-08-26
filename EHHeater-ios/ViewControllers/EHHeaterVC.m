//
//  EHHeaterVC.m
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHHeaterVC.h"

@interface EHHeaterVC ()

@property (nonatomic, strong) UIButton *navLeftView;
@property (nonatomic, strong) UIButton *navRightView;

@end

@implementation EHHeaterVC

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
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self ehSetUpNavigationItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.ehNavLeftItem = nil;
    self.ehNavRightItem = nil;
}

#pragma mark -- Accessor 

- (void)setNavLeftTitle:(NSString *)navLeftTitle{
    _navLeftTitle = navLeftTitle;
    if (self.navLeftView) {
        [self.navLeftView setAllStatusTitle:navLeftTitle];
    }
}

- (void)setNavRightTitle:(NSString *)navRightTitle{
    _navRightTitle = navRightTitle;
    if (self.navRightView) {
        [self.navRightView setAllStatusTitle:navRightTitle];
    }
}

#pragma makr -- Public

- (void)ehSetUpNavigationItems{
    //Override
    if (self.ehNavRightItem == nil) {
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setFrame:CGRectMake(0, 0, 50, 40)];
        [view addTarget:self action:@selector(customNavItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
        [view setAllStatusTitle:self.navLeftTitle];
        [self setNavLeftView:view];
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:view];
        self.ehNavLeftItem = left;
    }
    if (self.ehNavRightItem == nil) {
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setFrame:CGRectMake(0, 0, 50, 40)];
        [view addTarget:self action:@selector(customNavItemButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [view setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [view setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin];
        [view setAllStatusTitle:self.navRightTitle];
        [self setNavRightView:view];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
        self.ehNavRightItem = item;
    }
    self.navigationItem.leftBarButtonItem = self.ehNavLeftItem;
    self.navigationItem.rightBarButtonItem = self.ehNavRightItem;
}

- (void)ehNavigationItemPressed:(UIBarButtonItem *)item{
    //Override point
    if (item == self.ehNavLeftItem) {
        EHLog(@"左按钮点击");
    }else if (item == self.ehNavRightItem){
        EHLog(@"右按钮点击");
    }
}

#pragma mark -- Private

- (void)customNavItemButtonAction:(id)sender{
    if (sender == self.navLeftView) {
        [self ehNavigationItemPressed:self.ehNavLeftItem];
    }else if (sender == self.navRightView){
        [self ehNavigationItemPressed:self.ehNavRightItem];
    }
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
