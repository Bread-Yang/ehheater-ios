//
//  EHLoginVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-4.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHLoginVC.h"

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
    [self.accountTextField setPlaceholder:i18n_Text(EH_LoginAccount_Placeholder)];
    [self.passwordTextField setPlaceholder:i18n_Text(EH_LoginPassword_Placeholder)];
    [self.loginButton setAllStatusTitle:i18n_Text(EH_LoginButton_Title)];
    [self.configerTipLabel setText:i18n_Text(EH_ConfigerTip_String)];
    [self.configerButton setAllStatusTitle:i18n_Text(EH_ConfigerButton_Title)];
    
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
