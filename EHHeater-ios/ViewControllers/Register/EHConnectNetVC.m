//
//  EHConnectNetVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-4.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHConnectNetVC.h"
#import "LDNetworkUtil.h"
#import "EasyLink.h"

@interface EHConnectNetVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel2;
@property (weak, nonatomic) IBOutlet UILabel *wifiNameTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *wifiTextField;
@property (weak, nonatomic) IBOutlet UILabel *passwordTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;


@end

@implementation EHConnectNetVC

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Override

- (void)configerSubViews{
    [super configerSubViews];
    //国际化
    self.title = i18n_Text(EH_Init_NAV_Title);
    [self.tipLabel1 setText:i18n_Text(EH_Wifi_Tip1)];
    [self.tipLabel2 setText:i18n_Text(EH_Wifi_Tip2)];
    [self.wifiNameTitleLabel setText:i18n_Text(EH_Wifi_NameTitle)];
    [self.passwordTitleLabel setText:i18n_Text(EH_LoginPassword_Placeholder)];
    [self.sureButton setAllStatusTitle:i18n_Text(EH_Sure)];
    
    NSString *currentWifiName = [ldNetworkUtil connectedWifiName];
    [self.wifiTextField setText:currentWifiName];
}

- (void)ehSetUpNavigationItems{
    
}

- (void)ehNavigationItemPressed:(UIButton *)item{
    if (item == self.navLeftBtn) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- Action

- (IBAction)confirmButtonPressed:(id)sender {
    NSString *ssID = self.wifiTextField.text;
    NSString *psw = self.passwordTextField.text;
    
}


#pragma mark -- UITextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
