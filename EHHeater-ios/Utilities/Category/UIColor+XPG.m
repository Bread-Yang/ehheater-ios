//
//  UIColor+XPG.m
//  SmartKitchen
//
//  Created by Lin Dan on 13-12-26.
//  Copyright (c) 2013年 danplin. All rights reserved.
//

#import "UIColor+XPG.h"

@implementation UIColor (XPG)

+ (UIColor *)color255WithRed:(Byte)red Green:(Byte)green Blue:(Byte)blue andAlpha:(CGFloat)alpha{
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

@end
