//
//  EHMainControlVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHMainControlVC.h"

#import "EHLeftRightContainVC.h"
#import "EHPowerSetView.h"
#import "EHCircleSlider.h"
#import "EHWaveView.h"
#import "EHBespokeVC.h"

@interface EHMainControlVC ()<EHPowerSetViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIView *modeContentView;
@property (weak, nonatomic) IBOutlet UIImageView *modeBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *modeNameLabel;
@property (weak, nonatomic) IBOutlet EHCircleSlider *circleSlider;
@property (weak, nonatomic) IBOutlet UIImageView *currentTempIconView;
@property (weak, nonatomic) IBOutlet UIView *infoContainView;
@property (weak, nonatomic) IBOutlet UILabel *tempTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainWaterTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *remainWaterValueLabel;

@property (weak, nonatomic) IBOutlet UIButton *topInfoButton;
@property (weak, nonatomic) IBOutlet UILabel *topInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *bottomInfoButton;
@property (weak, nonatomic) IBOutlet UILabel *bottomInfoLabel;

@property (weak, nonatomic) IBOutlet UIView *modeContainView;
@property (weak, nonatomic) IBOutlet UIButton *smartModeButton;
@property (weak, nonatomic) IBOutlet UIButton *morningBathButton;
@property (weak, nonatomic) IBOutlet UIButton *infoModeButton;
@property (weak, nonatomic) IBOutlet UILabel *smartModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningBathLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoModeLabel;

@property (nonatomic, weak) UIButton *selectButton;

@end

@implementation EHMainControlVC

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

- (void)dealloc{
    EHLog(@"%s",__FUNCTION__);
}

#pragma mark -- Overrid

- (void)configerSubViews{
    [super configerSubViews];
    //国际化
    
    //设置属性
    [self.infoContainView setBackgroundColor:[UIColor clearColor]];
}

- (void)ehSetUpNavigationItems{
    
}

- (IBAction)ehNavigationItemPressed:(UIButton *)item{
    if (item == self.navLeftBtn) {
        //更多
        [self.fatherVC.deckVC toggleLeftView];
    }else if (item == self.navRightBtn){
        //关机
        [self.fatherVC.navigationController popViewControllerAnimated:YES];
    }
}

//特殊情况，需要重载
- (UINavigationController *)navigationController{
    if (self.fatherVC) {
        return self.fatherVC.navigationController;
    }
    return [super navigationController];
}

#pragma mark -- Actions

- (IBAction)modeButtonPressed:(UIButton *)sender {
    if (self.selectButton != sender) {
        [self.selectButton setSelected:NO];
        [sender setSelected:YES];
        self.selectButton = sender;
    }
}

//设置功率按钮点击
- (IBAction)bottomButtonPressed:(id)sender {
    EHPowerSetView *view = [EHPowerSetView loadFromNib];
    [view setDelegate:self];
    [view showInAppWindow];
}

#pragma mark -- CustomViewDelegate

//EHPowerSetViewDelegate
- (void)powerSetViewDidPressedConfirm:(EHPowerSetView *)view{
    [view dismiss];
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
