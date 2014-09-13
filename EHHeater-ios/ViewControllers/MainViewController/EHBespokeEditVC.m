//
//  EHBespokeEditVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHBespokeEditVC.h"

@interface EHBespokeEditVC ()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *repeatTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *repeatValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempUnitLabel;

@end

@implementation EHBespokeEditVC

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
}

- (void)ehSetUpNavigationItems{
    
}

- (IBAction)ehNavigationItemPressed:(UIButton *)item{
    if (item == self.navLeftBtn) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else if (item == self.navRightBtn){
        //无
    }
}

#pragma mark -- Action

- (IBAction)daySelectPressed:(id)sender {
    
}

- (IBAction)pepoleNumPressed:(id)sender {
    
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
