//
//  AppUtil.h
//  protocol
//
//  Created by Cliff on 14-9-3.
//  Copyright (c) 2014年 XPG. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "xpgconnectcli.h"

@interface AppUtil : NSObject

+ (NSString*)byteArray2String:(XpgPacket *) pPacket;

+ (NSData *)byteArray2Data:(XpgPacket *)pPacket;

@end
