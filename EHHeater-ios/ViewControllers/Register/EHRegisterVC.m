//
//  EHRegisterVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-4.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHRegisterVC.h"

@interface EHRegisterVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *backgroundBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *configerTipLabel;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
@property (weak, nonatomic) IBOutlet UILabel *showPasswordLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

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
    self.title = i18n_Text(EH_RG_NAV_Title);
    [self.configerTipLabel setText:i18n_Text(EH_RGTip_String)];
    [self.accountTextField setPlaceholder:i18n_Text(EH_RGAccount_Placeholder)];
    [self.passwordTextField setPlaceholder:i18n_Text(EH_RGPassword_Placeholder)];
    [self.showPasswordLabel setText:i18n_Text(EH_RGShowPassword_String)];
    [self.nextButton setAllStatusTitle:i18n_Text(EH_RGNextButton_Title)];
    
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
