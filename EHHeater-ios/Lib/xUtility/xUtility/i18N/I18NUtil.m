//
//  I18NUtil.m
//  iLogger
//
//  Created by Cliff Liao on 12-10-12.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import "I18NUtil.h"
#import "I18NController.h"

static I18NUtil *instance = nil;

@implementation I18NUtil


@synthesize locale;


#pragma mark - Singleton

+(I18NUtil*)shareInstance {
    
	@synchronized(self) {
        if (!instance) {
            instance = [[I18NUtil alloc] init];
        }
    }
    return instance;
}

#pragma mark - Singleton

- (void)dealloc
{
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        [self refresh];
    }
    
    return self;
}

- (void)refresh
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    if (currentLanguage && [currentLanguage hasPrefix:@"zh-Hans"]){
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    } else {
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    }
}

- (NSString*)getText:(NSString*)key
{
    return [[I18NController shareController] getLocalizedString:key comment:@"" locale:locale];
}

- (NSString*)getTextExt:(NSString*)key ext:(NSString*)ext
{
    NSString *text = [[I18NController shareController] getLocalizedString:key comment:@"" locale:locale];
    return [text stringByAppendingString:ext];
}


- (BOOL)en
{
    return [self.locale.localeIdentifier isEqualToString:@"en"];
}
@end
