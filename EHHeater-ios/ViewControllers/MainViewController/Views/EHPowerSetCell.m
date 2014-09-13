//
//  EHPowerSetCell.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHPowerSetCell.h"

@interface EHPowerSetCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation EHPowerSetCell

#pragma mark -- Life cycle

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark -- Override

- (void)setCellSelected:(BOOL)select{
    _cellSelected = select;
    [self cellSelectStateChanged];
}

- (void)setName:(NSString *)name{
    if (_name != name) {
        if (_name) {
            _name = nil;
        }
        _name = [name copy];
        [self nameValueChanged];
    }
}

#pragma mark -- Private

- (void)cellSelectStateChanged{
    NSString *imgName = self.cellSelected ? @"radio_checked" : @"radio_unchecked";
    UIImage *img = [UIImage imagePNGName:imgName];
    [self.iconImageView setImage:img];
}

- (void)nameValueChanged{
    [self.nameLabel setText:self.name];
}

@end
