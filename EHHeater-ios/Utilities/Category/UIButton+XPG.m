//
//  UIButton+XPG.m
//  SmartKitchen
//
//  Created by Lin Dan on 14-1-17.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "UIButton+XPG.h"

@implementation UIButton (XPG)

- (void)setAllStatusTitle:(NSString *)str{
    [self setTitle:str forState:UIControlStateNormal];
    [self setTitle:str forState:UIControlStateHighlighted];
    [self setTitle:str forState:UIControlStateSelected];
    [self setTitle:str forState:UIControlStateDisabled];
}

@end
