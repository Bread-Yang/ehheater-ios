//
//  EHRegisterVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-4.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHRegisterVC.h"

#import "EHCommunicator.h"
#import <MBProgressHUD.h>

@interface EHRegisterVC ()<UITextFieldDelegate,EHCommunicateDelegate>

@property (weak, nonatomic) IBOutlet UIButton *backgroundBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *configerTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
@property (weak, nonatomic) IBOutlet UILabel *showPasswordLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation EHRegisterVC

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

#pragma mark -- Overrid

- (void)configerSubViews{
    [super configerSubViews];
    
    //国际化
    self.title = NSLocalizedString(EH_RG_NAV_Title, nil);
    [self.configerTipLabel setText:NSLocalizedString(EH_RGTip_String, nil)];
    [self.accountTextField setPlaceholder:NSLocalizedString(EH_RGAccount_Placeholder, nil)];
    [self.passwordTextField setPlaceholder:NSLocalizedString(EH_RGPassword_Placeholder, nil)];
    [self.showPasswordLabel setText:NSLocalizedString(EH_RGShowPassword_String, nil)];
    [self.nextButton setAllStatusTitle:NSLocalizedString(EH_RGNextButton_Title, nil)];
    
    [self.passwordTextField setSecureTextEntry:!self.showPasswordBtn.selected];
}

- (void)ehSetUpNavigationItems{
    
}

- (IBAction)ehNavigationItemPressed:(UIButton *)item{
    if (item == self.navLeftBtn) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark -- Action

- (IBAction)showPasswordButtonPressed:(id)sender {
    [self.showPasswordBtn setSelected:!self.showPasswordBtn.selected];
    [self.passwordTextField setEnabled:NO];
    [self.passwordTextField setSecureTextEntry:!self.showPasswordBtn.selected];
    [self.passwordTextField setEnabled:YES];
}

- (IBAction)backgroundButtonPressed:(id)sender {
    [self resignAllTextField];
}

- (IBAction)registerButtonPressed:(id)sender {
    NSString *account = self.accountTextField.text;
    NSString *password = self.passwordTextField.text;
    [self showRequstingHUD];
    [ehCommunicator setDelegate:self];
    [ehCommunicator registerAccount:account andPassword:password];
}


#pragma mark -- Private 

- (void)resignAllTextField{
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark -- UITextfieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -- EHCommunicateDelegate

- (void)communicator:(EHCommunicator *)manager registerResult:(BOOL)success{
    NSString *tip = success ? @"注册成功" : @"注册失败";
    [self.HUD setLabelText:tip];
    [self.HUD hide:YES];
    [self performSegueWithIdentifier:kRegister_2_Init sender:self];
}

#pragma mark -- HUD

- (MBProgressHUD *)HUD{
    if (!_HUD) {
        UIWindow *windwo = [[[UIApplication sharedApplication] delegate] window];
        _HUD = [[MBProgressHUD alloc] initWithWindow:windwo];
        [windwo addSubview:_HUD];
        [_HUD setMode:MBProgressHUDModeText];
        [_HUD setDimBackground:YES];
    }
    return _HUD;
}

- (void)showRequstingHUD{
    [self.HUD setLabelText:@"请求中..."];
    [self.HUD show:YES];
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
