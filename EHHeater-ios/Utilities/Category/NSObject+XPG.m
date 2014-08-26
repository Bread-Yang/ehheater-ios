//
//  NSObject+XPG.m
//  SmartKitchen
//
//  Created by Lin Dan on 14-2-10.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "NSObject+XPG.h"

@implementation NSObject (XPG)

+ (NSString *)objClassName{
    return NSStringFromClass([self class]);
}

@end
