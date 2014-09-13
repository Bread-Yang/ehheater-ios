//
//  EHPowerSetCell.h
//  EHHeater-ios
//
//  Created by Danplin on 14-9-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPowerSetCellID        @"EHPOwerSetCellID"

@interface EHPowerSetCell : UITableViewCell

@property (nonatomic, assign) BOOL cellSelected;
@property (nonatomic, copy) NSString *name;

@end
