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
	@synchronized(self) {
        if (!shareController) {
            shareController = [[I18NController alloc] init];
        }
    }
    return shareController;
}

#pragma mark - lifecycle

+(id)alloc {
    self = [super alloc];
    if (self) {
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)delloc {
    if (shareController) {
        [shareController release];
    }
    [super dealloc];
}




@end
