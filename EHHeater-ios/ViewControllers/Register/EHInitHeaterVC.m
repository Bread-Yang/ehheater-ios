//
//  EHInitHeaterVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-4.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHInitHeaterVC.h"
#import "LDNetworkUtil.h"
#import "EHNoConectWifiAlert.h"

@interface EHInitHeaterVC ()<LDNetWorkUtilDelegate,EHNoConnectWifiAlertDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heaterImageView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) EHNoConectWifiAlert *noWifiAlert;

@end

@implementation EHInitHeaterVC

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [ldNetworkUtil setDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [ldNetworkUtil setDelegate:nil];
    if (self.noWifiAlert) {
        [self.noWifiAlert dismiss];
    }
}

#pragma mark -- Overrid

- (void)configerSubViews{
    [super configerSubViews];
    //国际化
    self.title = i18n_Text(EH_Init_NAV_Title);
    [self.nextButton setAllStatusTitle:i18n_Text(EH_RGNextButton_Title)];
    [self configerTipLabel];
}

- (void)configerTipLabel{
    NSString *tipString = i18n_Text(EH_Init_TipString);
    NSString *lightString = i18n_Text(EH_Init_TipHightlightString);
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:tipString];
    NSRange fullRange = [tipString rangeOfString:tipString];
    NSRange hightlightRange = [tipString rangeOfString:lightString];
    if (hightlightRange.location != NSNotFound) {
        NSRange firstRange = NSMakeRange(0, hightlightRange.location);
        NSInteger endLocation = firstRange.length + hightlightRange.length;
        NSRange endRange = NSMakeRange(endLocation, fullRange.length - endLocation);
        
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:firstRange];
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:hightlightRange];
        [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:endRange];
        //        [attribute addAttribute:NSFontAttributeName value:self.tipLabel.font range:firstRange];
        
        if ([iOSTool iOS6Device]) {
            //iOS6下要加这个才会换行，草泥马的，坑爹呢
            NSMutableParagraphStyle *paragrap = [[NSMutableParagraphStyle alloc] init];
            [attribute addAttribute:NSParagraphStyleAttributeName value:paragrap range:fullRange];
        }
    }
    [self.tipLabel setAttributedText:attribute];

}

- (void)ehSetUpNavigationItems{
    [super ehSetUpNavigationItems];
}

- (IBAction)ehNavigationItemPressed:(UIButton *)item{
    if (item == self.navLeftBtn) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- Private

- (void)setUpNoWifiAlertIfNeed{
    if (!self.noWifiAlert) {
        self.noWifiAlert = [EHNoConectWifiAlert loadFromNib];
        [self.noWifiAlert setDelegate:self];
    }
}

#pragma mark -- Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    BOOL result = YES;
    if ([identifier isEqualToString:kInit_2_Connect]) {
        if (![ldNetworkUtil isConnectWifi]) {
            [self setUpNoWifiAlertIfNeed];
            [self.noWifiAlert showInAppWindow];
            result = NO;
        }
    }
    return result;
}

#pragma mark -- LDNetWorkUtilDelegate

- (void)networkDidChangeStatus:(LDNetworkUtil *)netUtil{
    if ([netUtil isConnectWifi] && self.noWifiAlert && self.noWifiAlert.showing) {
        [self performSegueWithIdentifier:kInit_2_Connect sender:self.nextButton];
    }
}

#pragma mark -- EHNoConnectWifiAlertDelegate

- (void)noConnectWifiAlertPressedCancel:(EHNoConectWifiAlert *)alert{
    [alert dismiss];
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
