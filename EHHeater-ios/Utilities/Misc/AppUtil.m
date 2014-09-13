//
//  AppUtil.m
//  protocol
//
//  Created by Cliff on 14-9-3.
//  Copyright (c) 2014年 XPG. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil

+ (NSString *)byteArray2String:(XpgPacket *) pPacket
{
     NSData *data = [NSData dataWithBytes:pPacket->data length:pPacket->dataLen];
    return [data description];
}
@end
