//
//  EHConstant.h
//  EHHeater-ios
//
//  Created by Lin Dan on 14-8-25.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#ifndef EHHeater_ios_EHConstant_h
#define EHHeater_ios_EHConstant_h

/**
 *     Import
 */
#import "xUtility.h"
#import "EHLocalizableKeys.h"

#import "NSObject+XPG.h"
#import "UIColor+XPG.h"
#import "UIView+XPG.h"
#import "UIButton+XPG.h"
#import "UIImage+XPG.h"

//Debug Log 控制，用SKLog代替NSLog,需要显示log时不注释DEBUG_LOG，不需要log时，注释即可
#define DEBUG_LOG
//Log控制
#ifdef  DEBUG_LOG
#define EHLog(...) NSLog(__VA_ARGS__)
#else
#define EHLog(...) {}
#endif

#endif
