#ifndef _GENERATED_H
#define _GENERATED_H

#include <stdlib.h> // malloc(), size_t, etc.
#include "xpgconnect_common.h"

#pragma pack(1) // structure align/pack to every byte

/** @file
    根据协议脚本 template.xml 生成的协议消息体处理代码.
*/

#define CLOUD_ADDR "china.xtremeprog.com"
#define CLOUD_PORT (1883)

unsigned int ProcessTcpReq(XpgPacket * pPacket, int connId);
unsigned int ProcessTcpResp(XpgPacket * pPacket, int connId);
unsigned int ProcessUdpReq(XpgPacket * pPacket);
unsigned int ProcessUdpResp(XpgPacket * pPacket);

typedef struct _WriteWifiConfigReq_t
{
    byte			command;
    char			ssid[32];
    char			key[32];
    byte			checksum;
} WriteWifiConfigReq_t;

typedef struct _OnboardingSetReq_t
{
    XpgDataField	ssid;
    XpgDataField	key;
    // HACK: SDK will expose ip addr for udp packets
    char szIp[16];
} OnboardingSetReq_t;

typedef struct _WriteWifiConfigResp_t
{
    byte			command;
    byte			result;
    byte			checksum;
} WriteWifiConfigResp_t;

typedef struct _OnboardingSetResp_t
{
    // HACK: SDK will expose ip addr for udp packets
    char szIp[16];
} OnboardingSetResp_t;

typedef struct _DiscoveryV1Req_t
{
    word			command;
    // HACK: SDK will expose ip addr for udp packets
    char szIp[16];
} DiscoveryV1Req_t;

typedef struct _DiscoveryV3Req_t
{
    // HACK: SDK will expose ip addr for udp packets
    char szIp[16];
} DiscoveryV3Req_t;

typedef struct _DiscoveryV1Resp_t
{
    word			command;
    char			MAC[18];
    word			version;
    // HACK: SDK will expose ip addr for udp packets
    char szIp[16];
} DiscoveryV1Resp_t;

typedef struct _DiscoveryV3Resp_t
{
    XpgDataField	did;
    XpgDataField	mac;
    XpgDataField	fwVer;
    XpgDataField	productKey;
    // HACK: SDK will expose ip addr for udp packets
    char szIp[16];
} DiscoveryV3Resp_t;

typedef struct _EasylinkResp_t
{
    word			command;
    char			MAC[18];
    word			version;
    // HACK: SDK will expose ip addr for udp packets
    char szIp[16];
} EasylinkResp_t;

typedef struct _BootstrapResp_t
{
    XpgDataField	did;
    XpgDataField	mac;
    XpgDataField	fwVer;
    // HACK: SDK will expose ip addr for udp packets
    char szIp[16];
} BootstrapResp_t;

typedef struct _PasscodeReq_t
{
} PasscodeReq_t;

typedef struct _PasscodeResp_t
{
    XpgDataField	passcode;
} PasscodeResp_t;

typedef struct _LanLoginReq_t
{
    XpgDataField	passcode;
} LanLoginReq_t;

typedef struct _LanLoginResp_t
{
    byte			result;
} LanLoginResp_t;

typedef struct _ModuleVersionReq_t
{
} ModuleVersionReq_t;

typedef struct _ModuleVersionResp_t
{
    dword			piVersion;
    XpgDataField	p0Version;
} ModuleVersionResp_t;

typedef struct _WifiListReq_t
{
} WifiListReq_t;

typedef struct _WifiListResp_t
{
    XpgDataField	ssid;
    byte			signalIntensity;
} WifiListResp_t;

typedef struct _SerialPortConfigReq_t
{
    dword			bps;
    byte			stopBit;
    byte			dataLen;
    byte			parity;
    byte			flowControl;
} SerialPortConfigReq_t;

typedef struct _SerialPortConfigResp_t
{
    byte			result;
} SerialPortConfigResp_t;

typedef struct _UserRegisterReq_t
{
    XpgDataField	uid;
    XpgDataField	pwd;
} UserRegisterReq_t;

typedef struct _UserRegisterResp_t
{
    byte			result;
} UserRegisterResp_t;

typedef struct _BindingSetReq_t
{
    XpgDataField	did;
    XpgDataField	passcode;
} BindingSetReq_t;

typedef struct _BindingSetResp_t
{
    byte			result;
} BindingSetResp_t;

typedef struct _BindingGetReq_t
{
} BindingGetReq_t;

typedef struct _BindingGetResp_t
{
    XpgDataField	did;
    XpgDataField	mac;
    XpgDataField	passcode;
    byte			isOnline;
    dword			piVersion;
    XpgDataField	p0Version;
} BindingGetResp_t;

typedef struct _UserPwdChangeReq_t
{
    XpgDataField	uid;
    XpgDataField	pwd;
} UserPwdChangeReq_t;

typedef struct _UserPwdChangeResp_t
{
    byte			result;
} UserPwdChangeResp_t;

typedef struct _BindingDelReq_t
{
    XpgDataField	did;
} BindingDelReq_t;

typedef struct _BindingDelResp_t
{
    byte			result;
} BindingDelResp_t;

typedef struct _ReadWifiConfigReq_t
{
    byte			command;
    byte			checksum;
} ReadWifiConfigReq_t;

typedef struct _ReadWifiConfigResp_t
{
    byte			command;
    char			ssid[32];
    char			key[32];
    byte			checksum;
} ReadWifiConfigResp_t;

typedef struct _DeviceOnlineStateResp_t
{
    XpgDataField	mac;
    XpgDataField	passcode;
    byte			isOnline;
    dword			piVersion;
    XpgDataField	p0Version;
} DeviceOnlineStateResp_t;

typedef struct _StateResp_t
{
    word			header;
    byte			p0_version;
    byte			resp_address;
    byte			command;
    byte			on_off;
    byte			system_running_state;
    byte			function_state;
    byte			order_state;
    byte			inner1_temp;
    byte			inner2_temp;
    byte			inner3_temp;
    word			checksum;
} StateResp_t;

typedef struct _HeartbeatResp_t
{
    word			header;
    byte			p0_version;
    byte			resp_address;
    byte			command;
    word			checksum;
} HeartbeatResp_t;

typedef struct _OnOffReq_t
{
    word			header;
    byte			p0_version;
    byte			resp_address;
    byte			command;
    byte			on_off;
    word			checksum;
} OnOffReq_t;

typedef struct _PatternSettingReq_t
{
    word			header;
    byte			p0_version;
    byte			resp_address;
    byte			command;
    byte			pattern_setting;
    word			checksum;
} PatternSettingReq_t;

typedef struct _SettingWaterTempReq_t
{
    word			header;
    byte			p0_version;
    byte			resp_address;
    byte			command;
    byte			setting_water_temp;
    word			checksum;
} SettingWaterTempReq_t;

typedef struct _SettingPowerReq_t
{
    word			header;
    byte			p0_version;
    byte			resp_address;
    byte			command;
    byte			setting_power;
    word			checksum;
} SettingPowerReq_t;

typedef struct _SettingOrderReq_t
{
    word			header;
    byte			p0_version;
    byte			resp_address;
    byte			command;
    byte			order_hour;
    byte			order_minute;
    word			checksum;
} SettingOrderReq_t;

typedef struct _StateReq_t
{
    word			header;
    byte			p0_version;
    byte			resp_address;
    byte			command;
    word			checksum;
} StateReq_t;

typedef void (*CbOnWriteWifiConfigReq)(size_t count, WriteWifiConfigReq_t * pWriteWifiConfigReq, int nConnId);
typedef void (*CbOnOnboardingSetReq)(size_t count, OnboardingSetReq_t * pOnboardingSetReq);
typedef void (*CbOnWriteWifiConfigResp)(size_t count, WriteWifiConfigResp_t * pWriteWifiConfigResp, int nConnId);
typedef void (*CbOnOnboardingSetResp)(size_t count, OnboardingSetResp_t * pOnboardingSetResp);
typedef void (*CbOnDiscoveryV1Req)(size_t count, DiscoveryV1Req_t * pDiscoveryV1Req);
typedef void (*CbOnDiscoveryV3Req)(size_t count, DiscoveryV3Req_t * pDiscoveryV3Req);
typedef void (*CbOnDiscoveryV1Resp)(size_t count, DiscoveryV1Resp_t * pDiscoveryV1Resp);
typedef void (*CbOnDiscoveryV3Resp)(size_t count, DiscoveryV3Resp_t * pDiscoveryV3Resp);
typedef void (*CbOnEasylinkResp)(size_t count, EasylinkResp_t * pEasylinkResp);
typedef void (*CbOnBootstrapResp)(size_t count, BootstrapResp_t * pBootstrapResp);
typedef void (*CbOnPasscodeReq)(size_t count, PasscodeReq_t * pPasscodeReq, int nConnId);
typedef void (*CbOnPasscodeResp)(size_t count, PasscodeResp_t * pPasscodeResp, int nConnId);
typedef void (*CbOnLanLoginReq)(size_t count, LanLoginReq_t * pLanLoginReq, int nConnId);
typedef void (*CbOnLanLoginResp)(size_t count, LanLoginResp_t * pLanLoginResp, int nConnId);
typedef void (*CbOnModuleVersionReq)(size_t count, ModuleVersionReq_t * pModuleVersionReq, int nConnId);
typedef void (*CbOnModuleVersionResp)(size_t count, ModuleVersionResp_t * pModuleVersionResp, int nConnId);
typedef void (*CbOnWifiListReq)(size_t count, WifiListReq_t * pWifiListReq, int nConnId);
typedef void (*CbOnWifiListResp)(size_t count, WifiListResp_t * pWifiListResp, int nConnId);
typedef void (*CbOnSerialPortConfigReq)(size_t count, SerialPortConfigReq_t * pSerialPortConfigReq, int nConnId);
typedef void (*CbOnSerialPortConfigResp)(size_t count, SerialPortConfigResp_t * pSerialPortConfigResp, int nConnId);
typedef void (*CbOnUserRegisterReq)(size_t count, UserRegisterReq_t * pUserRegisterReq, int nConnId);
typedef void (*CbOnUserRegisterResp)(size_t count, UserRegisterResp_t * pUserRegisterResp, int nConnId);
typedef void (*CbOnBindingSetReq)(size_t count, BindingSetReq_t * pBindingSetReq, int nConnId);
typedef void (*CbOnBindingSetResp)(size_t count, BindingSetResp_t * pBindingSetResp, int nConnId);
typedef void (*CbOnBindingGetReq)(size_t count, BindingGetReq_t * pBindingGetReq, int nConnId);
typedef void (*CbOnBindingGetResp)(size_t count, BindingGetResp_t * pBindingGetResp, int nConnId);
typedef void (*CbOnUserPwdChangeReq)(size_t count, UserPwdChangeReq_t * pUserPwdChangeReq, int nConnId);
typedef void (*CbOnUserPwdChangeResp)(size_t count, UserPwdChangeResp_t * pUserPwdChangeResp, int nConnId);
typedef void (*CbOnBindingDelReq)(size_t count, BindingDelReq_t * pBindingDelReq, int nConnId);
typedef void (*CbOnBindingDelResp)(size_t count, BindingDelResp_t * pBindingDelResp, int nConnId);
typedef void (*CbOnReadWifiConfigReq)(size_t count, ReadWifiConfigReq_t * pReadWifiConfigReq, int nConnId);
typedef void (*CbOnReadWifiConfigResp)(size_t count, ReadWifiConfigResp_t * pReadWifiConfigResp, int nConnId);
typedef void (*CbOnDeviceOnlineStateResp)(size_t count, DeviceOnlineStateResp_t * pDeviceOnlineStateResp, int nConnId);
typedef void (*CbOnStateResp)(size_t count, StateResp_t * pStateResp, int nConnId);
typedef void (*CbOnHeartbeatResp)(size_t count, HeartbeatResp_t * pHeartbeatResp, int nConnId);
typedef void (*CbOnOnOffReq)(size_t count, OnOffReq_t * pOnOffReq, int nConnId);
typedef void (*CbOnPatternSettingReq)(size_t count, PatternSettingReq_t * pPatternSettingReq, int nConnId);
typedef void (*CbOnSettingWaterTempReq)(size_t count, SettingWaterTempReq_t * pSettingWaterTempReq, int nConnId);
typedef void (*CbOnSettingPowerReq)(size_t count, SettingPowerReq_t * pSettingPowerReq, int nConnId);
typedef void (*CbOnSettingOrderReq)(size_t count, SettingOrderReq_t * pSettingOrderReq, int nConnId);
typedef void (*CbOnStateReq)(size_t count, StateReq_t * pStateReq, int nConnId);
typedef struct _XpgGeneratedContext
{
    CbOnWriteWifiConfigReq onWriteWifiConfigReq;
    CbOnWriteWifiConfigReq onInternalWriteWifiConfigReq;
    CbOnOnboardingSetReq onOnboardingSetReq;
    CbOnOnboardingSetReq onInternalOnboardingSetReq;
    CbOnWriteWifiConfigResp onWriteWifiConfigResp;
    CbOnWriteWifiConfigResp onInternalWriteWifiConfigResp;
    CbOnOnboardingSetResp onOnboardingSetResp;
    CbOnOnboardingSetResp onInternalOnboardingSetResp;
    CbOnDiscoveryV1Req onDiscoveryV1Req;
    CbOnDiscoveryV1Req onInternalDiscoveryV1Req;
    CbOnDiscoveryV3Req onDiscoveryV3Req;
    CbOnDiscoveryV3Req onInternalDiscoveryV3Req;
    CbOnDiscoveryV1Resp onDiscoveryV1Resp;
    CbOnDiscoveryV1Resp onInternalDiscoveryV1Resp;
    CbOnDiscoveryV3Resp onDiscoveryV3Resp;
    CbOnDiscoveryV3Resp onInternalDiscoveryV3Resp;
    CbOnEasylinkResp onEasylinkResp;
    CbOnEasylinkResp onInternalEasylinkResp;
    CbOnBootstrapResp onBootstrapResp;
    CbOnBootstrapResp onInternalBootstrapResp;
    CbOnPasscodeReq onPasscodeReq;
    CbOnPasscodeReq onInternalPasscodeReq;
    CbOnPasscodeResp onPasscodeResp;
    CbOnPasscodeResp onInternalPasscodeResp;
    CbOnLanLoginReq onLanLoginReq;
    CbOnLanLoginReq onInternalLanLoginReq;
    CbOnLanLoginResp onLanLoginResp;
    CbOnLanLoginResp onInternalLanLoginResp;
    CbOnModuleVersionReq onModuleVersionReq;
    CbOnModuleVersionReq onInternalModuleVersionReq;
    CbOnModuleVersionResp onModuleVersionResp;
    CbOnModuleVersionResp onInternalModuleVersionResp;
    CbOnWifiListReq onWifiListReq;
    CbOnWifiListReq onInternalWifiListReq;
    CbOnWifiListResp onWifiListResp;
    CbOnWifiListResp onInternalWifiListResp;
    CbOnSerialPortConfigReq onSerialPortConfigReq;
    CbOnSerialPortConfigReq onInternalSerialPortConfigReq;
    CbOnSerialPortConfigResp onSerialPortConfigResp;
    CbOnSerialPortConfigResp onInternalSerialPortConfigResp;
    CbOnUserRegisterReq onUserRegisterReq;
    CbOnUserRegisterReq onInternalUserRegisterReq;
    CbOnUserRegisterResp onUserRegisterResp;
    CbOnUserRegisterResp onInternalUserRegisterResp;
    CbOnBindingSetReq onBindingSetReq;
    CbOnBindingSetReq onInternalBindingSetReq;
    CbOnBindingSetResp onBindingSetResp;
    CbOnBindingSetResp onInternalBindingSetResp;
    CbOnBindingGetReq onBindingGetReq;
    CbOnBindingGetReq onInternalBindingGetReq;
    CbOnBindingGetResp onBindingGetResp;
    CbOnBindingGetResp onInternalBindingGetResp;
    CbOnUserPwdChangeReq onUserPwdChangeReq;
    CbOnUserPwdChangeReq onInternalUserPwdChangeReq;
    CbOnUserPwdChangeResp onUserPwdChangeResp;
    CbOnUserPwdChangeResp onInternalUserPwdChangeResp;
    CbOnBindingDelReq onBindingDelReq;
    CbOnBindingDelReq onInternalBindingDelReq;
    CbOnBindingDelResp onBindingDelResp;
    CbOnBindingDelResp onInternalBindingDelResp;
    CbOnReadWifiConfigReq onReadWifiConfigReq;
    CbOnReadWifiConfigReq onInternalReadWifiConfigReq;
    CbOnReadWifiConfigResp onReadWifiConfigResp;
    CbOnReadWifiConfigResp onInternalReadWifiConfigResp;
    CbOnDeviceOnlineStateResp onDeviceOnlineStateResp;
    CbOnDeviceOnlineStateResp onInternalDeviceOnlineStateResp;
    CbOnStateResp onStateResp;
    CbOnStateResp onInternalStateResp;
    CbOnHeartbeatResp onHeartbeatResp;
    CbOnHeartbeatResp onInternalHeartbeatResp;
    CbOnOnOffReq onOnOffReq;
    CbOnOnOffReq onInternalOnOffReq;
    CbOnPatternSettingReq onPatternSettingReq;
    CbOnPatternSettingReq onInternalPatternSettingReq;
    CbOnSettingWaterTempReq onSettingWaterTempReq;
    CbOnSettingWaterTempReq onInternalSettingWaterTempReq;
    CbOnSettingPowerReq onSettingPowerReq;
    CbOnSettingPowerReq onInternalSettingPowerReq;
    CbOnSettingOrderReq onSettingOrderReq;
    CbOnSettingOrderReq onInternalSettingOrderReq;
    CbOnStateReq onStateReq;
    CbOnStateReq onInternalStateReq;
} XpgGeneratedContext;
extern XpgGeneratedContext contextGenerated;

void GetBuffer(void * buf, size_t len);
XpgDataField * String2XpgData(char * str);
char * XpgData2String(XpgDataField * field);

int DefaultWriteWifiConfigReq();
int BuildWriteWifiConfigReq(char * ssid, char * key);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseWriteWifiConfigReq(XpgPacket * pPacket, size_t * pCount, WriteWifiConfigReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendWriteWifiConfigReq(int nConnId, char * ssid, char * key);
int SendWriteWifiConfigReqByPtr(int nConnId, WriteWifiConfigReq_t * pWriteWifiConfigReq);
void DumpWriteWifiConfigReq(WriteWifiConfigReq_t * pWriteWifiConfigReq);
size_t InputWriteWifiConfigReq();

int DefaultOnboardingSetReq();
int BuildOnboardingSetReq(XpgDataField * ssid, XpgDataField * key);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseOnboardingSetReq(XpgPacket * pPacket, size_t * pCount, OnboardingSetReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendOnboardingSetReq(XpgDataField * ssid, XpgDataField * key);
int SendOnboardingSetReqByPtr(int nConnId, OnboardingSetReq_t * pOnboardingSetReq);
void DumpOnboardingSetReq(OnboardingSetReq_t * pOnboardingSetReq);
size_t InputOnboardingSetReq();

int DefaultWriteWifiConfigResp();
int BuildWriteWifiConfigResp();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseWriteWifiConfigResp(XpgPacket * pPacket, size_t * pCount, WriteWifiConfigResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendWriteWifiConfigResp(int nConnId);
int SendWriteWifiConfigRespByPtr(int nConnId, WriteWifiConfigResp_t * pWriteWifiConfigResp);
void DumpWriteWifiConfigResp(WriteWifiConfigResp_t * pWriteWifiConfigResp);
size_t InputWriteWifiConfigResp();

int DefaultOnboardingSetResp();
int BuildOnboardingSetResp();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseOnboardingSetResp(XpgPacket * pPacket, size_t * pCount, OnboardingSetResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendOnboardingSetResp();
int SendOnboardingSetRespByPtr(int nConnId, OnboardingSetResp_t * pOnboardingSetResp);
void DumpOnboardingSetResp(OnboardingSetResp_t * pOnboardingSetResp);
size_t InputOnboardingSetResp();

int DefaultDiscoveryV1Req();
int BuildDiscoveryV1Req();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseDiscoveryV1Req(XpgPacket * pPacket, size_t * pCount, DiscoveryV1Req_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendDiscoveryV1Req();
int SendDiscoveryV1ReqByPtr(int nConnId, DiscoveryV1Req_t * pDiscoveryV1Req);
void DumpDiscoveryV1Req(DiscoveryV1Req_t * pDiscoveryV1Req);
size_t InputDiscoveryV1Req();

int DefaultDiscoveryV3Req();
int BuildDiscoveryV3Req();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseDiscoveryV3Req(XpgPacket * pPacket, size_t * pCount, DiscoveryV3Req_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendDiscoveryV3Req();
int SendDiscoveryV3ReqByPtr(int nConnId, DiscoveryV3Req_t * pDiscoveryV3Req);
void DumpDiscoveryV3Req(DiscoveryV3Req_t * pDiscoveryV3Req);
size_t InputDiscoveryV3Req();

int DefaultDiscoveryV1Resp();
int BuildDiscoveryV1Resp(char * MAC);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseDiscoveryV1Resp(XpgPacket * pPacket, size_t * pCount, DiscoveryV1Resp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendDiscoveryV1Resp(char * MAC);
int SendDiscoveryV1RespByPtr(int nConnId, DiscoveryV1Resp_t * pDiscoveryV1Resp);
void DumpDiscoveryV1Resp(DiscoveryV1Resp_t * pDiscoveryV1Resp);
size_t InputDiscoveryV1Resp();

int DefaultDiscoveryV3Resp();
int BuildDiscoveryV3Resp(XpgDataField * did, XpgDataField * mac, XpgDataField * fwVer, XpgDataField * productKey);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseDiscoveryV3Resp(XpgPacket * pPacket, size_t * pCount, DiscoveryV3Resp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendDiscoveryV3Resp(XpgDataField * did, XpgDataField * mac, XpgDataField * fwVer, XpgDataField * productKey);
int SendDiscoveryV3RespByPtr(int nConnId, DiscoveryV3Resp_t * pDiscoveryV3Resp);
void DumpDiscoveryV3Resp(DiscoveryV3Resp_t * pDiscoveryV3Resp);
size_t InputDiscoveryV3Resp();

int DefaultEasylinkResp();
int BuildEasylinkResp(char * MAC);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseEasylinkResp(XpgPacket * pPacket, size_t * pCount, EasylinkResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendEasylinkResp(char * MAC);
int SendEasylinkRespByPtr(int nConnId, EasylinkResp_t * pEasylinkResp);
void DumpEasylinkResp(EasylinkResp_t * pEasylinkResp);
size_t InputEasylinkResp();

int DefaultBootstrapResp();
int BuildBootstrapResp(XpgDataField * did, XpgDataField * mac, XpgDataField * fwVer);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseBootstrapResp(XpgPacket * pPacket, size_t * pCount, BootstrapResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendBootstrapResp(XpgDataField * did, XpgDataField * mac, XpgDataField * fwVer);
int SendBootstrapRespByPtr(int nConnId, BootstrapResp_t * pBootstrapResp);
void DumpBootstrapResp(BootstrapResp_t * pBootstrapResp);
size_t InputBootstrapResp();

int DefaultPasscodeReq();
int BuildPasscodeReq();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParsePasscodeReq(XpgPacket * pPacket, size_t * pCount, PasscodeReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendPasscodeReq(int nConnId);
int SendPasscodeReqByPtr(int nConnId, PasscodeReq_t * pPasscodeReq);
void DumpPasscodeReq(PasscodeReq_t * pPasscodeReq);
size_t InputPasscodeReq();

int DefaultPasscodeResp();
int BuildPasscodeResp(XpgDataField * passcode);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParsePasscodeResp(XpgPacket * pPacket, size_t * pCount, PasscodeResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendPasscodeResp(int nConnId, XpgDataField * passcode);
int SendPasscodeRespByPtr(int nConnId, PasscodeResp_t * pPasscodeResp);
void DumpPasscodeResp(PasscodeResp_t * pPasscodeResp);
size_t InputPasscodeResp();

int DefaultLanLoginReq();
int BuildLanLoginReq(XpgDataField * passcode);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseLanLoginReq(XpgPacket * pPacket, size_t * pCount, LanLoginReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendLanLoginReq(int nConnId, XpgDataField * passcode);
int SendLanLoginReqByPtr(int nConnId, LanLoginReq_t * pLanLoginReq);
void DumpLanLoginReq(LanLoginReq_t * pLanLoginReq);
size_t InputLanLoginReq();

int DefaultLanLoginResp();
int BuildLanLoginResp(byte result);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseLanLoginResp(XpgPacket * pPacket, size_t * pCount, LanLoginResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendLanLoginResp(int nConnId, byte result);
int SendLanLoginRespByPtr(int nConnId, LanLoginResp_t * pLanLoginResp);
void DumpLanLoginResp(LanLoginResp_t * pLanLoginResp);
size_t InputLanLoginResp();

int DefaultModuleVersionReq();
int BuildModuleVersionReq();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseModuleVersionReq(XpgPacket * pPacket, size_t * pCount, ModuleVersionReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendModuleVersionReq(int nConnId);
int SendModuleVersionReqByPtr(int nConnId, ModuleVersionReq_t * pModuleVersionReq);
void DumpModuleVersionReq(ModuleVersionReq_t * pModuleVersionReq);
size_t InputModuleVersionReq();

int DefaultModuleVersionResp();
int BuildModuleVersionResp(dword piVersion, XpgDataField * p0Version);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseModuleVersionResp(XpgPacket * pPacket, size_t * pCount, ModuleVersionResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendModuleVersionResp(int nConnId, dword piVersion, XpgDataField * p0Version);
int SendModuleVersionRespByPtr(int nConnId, ModuleVersionResp_t * pModuleVersionResp);
void DumpModuleVersionResp(ModuleVersionResp_t * pModuleVersionResp);
size_t InputModuleVersionResp();

int DefaultWifiListReq();
int BuildWifiListReq();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseWifiListReq(XpgPacket * pPacket, size_t * pCount, WifiListReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendWifiListReq(int nConnId);
int SendWifiListReqByPtr(int nConnId, WifiListReq_t * pWifiListReq);
void DumpWifiListReq(WifiListReq_t * pWifiListReq);
size_t InputWifiListReq();

int DefaultWifiListResp();
int BuildWifiListResp(XpgDataField * ssid, byte signalIntensity);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseWifiListResp(XpgPacket * pPacket, size_t * pCount, WifiListResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendWifiListResp(int nConnId, XpgDataField * ssid, byte signalIntensity);
int SendWifiListRespByPtr(int nConnId, WifiListResp_t * pWifiListResp);
void DumpWifiListResp(WifiListResp_t * pWifiListResp);
size_t InputWifiListResp();

int DefaultSerialPortConfigReq();
int BuildSerialPortConfigReq(dword bps, byte stopBit, byte dataLen, byte parity, byte flowControl);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseSerialPortConfigReq(XpgPacket * pPacket, size_t * pCount, SerialPortConfigReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendSerialPortConfigReq(int nConnId, dword bps, byte stopBit, byte dataLen, byte parity, byte flowControl);
int SendSerialPortConfigReqByPtr(int nConnId, SerialPortConfigReq_t * pSerialPortConfigReq);
void DumpSerialPortConfigReq(SerialPortConfigReq_t * pSerialPortConfigReq);
size_t InputSerialPortConfigReq();

int DefaultSerialPortConfigResp();
int BuildSerialPortConfigResp(byte result);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseSerialPortConfigResp(XpgPacket * pPacket, size_t * pCount, SerialPortConfigResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendSerialPortConfigResp(int nConnId, byte result);
int SendSerialPortConfigRespByPtr(int nConnId, SerialPortConfigResp_t * pSerialPortConfigResp);
void DumpSerialPortConfigResp(SerialPortConfigResp_t * pSerialPortConfigResp);
size_t InputSerialPortConfigResp();

int DefaultUserRegisterReq();
int BuildUserRegisterReq(XpgDataField * uid, XpgDataField * pwd);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseUserRegisterReq(XpgPacket * pPacket, size_t * pCount, UserRegisterReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendUserRegisterReq(int nConnId, XpgDataField * uid, XpgDataField * pwd);
int SendUserRegisterReqByPtr(int nConnId, UserRegisterReq_t * pUserRegisterReq);
void DumpUserRegisterReq(UserRegisterReq_t * pUserRegisterReq);
size_t InputUserRegisterReq();

int DefaultUserRegisterResp();
int BuildUserRegisterResp(byte result);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseUserRegisterResp(XpgPacket * pPacket, size_t * pCount, UserRegisterResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendUserRegisterResp(int nConnId, byte result);
int SendUserRegisterRespByPtr(int nConnId, UserRegisterResp_t * pUserRegisterResp);
void DumpUserRegisterResp(UserRegisterResp_t * pUserRegisterResp);
size_t InputUserRegisterResp();

int DefaultBindingSetReq();
int BuildBindingSetReq(XpgDataField * did, XpgDataField * passcode);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseBindingSetReq(XpgPacket * pPacket, size_t * pCount, BindingSetReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendBindingSetReq(int nConnId, XpgDataField * did, XpgDataField * passcode);
int SendBindingSetReqByPtr(int nConnId, BindingSetReq_t * pBindingSetReq);
void DumpBindingSetReq(BindingSetReq_t * pBindingSetReq);
size_t InputBindingSetReq();

int DefaultBindingSetResp();
int BuildBindingSetResp(byte result);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseBindingSetResp(XpgPacket * pPacket, size_t * pCount, BindingSetResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendBindingSetResp(int nConnId, byte result);
int SendBindingSetRespByPtr(int nConnId, BindingSetResp_t * pBindingSetResp);
void DumpBindingSetResp(BindingSetResp_t * pBindingSetResp);
size_t InputBindingSetResp();

int DefaultBindingGetReq();
int BuildBindingGetReq();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseBindingGetReq(XpgPacket * pPacket, size_t * pCount, BindingGetReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendBindingGetReq(int nConnId);
int SendBindingGetReqByPtr(int nConnId, BindingGetReq_t * pBindingGetReq);
void DumpBindingGetReq(BindingGetReq_t * pBindingGetReq);
size_t InputBindingGetReq();

int DefaultBindingGetResp();
int BuildBindingGetResp(XpgDataField * did, XpgDataField * mac, XpgDataField * passcode, byte isOnline, dword piVersion, XpgDataField * p0Version);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseBindingGetResp(XpgPacket * pPacket, size_t * pCount, BindingGetResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendBindingGetResp(int nConnId, XpgDataField * did, XpgDataField * mac, XpgDataField * passcode, byte isOnline, dword piVersion, XpgDataField * p0Version);
int SendBindingGetRespByPtr(int nConnId, BindingGetResp_t * pBindingGetResp);
void DumpBindingGetResp(BindingGetResp_t * pBindingGetResp);
size_t InputBindingGetResp();

int DefaultUserPwdChangeReq();
int BuildUserPwdChangeReq(XpgDataField * uid, XpgDataField * pwd);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseUserPwdChangeReq(XpgPacket * pPacket, size_t * pCount, UserPwdChangeReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendUserPwdChangeReq(int nConnId, XpgDataField * uid, XpgDataField * pwd);
int SendUserPwdChangeReqByPtr(int nConnId, UserPwdChangeReq_t * pUserPwdChangeReq);
void DumpUserPwdChangeReq(UserPwdChangeReq_t * pUserPwdChangeReq);
size_t InputUserPwdChangeReq();

int DefaultUserPwdChangeResp();
int BuildUserPwdChangeResp(byte result);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseUserPwdChangeResp(XpgPacket * pPacket, size_t * pCount, UserPwdChangeResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendUserPwdChangeResp(int nConnId, byte result);
int SendUserPwdChangeRespByPtr(int nConnId, UserPwdChangeResp_t * pUserPwdChangeResp);
void DumpUserPwdChangeResp(UserPwdChangeResp_t * pUserPwdChangeResp);
size_t InputUserPwdChangeResp();

int DefaultBindingDelReq();
int BuildBindingDelReq(XpgDataField * did);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseBindingDelReq(XpgPacket * pPacket, size_t * pCount, BindingDelReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendBindingDelReq(int nConnId, XpgDataField * did);
int SendBindingDelReqByPtr(int nConnId, BindingDelReq_t * pBindingDelReq);
void DumpBindingDelReq(BindingDelReq_t * pBindingDelReq);
size_t InputBindingDelReq();

int DefaultBindingDelResp();
int BuildBindingDelResp(byte result);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseBindingDelResp(XpgPacket * pPacket, size_t * pCount, BindingDelResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendBindingDelResp(int nConnId, byte result);
int SendBindingDelRespByPtr(int nConnId, BindingDelResp_t * pBindingDelResp);
void DumpBindingDelResp(BindingDelResp_t * pBindingDelResp);
size_t InputBindingDelResp();

int DefaultReadWifiConfigReq();
int BuildReadWifiConfigReq();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseReadWifiConfigReq(XpgPacket * pPacket, size_t * pCount, ReadWifiConfigReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendReadWifiConfigReq(int nConnId);
int SendReadWifiConfigReqByPtr(int nConnId, ReadWifiConfigReq_t * pReadWifiConfigReq);
void DumpReadWifiConfigReq(ReadWifiConfigReq_t * pReadWifiConfigReq);
size_t InputReadWifiConfigReq();

int DefaultReadWifiConfigResp();
int BuildReadWifiConfigResp(char * ssid, char * key);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseReadWifiConfigResp(XpgPacket * pPacket, size_t * pCount, ReadWifiConfigResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendReadWifiConfigResp(int nConnId, char * ssid, char * key);
int SendReadWifiConfigRespByPtr(int nConnId, ReadWifiConfigResp_t * pReadWifiConfigResp);
void DumpReadWifiConfigResp(ReadWifiConfigResp_t * pReadWifiConfigResp);
size_t InputReadWifiConfigResp();

int DefaultDeviceOnlineStateResp();
int BuildDeviceOnlineStateResp(XpgDataField * mac, XpgDataField * passcode, byte isOnline, XpgDataField * p0Version);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseDeviceOnlineStateResp(XpgPacket * pPacket, size_t * pCount, DeviceOnlineStateResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendDeviceOnlineStateResp(int nConnId, XpgDataField * mac, XpgDataField * passcode, byte isOnline, XpgDataField * p0Version);
int SendDeviceOnlineStateRespByPtr(int nConnId, DeviceOnlineStateResp_t * pDeviceOnlineStateResp);
void DumpDeviceOnlineStateResp(DeviceOnlineStateResp_t * pDeviceOnlineStateResp);
size_t InputDeviceOnlineStateResp();

int DefaultStateResp();
int BuildStateResp(byte on_off, byte system_running_state, byte function_state, byte order_state, byte inner1_temp, byte inner2_temp, byte inner3_temp);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseStateResp(XpgPacket * pPacket, size_t * pCount, StateResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendStateResp(int nConnId, byte on_off, byte system_running_state, byte function_state, byte order_state, byte inner1_temp, byte inner2_temp, byte inner3_temp);
int SendStateRespByPtr(int nConnId, StateResp_t * pStateResp);
void DumpStateResp(StateResp_t * pStateResp);
size_t InputStateResp();

int DefaultHeartbeatResp();
int BuildHeartbeatResp();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseHeartbeatResp(XpgPacket * pPacket, size_t * pCount, HeartbeatResp_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendHeartbeatResp(int nConnId);
int SendHeartbeatRespByPtr(int nConnId, HeartbeatResp_t * pHeartbeatResp);
void DumpHeartbeatResp(HeartbeatResp_t * pHeartbeatResp);
size_t InputHeartbeatResp();

int DefaultOnOffReq();
int BuildOnOffReq(byte on_off);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseOnOffReq(XpgPacket * pPacket, size_t * pCount, OnOffReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendOnOffReq(int nConnId, byte on_off);
int SendOnOffReqByPtr(int nConnId, OnOffReq_t * pOnOffReq);
void DumpOnOffReq(OnOffReq_t * pOnOffReq);
size_t InputOnOffReq();

int DefaultPatternSettingReq();
int BuildPatternSettingReq(byte pattern_setting);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParsePatternSettingReq(XpgPacket * pPacket, size_t * pCount, PatternSettingReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendPatternSettingReq(int nConnId, byte pattern_setting);
int SendPatternSettingReqByPtr(int nConnId, PatternSettingReq_t * pPatternSettingReq);
void DumpPatternSettingReq(PatternSettingReq_t * pPatternSettingReq);
size_t InputPatternSettingReq();

int DefaultSettingWaterTempReq();
int BuildSettingWaterTempReq(byte setting_water_temp);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseSettingWaterTempReq(XpgPacket * pPacket, size_t * pCount, SettingWaterTempReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendSettingWaterTempReq(int nConnId, byte setting_water_temp);
int SendSettingWaterTempReqByPtr(int nConnId, SettingWaterTempReq_t * pSettingWaterTempReq);
void DumpSettingWaterTempReq(SettingWaterTempReq_t * pSettingWaterTempReq);
size_t InputSettingWaterTempReq();

int DefaultSettingPowerReq();
int BuildSettingPowerReq(byte setting_power);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseSettingPowerReq(XpgPacket * pPacket, size_t * pCount, SettingPowerReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendSettingPowerReq(int nConnId, byte setting_power);
int SendSettingPowerReqByPtr(int nConnId, SettingPowerReq_t * pSettingPowerReq);
void DumpSettingPowerReq(SettingPowerReq_t * pSettingPowerReq);
size_t InputSettingPowerReq();

int DefaultSettingOrderReq();
int BuildSettingOrderReq(byte order_hour, byte order_minute);
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseSettingOrderReq(XpgPacket * pPacket, size_t * pCount, SettingOrderReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendSettingOrderReq(int nConnId, byte order_hour, byte order_minute);
int SendSettingOrderReqByPtr(int nConnId, SettingOrderReq_t * pSettingOrderReq);
void DumpSettingOrderReq(SettingOrderReq_t * pSettingOrderReq);
size_t InputSettingOrderReq();

int DefaultStateReq();
int BuildStateReq();
/** @desc generate a copy of parsed result for external usage, like android
    so receiver like ParseXxxx() callers and callback receivers
    should handle the memory self
**/
void ParseStateReq(XpgPacket * pPacket, size_t * pCount, StateReq_t ** pArray);
/** @return
        if succeed, return size of sent request (>0).
        if failed, return a XPG_RESULT enum value (<=0)    @see XPG_RESULT
 */
int SendStateReq(int nConnId);
int SendStateReqByPtr(int nConnId, StateReq_t * pStateReq);
void DumpStateReq(StateReq_t * pStateReq);
size_t InputStateReq();

#endif // _GENERATED_H
