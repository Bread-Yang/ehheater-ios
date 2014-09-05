//
//  EHConfigerResultVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHConfigerResultVC.h"

@interface EHConfigerResultVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleTipLable;
@property (weak, nonatomic) IBOutlet UITextView *detailTipTextView;

@end

@implementation EHConfigerResultVC

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
    [self configerDetailTextView];
}

- (void)ehSetUpNavigationItems{
    
}

- (void)ehNavigationItemPressed:(UIButton *)item{
    if (item == self.navLeftBtn) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- Pirvate

- (void)configerDetailTextView{
    NSString *tipStr = self.detailTipTextView.text;
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:tipStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineHeightMultiple = 20.f;
    paragraphStyle.maximumLineHeight = 25.f;
    paragraphStyle.minimumLineHeight = 15.f;
    paragraphStyle.firstLineHeadIndent = 0.0f;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSRange fullRange = [tipStr rangeOfString:tipStr];
    [attribute addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:fullRange];
    [attribute addAttribute:NSFontAttributeName value:self.detailTipTextView.font range:fullRange];
    [self.detailTipTextView setAttributedText:attribute];
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
