//
//  EHMainControlVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHMainControlVC.h"
#import "EHLeftRightContainVC.h"

@interface EHMainControlVC ()

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

#pragma mark -- Overrid

- (void)configerSubViews{
    [super configerSubViews];
    //国际化
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
