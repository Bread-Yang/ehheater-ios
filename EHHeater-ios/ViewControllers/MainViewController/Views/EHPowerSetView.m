//
//  EHPowerSetView.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHPowerSetView.h"

#import "EHPowerSetCell.h"

@interface EHPowerSetView()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation EHPowerSetView

#pragma mark -- Life cycle

+ (instancetype)loadFromNib{
    EHPowerSetView *view = nil;
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:[EHPowerSetView objClassName] owner:nil options:nil];
    if (nibs.count > 0) {
        view = [nibs objectAtIndex:0];
    }
    return view;
}

- (void)awakeFromNib{
    self.selectedIndex = 0;
    [self.tableview setDelegate:self];
    [self.tableview setDataSource:self];
}

#pragma mark -- Actions

- (IBAction)confirmButtonPressed:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(powerSetViewDidPressedConfirm:)]) {
        [self.delegate powerSetViewDidPressedConfirm:self];
    }
}

#pragma mark -- UITableViewDataSource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = kPowerSetCellID;
    UINib *nib = [UINib nibWithNibName:[EHPowerSetCell objClassName] bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:cellID];
    
    EHPowerSetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    BOOL selecte = (self.selectedIndex == indexPath.row);
    NSString *name = [NSString stringWithFormat:@"%i kW",(int)indexPath.row + 1];
    [cell setName:name];
    [cell setCellSelected:selecte];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedIndex < 3) {
        EHPowerSetCell *oldCell = (EHPowerSetCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedIndex inSection:0]];
        [oldCell setCellSelected:NO];
    }
    EHPowerSetCell *newCell = (EHPowerSetCell *)[tableView cellForRowAtIndexPath:indexPath];
    [newCell setCellSelected:YES];
    self.selectedIndex = indexPath.row;
}

@end
