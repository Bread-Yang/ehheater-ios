#ifndef _XPGCONNECTCLI_H
#define _XPGCONNECTCLI_H 1

/** @file
    1) Onboarding\r\n
    1a) EasyLink\r\n
    1b) Soft AP\r\n
    2) writePi/writePe/writePm\r\n
    3) readPi/readPe/readPm\r\n
    4) Protocol packet build+send & recv+parse automation\r\n
    5) SSL/TLS\r\n
    \r\n
    Onboarding（配置）的基本流程：\r\n
    1) 连接到wifi模块热点AP;\r\n
    2) 获取周边可用wifi接入的列表\r\n
    3) 输入要接入的wifi的ssid与pwd\r\n
    4) 按模块自定义的格式将ssid/pwd写入模块\r\n
    5) 等待模块回应写入结果（一般是成功或失败）\r\n
    6) 转为等待模块回应广播包\r\n
*/

#include <sys/types.h>
#include "xpgconnect_common.h"
#include "utils.h" // included mqtt & ssl
#include "serializer.h"
#include "generated.h"

// == data structs =====================
typedef struct _Attr_t
{
	unsigned short attrId;
    unsigned short dataLen;
    unsigned char data[256];
} Attr_t;

typedef void (*CbOnDeviceFound)(XpgEndpoint * res);
typedef void (*CbOnEasyLinkResp)(XpgEndpoint * res);

typedef struct _XpgMobileContext
{
    char szUid[32];
    char szPwd[32];
    // fixed callbacks
    CbOnDeviceFound onDeviceFound;
    CbOnEasyLinkResp onEasyLinkResp;
} XpgMobileContext;

// == API =============================
// return 0 if success, else return -1

/** @desc 需要用到的基本API应该有：\r\n
    1）xpgcInit()，初始化SDK（须实现初始化要求的各个回调函数作为参数输入）\r\n
    2）xpgcFindDevice()，发出发现广播包（小循环用）\r\n
    2a）onDeviceFound()回调，如果收到设备响应\r\n
    3）xpgcConnect() 或者 xpgcConnectAsync()
        如果有发现设备，可小循环连接之\r\n
        如果没有发现，可走大循环，先连接云端（输入被遥控的设备mac地址）\r\n
    3a) 如果还没有设备的passcode，调用 SendPasscodeReq() 以获取之\r\n
    3b) passcode 将会于 contextGenerated.onPasscodeResp 回调以参数方式被返回\r\n
    4）xpgcLogin()，登录设备\r\n
    4a) 小循环登录结果将会于 contextGenerated.onLanLoginResp 回调中返回\r\n
    4b) 大循环登录结果将会于 XpgCommonContext 结构体的回调 OnLoginCloudResp 中返回\r\n
        PS: XpgCommonContext 结构体的指针应使用 GetContext() 函数获取\r\n
    \r\n
    登录成功后，就是用生成的generated.h中的各个业务逻辑包的操作函数，组成二进制包，再调用xpgcWrite()发指令了。\r\n
    如果设备/云端有响应的话，onTcpPacketl回调会被调用，数据由回调函数的参数给出（一个XpgPacket结构体）。\r\n
    @param
        pContext 手机端配置集，比如client id, 事件回调……\r\n
*/

int xpgcInit(XpgMobileContext * pContext);
XpgMobileContext *GetMobileContext();

/** @desc
        通过 UDP 广播包尝试发现当前局域网（小循环）内可见设备
    @return
        0为发送成功，其他请参见XPG_RESULT
    @remark
        每调用一次，会发送一次发现用广播包。但网络可能存在丢包情况。
    @see
        xpgcBroadcast()
 */
XPG_RESULT xpgcFindDevice();

/** @desc
        向SDK生成时设定的机智云服务器（比如china.xtremeprog.com, m2m.gizwits.com），注册一个用户帐户。
    @return
        int值，若大于0，则为注册用的临时连接号，主要为连接回调时作排除干扰或者扩展提示用。\r\n
        若小于等于0，请参见XPG_RESULT
    @remark
        同步函数，可能会引至界面主线程堵塞。（待增加此API的异步版本）\r\n
        注册结果将于回调 contextGenerated.onUserRegisterResp 中以参数方式返回。\r\n
    @see
        xpgcConnect(), xpgcBroadcast(), XPG_RESULT
 */
XPG_RESULT xpgcRegister(const char * szUid, const char * szPass);

/** @desc
        测试用默认帐户请使用参数：szUid = "guest", szPass = "guest"
*/
XPG_RESULT xpgcLogin(int connId, const char * szUid, const char * szPass);

XPG_RESULT xpgcEnableCtrl(int connId, const char * szDid, const char * szPass);
XPG_RESULT xpgcEnableCtrl2(int connId, const char * szDid, XpgDataField pass);

#endif /* _XPGCONNECTCLI_H */
