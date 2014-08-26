//
//  I18NUtil.h
//  iLogger
//
//  Created by Cliff Liao on 12-10-12.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define i18n ([I18NUtil shareInstance])
#define i18n_Text(name) ([i18n getText:(name)])

@interface I18NUtil : NSObject


@property(nonatomic,retain) NSLocale *locale;

+(I18NUtil*)shareInstance;

- (void)refresh;
- (NSString*)getText:(NSString*)key;
- (NSString*)getTextExt:(NSString*)key ext:(NSString*)ext;
- (BOOL)en;

@end
