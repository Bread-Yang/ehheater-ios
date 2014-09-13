//
//  DateUtil.h
//  xUtility
//
//  Created by Cliff on 12-7-18.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define dateUtil ([DateUtil shareInstance])


@interface DateUtil : NSObject
{
    NSDateFormatter * _dateFormatter;
    NSMutableDictionary *_dateFormatterMap;
    NSArray *_weekdays;
}

+ (DateUtil *)shareInstance;

- (NSString *) formatDate:(NSDate *)date format:(NSString *)format;
- (NSString *) formatDate:(NSDate *)date;
- (NSString *) formatDateWithTimeZone:(NSDate *)date format:(NSString*)format;
- (NSString *) formatDateWithTimeZone:(NSDate *)date;
- (NSString *) formatDate:(NSString *)date from:(NSString*)from to:(NSString*)to;
- (NSString *) formatMiliTime:(NSDate *)date;

- (NSDate *) toDate:(NSString *)date format:(NSString *)format;
- (NSDate *) toDate:(NSString *)date;

- (BOOL) lessThan:(NSDate *)left to:(NSDate *)right;

- (NSDate *) addSecondsToDate:(NSDate *)date second:(int)seconds;

- (int) getDayOfWeek:(NSDate *) date;
- (NSString*) getDayOfWeekDescription:(NSDate *) date;

@end