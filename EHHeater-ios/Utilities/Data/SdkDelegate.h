//
//  SdkDelegate.h
//  demo
//
//  Created by William Yip on 8/26/14.
//  Copyright (c) 2014 XPG. All rights reserved.
//

#ifndef __demo__SdkDelegate__
#define __demo__SdkDelegate__

extern "C" {
    #include "xpgconnectcli.h"
}

class SdkDelegate
{
public:
    static SdkDelegate * GetInstance();
    // common callbacks
    static void onThreadStarting();
    static void onInited(int result);
    static void onReleased(const int result);
    static void onThreadExiting();
    static int onTcpPacket(XpgPacket * pPacket, int connId);
    static void onMqttEvent(int connId, int event, void * data);
    static int onLoginCloudResp(unsigned short result, char * szMac);
    static void onConnectEvent(int connId, int event);
    static void onVersionEvent(XPG_VERSION_EVENT_KEY key, int value, int connId);
    static void onWriteEvent(int result, int connId);
    // mobile callbacks
    static void onDeviceFound(XpgEndpoint * res);
    static void onEasyLinkResp(XpgEndpoint * res);

    SdkDelegate();
};

static SdkDelegate * pInstance;

#endif /* defined(__demo__SdkDelegate__) */
