//
//  DateUtil.m
//  xUtility
//
//  Created by Cliff on 12-7-18.
//  Copyright (c) 2012年 Xtremeprog.com. All rights reserved.
//

#import "DateUtil.h"
#import "Common.h"

@implementation DateUtil

SingleInstance(DateUtil)

- (id)init
{
    self = [super init];
    if (self)
    {
        NSArray *formats = [NSArray arrayWithObjects:@"yyyy-MM-dd HH:mm:ss", @"yyyy-MM-dd_HH_mm_ss", @"M", @"dd", @"hh:mm", @"yyyy/MM/dd HH:mm", @"yyyy/MM/dd", @"e", @"HH:mm", @"yyyy.MM.dd HH:mm", @"yyyy.MM.dd HH:mm:ss", @"yyyy年MM月dd日 HH:mm:ss", @"MMM d, yyyy HH:mm:ss", @"HH-mm-ss", @"MMM d, yyyy", @"yyyy年MM月dd日", @"HH:mm:ss", @"yyMMddHHmmss", @"yyyy.MM.dd.HH.mm", @"yyyy-MM-dd", @"EEEE", @"MMMM, d",@"HH:mm:ss.SSS",  nil];
        
        _dateFormatterMap = [[NSMutableDictionary alloc]init];

        for (NSString *format in formats)
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:format];
            [_dateFormatterMap setObject:dateFormatter forKey:format];
            [dateFormatter release];
        }
        
        _weekdays = [[NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil] retain];
    }
    return self;
}

- (void)dealloc {
    [_dateFormatterMap release];
    if (_weekdays != nil) {
        [_weekdays release];
    }
    [super dealloc];
}


- (NSString *) formatDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [_dateFormatterMap objectForKey:format];
    if (dateFormatter == nil)
        return nil;
    
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

- (NSString *) formatDate:(NSString *)date from:(NSString*)from to:(NSString*)to
{
    return [self formatDate:[self toDate:date format:from] format:to];
}


- (NSString *) formatDate:(NSDate *)date
{
    return [self formatDate:date format:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *) formatMiliTime:(NSDate *)date
{
    return [self formatDate:date format:@"HH:mm:ss.SSS"];
}


- (NSString *) formatDateWithTimeZone:(NSDate *)date format:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    NSTimeZone* GTMZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    [dateFormatter setTimeZone:GTMZone];
    [dateFormatter setDateFormat:format];
    NSString *result =  [dateFormatter stringFromDate:date];
    return result;
}

- (NSString *) formatDateWithTimeZone:(NSDate *)date 
{
    return [self formatDateWithTimeZone:date format:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSDate *) toDate:(NSString *)date format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [_dateFormatterMap objectForKey:format];
    if (dateFormatter == nil)
        return nil;
    
    NSDate *result = [[dateFormatter dateFromString:date] copy] ;
    return [[result retain] autorelease];
}

- (NSDate *) toDate:(NSString *)date
{
    return [self toDate:date format:@"yyyy-MM-dd HH:mm:ss"];
}

- (BOOL) lessThan:(NSDate *)left to:(NSDate *)right
{
    if (left == nil && right == nil)
        return NO;
    
    if (left == nil)
        return YES;
    
    if (right == nil)
        return NO;
    
    NSDate *compareDate = [left earlierDate:right];
    if ( [compareDate isEqualToDate:left])
    {
        return YES;
    }
    else 
    {
        return NO;
    }
}

- (NSDate *) addSecondsToDate:(NSDate *) date second:(int)seconds
{
    NSDateComponents * components = [[NSDateComponents alloc] init];
    [components setSecond:seconds];
    
    NSDate * result = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
    
    [components release];
    
    return result;
}

- (int) getDayOfWeek:(NSDate *) date
{
    return [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit
                                                   fromDate:date] weekday];
}
    
- (NSString*) getDayOfWeekDescription:(NSDate *) date
{
    int day = [[self formatDate:date format:@"e"] intValue];
    
    return [NSString stringWithFormat:@"%@%@", @"星期", [_weekdays objectAtIndex:day - 1]];
}

@end
