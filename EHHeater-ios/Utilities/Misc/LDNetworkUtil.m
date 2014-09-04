//
//  LDNetworkUtil.m
//  SmartKitchen
//
//  Created by Lin Dan on 3/24/14.
//  Copyright (c) 2014 danplin. All rights reserved.
//

#import "LDNetworkUtil.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreFoundation/CoreFoundation.h>
#import "Reachability.h"

@interface LDNetworkUtil()

@property (nonatomic, strong) Reachability *reachability;
@property (nonatomic, strong) Reachability *hostReach;

@end

@implementation LDNetworkUtil

#pragma mark -- Life cycle

SingleInstance(LDNetworkUtil);

- (instancetype)init{
    self = [super init];
    if (self) {
        self.reachability = [Reachability reachabilityForInternetConnection];
        NSString *hostName = @"www.baidu.com";
        self.hostReach = [Reachability reachabilityWithHostname:hostName];
        [self addNotificationObserver];
        [self.hostReach startNotifier];
    }
    return self;
}

- (BOOL)canConnectInternet{
    _canConnectInternet = [self isReachableHost];
    return _canConnectInternet;
}

#pragma mark -- Public

- (NSString *)connectedWifiName{
    NSString *name = nil;
    if ([self isWifiConnection]) {
        //如果是连接wifi的，返回wifi名称
        CFArrayRef myArray = CNCopySupportedInterfaces();
        if (myArray != nil) {
            CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
            if (myDict != nil) {
                NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
                name = [dict valueForKey:@"SSID"];
            }
            CFRelease(myArray);
        }
    }
    return name;
}

- (BOOL)isConnectWifiOrWAN{
    return [self.reachability isReachable];
}

- (BOOL)isConnectWifi{
    return [self.reachability isReachableViaWiFi];
}

- (void)reachableDidChanged:(NSNotification *)notify{
    if ([notify object] == self.hostReach) {
        NSLog(@"网络改变 %@",[self netStatusStringOfType:[self.hostReach currentReachabilityStatus]]);
        if (self.delegate && [self.delegate respondsToSelector:@selector(networkDidChangeStatus:)]) {
            [self.delegate networkDidChangeStatus:self];
        }
    }
}

- (void)addNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachableDidChanged:) name:kReachabilityChangedNotification object:nil];
}

- (void)removeNotificationObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)checkNetWorkEnvironment{
    Reachability *reach1 = [Reachability reachabilityForInternetConnection];
    BOOL reachAble = [reach1 isReachable];
    BOOL reachAbleWifi = [reach1 isReachableViaWiFi];
    BOOL reachAbleWAN = [reach1 isReachableViaWWAN];
    
    NetworkStatus status = [self.hostReach currentReachabilityStatus];
    NSLog(@"%@", [self netStatusStringOfType:status]);
    BOOL canHost = [self canConnectInternet];
    NSString *string = [NSString stringWithFormat:@"reach = %@, Wifi = %@, WAN = %@, canBaidu = %@",[self stringOfBool:reachAble],[self stringOfBool:reachAbleWifi],[self stringOfBool:reachAbleWAN],[self stringOfBool:canHost]];
    NSLog(@"%@",string);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:string delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    NSLog(@"Wifi Name = %@",[self connectedWifiName]);
}

#pragma mark -- private

//是否能连接指定主机
- (BOOL)isReachableHost{
    BOOL canBaidu = NO;
    NetworkStatus status = [self.hostReach currentReachabilityStatus];
    switch (status)
    {
        case NotReachable: {
            canBaidu = NO;
            break;
        }
            
        case ReachableViaWWAN:{
            canBaidu = YES;
            break;
        }
        case ReachableViaWiFi:{
            canBaidu = [self isReachableInternet];
            break;
        }
    }
    return canBaidu;
}

- (BOOL)isReachableInternet{
    //是否能上网
//    BOOL can = [self.reachability isReachableViaWWAN];
//    if (!can) {
//        BOOL can = [self.reachability isReachableViaWiFi];
//        if (can) {
            BOOL can = NO;
            NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];//这个URL最好是数据不多的网页，不然会因请求而等待太久
            NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:2];
            NSHTTPURLResponse *response;
            [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: nil];
            can = (response != nil);
//        }
//    }
    return can;
}

- (BOOL)isWifiConnection{
    return [self.reachability isReachableViaWiFi];
}

- (NSString *)netStatusStringOfType:(NetworkStatus)status{
    NSString *result = @"";
    switch (status) {
        case NotReachable:{ result = @"NotReachable"; break;}
        case ReachableViaWiFi:{ result = @"ReachableViaWiFi"; break;}
        case ReachableViaWWAN:{ result = @"ReachableViaWWAN"; break;}
        default:
            break;
    }
    return result;
}

- (NSString *)stringOfBool:(BOOL)value{
    return (value ? @"Yes" : @"No");
}

@end
