//
//  EHElecHeater.m
//  EHHeater-ios
//
//  Created by Danplin on 14-9-9.
//  Copyright (c) 2014年 danplin. All rights reserved.
//

#import "EHElecHeater.h"
#import "EHCommunicator.h"
#import "EHDeviceFeedbackService.h"

@implementation EHElecHeater

#pragma mark -- Public

- (void)sendTurnOnCommand{
    [self turnOnOrOff:YES];
}

- (void)sendTurnOffCommand{
    [self turnOnOrOff:NO];
}

- (void)changeHeaterOnOffStatue:(BOOL)on{
    self.isOn = on;
    [self tellDelegateOnOffStatueChanged];
}

- (void)giveUpDelegate:(id<EHElecHeaterDelegate>)delegate{
    if (self.delegate == delegate) {
        self.delegate = nil;
    }
}

- (void)refreshStatusByData:(NSData *)data{
    BOOL isOn = [deviceFeedback isHeaterOn:data];
    [self changeHeaterOnOffStatue:isOn];
    NSLog(@"设备状态 : %@  data = %@",isOn ? @"开" : @"关 ",[data description]);
}

#pragma mark -- Private

- (void)turnOnOrOff:(BOOL)on{
    [ehCommunicator turnOnOrOff:on ofDevice:self.connId];
}

- (void)tellDelegateOnOffStatueChanged{
    if (self.delegate && [self.delegate respondsToSelector:@selector(elecHeaterStatusChanged:)]) {
        [self.delegate elecHeaterStatusChanged:self];
    }
}

@end
