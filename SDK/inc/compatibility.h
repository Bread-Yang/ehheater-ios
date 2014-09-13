#ifndef _COMPATIBILITY_H
#define _COMPATIBILITY_H

#include "xpgconnect_common.h"

typedef struct _ConnectDeviceReq_t
{
    unsigned short tcpPort;
    unsigned int nRetry;
    XPG_WAN_LAN mode;
    char addr[MAX_PATH];
    int nConnId;
} ConnectDeviceReq_t;

/** @desc
        连接小循环内设备，一般先通过 xpgcFindDevice() 发现到可连接设备，然后连接。\r\n
        如果是互联网（大循环）连接，还须后续调用 xpgcLogin() 通过云端检验，才能正常使用。
    @return
        return -1 if there is error, else return connId(>=0)
    @see xpgcFindDevice()
    @see xpgcLogin()
 */
int xpgcConnectDevice(ConnectDeviceReq_t req);

/** @desc
        xpgcConnectDevice() 的异步版本，不阻塞调用线程，立即返回。
    @return
        保留，未用，一直为 ERROR_NONE
    @see
        xpgcConnectDevice()
 */
XPG_RESULT xpgcConnectDeviceAsync(ConnectDeviceReq_t req);

/** @desc
        连接互联网 XPG 云端服务（大循环），须后续调用 xpgcLogin() 通过云端检验，才能正常使用\r\n
    @return
        0 ＝ succeed, < 0 if error
    @see
        tcpConnect()
*/
int xpgcConnectCloud(const char * addr, const int port);
XPG_RESULT xpgcConnectCloudAsync(const char * addr, const int port);

/** @desc
        connect to a mqtt cloud service
    @return
        0, succeed
        ERROR_NULL_MAC, null or empty mac is not allowed
        ERROR_GENERAL, connect fail
*/
int xpgcConnectMqtt(const char * addr, const int port, const char * mac, const char * clientId);
XPG_RESULT xpgcConnectMqttAsync(const char * addr, const int port, const char * mac, const char * clientId);

/** @desc
        only for direct connect test only
*/
int xpgcConnectAddr(const char * addr, const int port);
XPG_RESULT xpgcConnectAddrAsync(const char * addr, const int port);

int xpgcConnect2(
    const char * addr,
    const int port,
    const XPG_WAN_LAN mode,
    const XPG_CONN_TYPE connType,
    const char * mac,
    const char * did,
    const char * passcode,
    const dword piVersion);

#endif // _COMPATIBILITY_H