//
//  SdkDelegate.cpp
//  demo
//
//  Created by William Yip on 8/26/14.
//  Copyright (c) 2014 XPG. All rights reserved.
//

#import <iostream>
#include "SdkDelegate.h"
#include "utils.h"
#import "AppUtil.h"


SdkDelegate * SdkDelegate::GetInstance()
{
    if (!pInstance) {
        pInstance = new SdkDelegate();
    }
    return pInstance;
}

SdkDelegate::SdkDelegate()
{
    XpgCommonContext * pCtxCommon = GetContext();
    // common callback(s)
    pCtxCommon->ThreadStarting = SdkDelegate::onThreadStarting;
    pCtxCommon->Inited = SdkDelegate::onInited;
    pCtxCommon->onReleased = SdkDelegate::onReleased;
    pCtxCommon->ThreadExiting = SdkDelegate::onThreadExiting;
    pCtxCommon->OnTcpPacket = SdkDelegate::onTcpPacket;
    pCtxCommon->OnMqttEvent = SdkDelegate::onMqttEvent;
    pCtxCommon->OnLoginCloudResp = SdkDelegate::onLoginCloudResp;
    pCtxCommon->OnCalcChecksum = calcChecksum;
    pCtxCommon->onConnectEvent = SdkDelegate::onConnectEvent;
    pCtxCommon->onVersionEvent = SdkDelegate::onVersionEvent;
    pCtxCommon->onWriteEvent = SdkDelegate::onWriteEvent;

    XpgMobileContext ctxMobile = { 0 };
    // mobile callback(s)
    ctxMobile.onEasyLinkResp = SdkDelegate::onEasyLinkResp;
    ctxMobile.onDeviceFound = SdkDelegate::onDeviceFound;
    xpgcInit(&ctxMobile);
}

void SdkDelegate::onThreadStarting()
{
    printf("%s()\n", __func__);
}

void SdkDelegate::onInited(int result)
{
    printf("%s(), result = %d\n", __func__, result);
}

void SdkDelegate::onReleased(const int result)
{
    printf("%s(), result = %d\n", __func__, result);
}

void SdkDelegate::onThreadExiting()
{
    printf("%s()\n", __func__);
}

int SdkDelegate::onTcpPacket(XpgPacket * pPacket, int connId)
{
    printf("%s()\n", __func__);
    
    if (pPacket && pPacket->dataLen==21)
    {
//        NSString *data = [AppUtil byteArray2String:pPacket];
        NSData *data = [NSData dataWithBytes:pPacket->data length:pPacket->dataLen];
        NSLog(@"设备反馈  = %@",[data description]);
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_DidReceiceResponse object:data];
    }
    
    return ERROR_NONE;
}

void SdkDelegate::onMqttEvent(int connId, int event, void * data)
{
    printf("%s()\n", __func__);
}

int SdkDelegate::onLoginCloudResp(unsigned short result, char * szMac)
{
    printf("%s()\n", __func__);
    return ERROR_NONE;
}

void SdkDelegate::onConnectEvent(int connId, int event)
{
    // demo, see also XPG_RESULT for parameter event
    printf("%s()\n, connection #%d, %s", __func__, connId, xpgErrorString(event));
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_DidConnectDevice object:@(connId) userInfo:nil];
}

void SdkDelegate::onVersionEvent(XPG_VERSION_EVENT_KEY key, int value, int connId)
{
    printf("%s()\n", __func__);
}

void SdkDelegate::onWriteEvent(int result, int connId)
{
    // demo, result of xpgcWrite() / xpgcWriteAsync()
    if (result > 0)
        printf("%s(), connection #%d, sent %d bytes\n", __func__, connId, result);
    else
        printf("%s(), connection #%d, error = %d\n", __func__, connId, result);
}

void SdkDelegate::onDeviceFound(XpgEndpoint * res)
{
    printf("%s()\n", __func__);
    
    // demo, dump found device info
    NSValue *value = [NSValue valueWithPointer:res];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_DidFoundDevice object:value userInfo:nil];
    
    DumpEndpoint(res);
}

void SdkDelegate::onEasyLinkResp(XpgEndpoint * res)
{
    printf("%s()\n", __func__);

    // demo, dump found device info
    DumpEndpoint(res);
}
