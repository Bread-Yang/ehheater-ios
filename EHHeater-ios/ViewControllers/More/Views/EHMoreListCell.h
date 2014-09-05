//
//  EHMoreListCell.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-5.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EHMoreListCellID            @"EHMoreListCellID"

@interface EHMoreListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

+ (EHMoreListCell *)loadFromNib;

@end
