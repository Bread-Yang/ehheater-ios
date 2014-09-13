//
//  EasyLink.h
//  EasyLink
//
//  Created by Apple on 13-10-05.
//  Copyright (c) 2013年 Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EasyLinkDelegate;

@interface EasyLink : NSObject

+ (EasyLink*)shareInstance;
- (void)startWithSSID:(NSString *)bSSID password:(NSString *)bpasswd;
- (BOOL)isSearching;
- (void)stop;

@property (retain, nonatomic) id<EasyLinkDelegate> delegate;;

@end

@protocol EasyLinkDelegate <NSObject>

@optional
- (void) didStop;
- (void) isSearching:(long)count;

@end