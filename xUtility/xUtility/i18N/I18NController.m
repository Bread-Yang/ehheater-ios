//
//  I18NController.m
//  I18NController
//
//  Created by danny on 6/14/11.
//  Copyright 2011 XPG. All rights reserved.
//


#import "I18NController.h"




static I18NController *shareController = nil;

@implementation I18NController




#pragma mark - Public

- (NSString *)getLocalizedString:(NSString *)_key comment:(NSString *)_comment locale:(NSLocale *)_locale {
    if (_locale) {
        NSString *tableName = [NSString stringWithFormat:@"%@.lproj/localization",[_locale localeIdentifier]];
        return NSLocalizedStringFromTable(_key,tableName,_comment);
    }
    
    return NSLocalizedString(_key,_comment);
}

- (UIImage *)image:(NSString *)imageName andType:(NSString *)type
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:type];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

#pragma mark - Singleton

+(I18NController*)shareController {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareController = [[I18NController alloc] init];
    });
    return shareController;
}

@end
