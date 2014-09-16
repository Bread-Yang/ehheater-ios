//
//  EHLoginVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-4.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHLoginVC.h"

#import "EHDeviceManager.h"
#import "EHMainVC.h"

@interface EHLoginVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *inputContainView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *configerTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *configerButton;


@end

@implementation EHLoginVC

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

#pragma mark -- Configer Subviews

- (void)configerSubViews{
    [super configerSubViews];
    //国际化
    [self.accountTextField setPlaceholder:NSLocalizedString(EH_LoginAccount_Placeholder, nil)];
    [self.passwordTextField setPlaceholder:NSLocalizedString(EH_LoginPassword_Placeholder, nil)];
    [self.loginButton setAllStatusTitle:NSLocalizedString(EH_LoginButton_Title, nil)];
    [self.configerTipLabel setText:NSLocalizedString(EH_ConfigerTip_String, nil)];
    [self.configerButton setAllStatusTitle:NSLocalizedString(EH_ConfigerButton_Title, nil)];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundImageViewTap:)];
    [self.bgImageView addGestureRecognizer:tap];
}

#pragma mark -- Private

- (void)resignAllTextField{
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

#pragma mark -- Actions

- (IBAction)loginButtonPressed:(id)sender {
    [self resignAllTextField];
//    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:[EHMainVC objClassName]];
//    [self.navigationController pushViewController:vc animated:YES];
    [self performSegueWithIdentifier:kLogin2MainVC sender:self];
}

- (void)backgroundImageViewTap:(UITapGestureRecognizer *)gesture{
    [self resignAllTextField];
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
