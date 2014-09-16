//
//  EHConfigerVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHConfigerVC.h"

@interface EHConfigerVC ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation EHConfigerVC

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
    self.title = NSLocalizedString(EH_Init_NAV_Title, nil);
    [self configerTipLabel];
}

- (void)ehSetUpNavigationItems{
    
}

- (void)ehNavigationItemPressed:(UIButton *)item{
    if (item == self.navLeftBtn) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- Pirvate

- (void)configerTipLabel{
    NSString *tipString = NSLocalizedString(EH_ConfigerTipString, nil);
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:tipString];
    NSString *lightStr1 = NSLocalizedString(EH_ConfigerTipHightlight1, nil);
    NSString *lightStr2 = NSLocalizedString(EH_ConfigerTipHightlight2, nil);
    NSRange fullRange = [tipString rangeOfString:tipString];
    NSRange range1 = [tipString rangeOfString:lightStr1];
    NSRange range2 = [tipString rangeOfString:lightStr2];
    
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:fullRange];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range1];
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range2];
    if ([iOSTool iOS6Device]) {
        NSMutableParagraphStyle *paragrap = [[NSMutableParagraphStyle alloc] init];
        [attribute addAttribute:NSParagraphStyleAttributeName value:paragrap range:fullRange];
    }
    [self.tipLabel setAttributedText:attribute];
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
