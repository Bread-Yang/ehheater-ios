//
//  Common.h
//  xUtility
//
//  Created by Cliff on 13-12-18.
//  Copyright (c) 2013年 XPG. All rights reserved.
//

#ifndef xUtility_Common_h
#define xUtility_Common_h


#define SingleInstance(Clazz)           \
+(Clazz*)shareInstance {                \
                                        \
    static Clazz *instance = nil;       \
    static dispatch_once_t _once;       \
                                        \
    dispatch_once(&_once, ^{            \
        instance = [[self alloc] init]; \
    });                                 \
    return instance;                    \
}

#endif
