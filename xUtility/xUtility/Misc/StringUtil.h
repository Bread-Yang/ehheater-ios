//
//  StringUtil.h
//  xUtility
//
//  Created by Cliff Liao on 12-11-3.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//


#import <Foundation/Foundation.h>

#define stringUtil ([StringUtil shareInstance])

@interface StringUtil : NSObject

+ (StringUtil *)shareInstance;

- (BOOL)string:(NSString*)str1 contain:(NSString*)str2;
- (BOOL)string:(NSString*)text startWith:(NSString*)prefix;
- (BOOL)string:(NSString*)text endWith:(NSString*)suffix;
- (int)string:(NSString*)str indexOf:(NSString *)text;
- (NSString*)string:(NSString*)text replace:(NSString*)replaced with:(NSString*)data;
- (NSString* )string:(NSString*)str substring:(int)from length:(int)length;


@end
