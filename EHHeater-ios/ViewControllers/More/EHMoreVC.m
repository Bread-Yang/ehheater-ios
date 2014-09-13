//
//  EHMoreVC.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHMoreVC.h"
#import "EHLeftRightContainVC.h"
#import "EHMoreListCell.h"

@interface EHMoreVC ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *listData;

@end

@implementation EHMoreVC

#pragma mark -- Life cycle

- (void)dealloc{
    EHLog(@"%s",__FUNCTION__);
}

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
    [self setUpListData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.listData = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (IS_IOS7) {
        CGRect frame = self.tableView.frame;
        frame.size.height = self.view.boundsHeight - 20;
        frame.origin.y = 20;
        [self.tableView setFrame:frame];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark -- Override

- (void)configerSubViews{
    [super configerSubViews];
    //国际化
    [self.tableView drawBorder:[UIColor purpleColor]];
}

- (void)ehSetUpNavigationItems{
    
}

- (void)ehNavigationItemPressed:(UIButton *)item{
//    if (item == self.navLeftBtn) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

#pragma mark -- Private

- (void)setUpListData{
    if (!self.listData) {
        self.listData = @[i18n_Text(EH_More_SwitchHeater),
                          i18n_Text(EH_More_AccountManage),
                          i18n_Text(EH_More_HeaterManage),
                          i18n_Text(EH_More_RemindSetting),
                          i18n_Text(EH_More_Help),
                          i18n_Text(EH_More_Abount)];
    }
    [self.tableView reloadData];
}

#pragma mark -- UITableViewDataSource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = self.listData.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = EHMoreListCellID;
    UINib *nib = [UINib nibWithNibName:[EHMoreListCell objClassName] bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellID];
    EHMoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSString *name = [self.listData objectAtIndex:indexPath.row];
    [cell.nameLabel setText:name];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
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
