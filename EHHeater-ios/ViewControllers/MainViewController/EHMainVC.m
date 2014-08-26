//
//  EHMainVC.m
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHMainVC.h"

@interface EHMainVC ()

@end

@implementation EHMainVC

#pragma mark -- Overrid Point

- (void)ehSetUpNavigationItems{
    //主界面不需要
}

#pragma mark -- Life cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:i18n_Text(EH_Main_NAV_Title)];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Action

- (IBAction)turnOnButtonPressed:(UIButton *)sender {
    
}


@end
