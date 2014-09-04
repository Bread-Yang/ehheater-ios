//
//  EHHeaterVC.m
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHHeaterBasicVC.h"

@interface EHHeaterBasicVC ()

@property (nonatomic, strong) UIButton *navLeftView;
@property (nonatomic, strong) UIButton *navRightView;

@end

@implementation EHHeaterBasicVC

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self ehSetUpNavigationItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Accessor 



#pragma makr -- Public

- (void)ehSetUpNavigationItems{
    //Override
}

- (void)ehNavigationItemPressed:(UIButton *)item{
    //Override point
    if (item == self.navLeftBtn) {
        EHLog(@"左按钮点击");
    }else if (item == self.navRightBtn){
        EHLog(@"右按钮点击");
    }
}

#pragma mark -- Private


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
