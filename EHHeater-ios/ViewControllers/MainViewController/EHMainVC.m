//
//  EHMainVC.m
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHMainVC.h"
#import "EHDeviceManager.h"
#import "EHMainControlVC.h"
#import "EHCircleSlider.h"

@interface EHMainVC ()<EHElecHeaterDelegate>


@end

@implementation EHMainVC

#pragma mark -- Life cycle

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self performSegueWithIdentifier:kTurnOn_2_Control sender:self];
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

#pragma mark -- Overrid

- (void)configerSubViews{
    [super configerSubViews];
    
    //国际化
}

- (void)ehSetUpNavigationItems{
    
}

- (IBAction)ehNavigationItemPressed:(UIButton *)item{
    if (item == self.navLeftBtn) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- Action

- (IBAction)turnOnDevicePressed:(id)sender {
//    [deviceMG.currentHeater sendTurnOnCommand];
    //test
    [self performSegueWithIdentifier:kTurnOn_2_Control sender:self];
}

#pragma makr -- Storyboard segue

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    BOOL result = YES;
////    if ([identifier isEqualToString:kTurnOn_2_Control]) {
////        BOOL isOn = deviceMG.currentHeater.isOn;
////        result = isOn;
////    }
//    return result;
//}

#pragma mark -- EHElecHeaterDelegate

- (void)elecHeaterStatusChanged:(EHElecHeater *)heater{
    if (heater.isOn) {
        [self performSegueWithIdentifier:kTurnOn_2_Control sender:self];
    }else{
        [self.navigationController popToViewController:self animated:YES];
    }
}

@end
