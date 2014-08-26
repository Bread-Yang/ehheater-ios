//
//  StringUtil.m
//  xUtility
//
//  Created by Cliff Liao on 12-11-3.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import "StringUtil.h"
#import "Common.h"

@implementation StringUtil

SingleInstance(StringUtil)

- (BOOL)string:(NSString*)str1 contain:(NSString*)str2
{
    return ([str1 rangeOfString:str2 options:NSCaseInsensitiveSearch].length > 0);
}


- (BOOL)string:(NSString*)text startWith:(NSString*)prefix
{
    if ( text != nil && prefix != nil ){
        if ( [prefix length] > [text length] ) {
            return NO;
        }
        
        NSString* prestr = [text substringToIndex:[prefix length]];
        if ( [self string:prestr equals:prefix] ) {
            return YES;
        }
        
    }
    return NO;
}

- (BOOL)string:(NSString*)text endWith:(NSString*)suffix
{
    if ( text != nil && suffix != nil ){
        if ( [suffix length] > [text length] ) {
            return NO;
        }
        NSInteger len = [text length] - [suffix length];
        NSString* sufstr = [text substringFromIndex:len];
        if ( [self string:sufstr caseEquals:suffix] ) {
            return YES;
        }
        
    }
    return NO;
}

- (BOOL) string:(NSString*)str1 equals:(NSString*)str2
{
    if ( str1 == nil || str2 == nil ) {
        return NO;
    }
    return [str1 compare:str2 options:NSCaseInsensitiveSearch] == NSOrderedSame;
}


- (BOOL) string:(NSString*)str1 caseEquals:(NSString*)str2
{
    return (str1 == nil || str2 == nil) ? NO : [str1 isEqualToString:str2];
}

- (NSString*) string:(NSString*)text replace:(NSString*)replaced with:(NSString*)data
{
    return [text stringByReplacingOccurrencesOfString:replaced withString:data];
}

- (int)string:(NSString*)str indexOf:(NSString *)text {
    NSRange range = [str rangeOfString:text];
    if ( range.length > 0 ) {
        return range.location;
    } else {
        return -1;
    }
}

- (NSString*) string:(NSString*)text substring:(int)from length:(int)length
{
    NSString *value = [text substringWithRange:NSMakeRange(from, length)];
    return [[value retain] autorelease];
}


@end
