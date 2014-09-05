//
//  EHMoreListCell.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHMoreListCell.h"

@implementation EHMoreListCell

#pragma mark -- life cycle

+ (EHMoreListCell *)loadFromNib{
    EHMoreListCell *cell = nil;
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:[EHMoreListCell objClassName] owner:nil options:nil];
    if (nibs.count > 0) {
        cell = [nibs objectAtIndex:0];
    }
    return cell;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
