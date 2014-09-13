
#include "generated_example.h"
#import "EHCommunicator.h"

void onStateRespExample(size_t count, StateResp_t * pStateResp, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    DumpStateResp(pStateResp);
}

void onHeartbeatRespExample(size_t count, HeartbeatResp_t * pHeartbeatResp, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    DumpHeartbeatResp(pHeartbeatResp);
}

void onOnOffReqExample(size_t count, OnOffReq_t * pOnOffReq, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    DumpOnOffReq(pOnOffReq);
}

void onPatternSettingReqExample(size_t count, PatternSettingReq_t * pPatternSettingReq, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    DumpPatternSettingReq(pPatternSettingReq);
}

void onSettingWaterTempReqExample(size_t count, SettingWaterTempReq_t * pSettingWaterTempReq, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    DumpSettingWaterTempReq(pSettingWaterTempReq);
}

void onSettingPowerReqExample(size_t count, SettingPowerReq_t * pSettingPowerReq, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    DumpSettingPowerReq(pSettingPowerReq);
}

void onSettingOrderReqExample(size_t count, SettingOrderReq_t * pSettingOrderReq, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    DumpSettingOrderReq(pSettingOrderReq);
}

void onStateReqExample(size_t count, StateReq_t * pStateReq, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    DumpStateReq(pStateReq);
}


void onPasscodeeqExample(size_t count, PasscodeResp_t * pPasscodeResp, int nConnId)
{
    logMsg(LV_INFO, "%s(), TODO: had not processed as count", __func__);
    
    char * val = data2str(&pPasscodeResp->passcode);
    ehCommunicator.passcode = [NSString stringWithUTF8String:val];

    XPG_RESULT result = xpgcLogin(ehCommunicator.connId, NULL, [ehCommunicator.passcode UTF8String]);
    printf("%d", result);
    
    if (result == ERROR_NONE)
    {
        SendBindingGetReq(ehCommunicator.connId);
    }
}

void onUserRegisterResp(size_t count, UserRegisterResp_t * pUserRegisterResp, int nConnId){
    logMsg(LV_INFO, "%s(), TODO: had not processed as count",__func__);
    printf("registerResp:%i connID = %i",pUserRegisterResp->result,nConnId);
}

void xpgcGeneratedInit()
{
    contextGenerated.onStateResp = onStateRespExample;
    contextGenerated.onHeartbeatResp = onHeartbeatRespExample;
    contextGenerated.onOnOffReq = onOnOffReqExample;
    contextGenerated.onPatternSettingReq = onPatternSettingReqExample;
    contextGenerated.onSettingWaterTempReq = onSettingWaterTempReqExample;
    contextGenerated.onSettingPowerReq = onSettingPowerReqExample;
    contextGenerated.onSettingOrderReq = onSettingOrderReqExample;
    contextGenerated.onStateReq = onStateReqExample;
    contextGenerated.onPasscodeResp = onPasscodeeqExample;
    
    contextGenerated.onUserRegisterResp = onUserRegisterResp;
}

#ifdef SDK_CLI

void xpgcGeneratedCli(char * str)
{
    if (0 == strcasecmp(str, "help")) {
        printf("\n");
        printf("    logic command(s):\n");
        printf("\n");
        printf("    WriteWifiConfigReq()");
        printf("    OnboardingSetReq()");
        printf("    WriteWifiConfigResp()");
        printf("\n");
        printf("    OnboardingSetResp()");
        printf("    DiscoveryV1Req()");
        printf("    DiscoveryV3Req()");
        printf("\n");
        printf("    DiscoveryV1Resp()");
        printf("    DiscoveryV3Resp()");
        printf("    EasylinkResp()");
        printf("\n");
        printf("    BootstrapResp()");
        printf("    PasscodeReq()");
        printf("    PasscodeResp()");
        printf("\n");
        printf("    LanLoginReq()");
        printf("    LanLoginResp()");
        printf("    ModuleVersionReq()");
        printf("\n");
        printf("    ModuleVersionResp()");
        printf("    WifiListReq()");
        printf("    WifiListResp()");
        printf("\n");
        printf("    SerialPortConfigReq()");
        printf("    SerialPortConfigResp()");
        printf("    UserRegisterReq()");
        printf("\n");
        printf("    UserRegisterResp()");
        printf("    BindingSetReq()");
        printf("    BindingSetResp()");
        printf("\n");
        printf("    BindingGetReq()");
        printf("    BindingGetResp()");
        printf("    UserPwdChangeReq()");
        printf("\n");
        printf("    UserPwdChangeResp()");
        printf("    BindingDelReq()");
        printf("    BindingDelResp()");
        printf("\n");
        printf("    ReadWifiConfigReq()");
        printf("    ReadWifiConfigResp()");
        printf("    DeviceOnlineStateResp()");
        printf("\n");
        printf("    StateResp()");
        printf("    HeartbeatResp()");
        printf("    OnOffReq()");
        printf("\n");
        printf("    PatternSettingReq()");
        printf("    SettingWaterTempReq()");
        printf("    SettingPowerReq()");
        printf("\n");
        printf("    SettingOrderReq()");
        printf("    StateReq()");
        printf("\n");
    } else if (0 == strcasecmp(str, "WriteWifiConfigReq")) {
        WriteWifiConfigReq_t WriteWifiConfigReq;
        size_t len = InputWriteWifiConfigReq();
        memset(&WriteWifiConfigReq, 0x00, sizeof(WriteWifiConfigReq_t));
        GetBuffer(&WriteWifiConfigReq, len);
        SendWriteWifiConfigReqByPtr(app.connId, &WriteWifiConfigReq);
    } else if (0 == strcasecmp(str, "OnboardingSetReq")) {
        OnboardingSetReq_t OnboardingSetReq;
        size_t len = InputOnboardingSetReq();
        memset(&OnboardingSetReq, 0x00, sizeof(OnboardingSetReq_t));
        GetBuffer(&OnboardingSetReq, len);
        SendOnboardingSetReqByPtr(app.connId, &OnboardingSetReq);
    } else if (0 == strcasecmp(str, "WriteWifiConfigResp")) {
        WriteWifiConfigResp_t WriteWifiConfigResp;
        size_t len = InputWriteWifiConfigResp();
        memset(&WriteWifiConfigResp, 0x00, sizeof(WriteWifiConfigResp_t));
        GetBuffer(&WriteWifiConfigResp, len);
        SendWriteWifiConfigRespByPtr(app.connId, &WriteWifiConfigResp);
    } else if (0 == strcasecmp(str, "OnboardingSetResp")) {
        OnboardingSetResp_t OnboardingSetResp;
        size_t len = InputOnboardingSetResp();
        memset(&OnboardingSetResp, 0x00, sizeof(OnboardingSetResp_t));
        GetBuffer(&OnboardingSetResp, len);
        SendOnboardingSetRespByPtr(app.connId, &OnboardingSetResp);
    } else if (0 == strcasecmp(str, "DiscoveryV1Req")) {
        DiscoveryV1Req_t DiscoveryV1Req;
        size_t len = InputDiscoveryV1Req();
        memset(&DiscoveryV1Req, 0x00, sizeof(DiscoveryV1Req_t));
        GetBuffer(&DiscoveryV1Req, len);
        SendDiscoveryV1ReqByPtr(app.connId, &DiscoveryV1Req);
    } else if (0 == strcasecmp(str, "DiscoveryV3Req")) {
        DiscoveryV3Req_t DiscoveryV3Req;
        size_t len = InputDiscoveryV3Req();
        memset(&DiscoveryV3Req, 0x00, sizeof(DiscoveryV3Req_t));
        GetBuffer(&DiscoveryV3Req, len);
        SendDiscoveryV3ReqByPtr(app.connId, &DiscoveryV3Req);
    } else if (0 == strcasecmp(str, "DiscoveryV1Resp")) {
        DiscoveryV1Resp_t DiscoveryV1Resp;
        size_t len = InputDiscoveryV1Resp();
        memset(&DiscoveryV1Resp, 0x00, sizeof(DiscoveryV1Resp_t));
        GetBuffer(&DiscoveryV1Resp, len);
        SendDiscoveryV1RespByPtr(app.connId, &DiscoveryV1Resp);
    } else if (0 == strcasecmp(str, "DiscoveryV3Resp")) {
        DiscoveryV3Resp_t DiscoveryV3Resp;
        size_t len = InputDiscoveryV3Resp();
        memset(&DiscoveryV3Resp, 0x00, sizeof(DiscoveryV3Resp_t));
        GetBuffer(&DiscoveryV3Resp, len);
        SendDiscoveryV3RespByPtr(app.connId, &DiscoveryV3Resp);
    } else if (0 == strcasecmp(str, "EasylinkResp")) {
        EasylinkResp_t EasylinkResp;
        size_t len = InputEasylinkResp();
        memset(&EasylinkResp, 0x00, sizeof(EasylinkResp_t));
        GetBuffer(&EasylinkResp, len);
        SendEasylinkRespByPtr(app.connId, &EasylinkResp);
    } else if (0 == strcasecmp(str, "BootstrapResp")) {
        BootstrapResp_t BootstrapResp;
        size_t len = InputBootstrapResp();
        memset(&BootstrapResp, 0x00, sizeof(BootstrapResp_t));
        GetBuffer(&BootstrapResp, len);
        SendBootstrapRespByPtr(app.connId, &BootstrapResp);
    } else if (0 == strcasecmp(str, "PasscodeReq")) {
        PasscodeReq_t PasscodeReq;
        size_t len = InputPasscodeReq();
        memset(&PasscodeReq, 0x00, sizeof(PasscodeReq_t));
        GetBuffer(&PasscodeReq, len);
        SendPasscodeReqByPtr(app.connId, &PasscodeReq);
    } else if (0 == strcasecmp(str, "PasscodeResp")) {
        PasscodeResp_t PasscodeResp;
        size_t len = InputPasscodeResp();
        memset(&PasscodeResp, 0x00, sizeof(PasscodeResp_t));
        GetBuffer(&PasscodeResp, len);
        SendPasscodeRespByPtr(app.connId, &PasscodeResp);
    } else if (0 == strcasecmp(str, "LanLoginReq")) {
        LanLoginReq_t LanLoginReq;
        size_t len = InputLanLoginReq();
        memset(&LanLoginReq, 0x00, sizeof(LanLoginReq_t));
        GetBuffer(&LanLoginReq, len);
        SendLanLoginReqByPtr(app.connId, &LanLoginReq);
    } else if (0 == strcasecmp(str, "LanLoginResp")) {
        LanLoginResp_t LanLoginResp;
        size_t len = InputLanLoginResp();
        memset(&LanLoginResp, 0x00, sizeof(LanLoginResp_t));
        GetBuffer(&LanLoginResp, len);
        SendLanLoginRespByPtr(app.connId, &LanLoginResp);
    } else if (0 == strcasecmp(str, "ModuleVersionReq")) {
        ModuleVersionReq_t ModuleVersionReq;
        size_t len = InputModuleVersionReq();
        memset(&ModuleVersionReq, 0x00, sizeof(ModuleVersionReq_t));
        GetBuffer(&ModuleVersionReq, len);
        SendModuleVersionReqByPtr(app.connId, &ModuleVersionReq);
    } else if (0 == strcasecmp(str, "ModuleVersionResp")) {
        ModuleVersionResp_t ModuleVersionResp;
        size_t len = InputModuleVersionResp();
        memset(&ModuleVersionResp, 0x00, sizeof(ModuleVersionResp_t));
        GetBuffer(&ModuleVersionResp, len);
        SendModuleVersionRespByPtr(app.connId, &ModuleVersionResp);
    } else if (0 == strcasecmp(str, "WifiListReq")) {
        WifiListReq_t WifiListReq;
        size_t len = InputWifiListReq();
        memset(&WifiListReq, 0x00, sizeof(WifiListReq_t));
        GetBuffer(&WifiListReq, len);
        SendWifiListReqByPtr(app.connId, &WifiListReq);
    } else if (0 == strcasecmp(str, "WifiListResp")) {
        WifiListResp_t WifiListResp;
        size_t len = InputWifiListResp();
        memset(&WifiListResp, 0x00, sizeof(WifiListResp_t));
        GetBuffer(&WifiListResp, len);
        SendWifiListRespByPtr(app.connId, &WifiListResp);
    } else if (0 == strcasecmp(str, "SerialPortConfigReq")) {
        SerialPortConfigReq_t SerialPortConfigReq;
        size_t len = InputSerialPortConfigReq();
        memset(&SerialPortConfigReq, 0x00, sizeof(SerialPortConfigReq_t));
        GetBuffer(&SerialPortConfigReq, len);
        SendSerialPortConfigReqByPtr(app.connId, &SerialPortConfigReq);
    } else if (0 == strcasecmp(str, "SerialPortConfigResp")) {
        SerialPortConfigResp_t SerialPortConfigResp;
        size_t len = InputSerialPortConfigResp();
        memset(&SerialPortConfigResp, 0x00, sizeof(SerialPortConfigResp_t));
        GetBuffer(&SerialPortConfigResp, len);
        SendSerialPortConfigRespByPtr(app.connId, &SerialPortConfigResp);
    } else if (0 == strcasecmp(str, "UserRegisterReq")) {
        UserRegisterReq_t UserRegisterReq;
        size_t len = InputUserRegisterReq();
        memset(&UserRegisterReq, 0x00, sizeof(UserRegisterReq_t));
        GetBuffer(&UserRegisterReq, len);
        SendUserRegisterReqByPtr(app.connId, &UserRegisterReq);
    } else if (0 == strcasecmp(str, "UserRegisterResp")) {
        UserRegisterResp_t UserRegisterResp;
        size_t len = InputUserRegisterResp();
        memset(&UserRegisterResp, 0x00, sizeof(UserRegisterResp_t));
        GetBuffer(&UserRegisterResp, len);
        SendUserRegisterRespByPtr(app.connId, &UserRegisterResp);
    } else if (0 == strcasecmp(str, "BindingSetReq")) {
        BindingSetReq_t BindingSetReq;
        size_t len = InputBindingSetReq();
        memset(&BindingSetReq, 0x00, sizeof(BindingSetReq_t));
        GetBuffer(&BindingSetReq, len);
        SendBindingSetReqByPtr(app.connId, &BindingSetReq);
    } else if (0 == strcasecmp(str, "BindingSetResp")) {
        BindingSetResp_t BindingSetResp;
        size_t len = InputBindingSetResp();
        memset(&BindingSetResp, 0x00, sizeof(BindingSetResp_t));
        GetBuffer(&BindingSetResp, len);
        SendBindingSetRespByPtr(app.connId, &BindingSetResp);
    } else if (0 == strcasecmp(str, "BindingGetReq")) {
        BindingGetReq_t BindingGetReq;
        size_t len = InputBindingGetReq();
        memset(&BindingGetReq, 0x00, sizeof(BindingGetReq_t));
        GetBuffer(&BindingGetReq, len);
        SendBindingGetReqByPtr(app.connId, &BindingGetReq);
    } else if (0 == strcasecmp(str, "BindingGetResp")) {
        BindingGetResp_t BindingGetResp;
        size_t len = InputBindingGetResp();
        memset(&BindingGetResp, 0x00, sizeof(BindingGetResp_t));
        GetBuffer(&BindingGetResp, len);
        SendBindingGetRespByPtr(app.connId, &BindingGetResp);
    } else if (0 == strcasecmp(str, "UserPwdChangeReq")) {
        UserPwdChangeReq_t UserPwdChangeReq;
        size_t len = InputUserPwdChangeReq();
        memset(&UserPwdChangeReq, 0x00, sizeof(UserPwdChangeReq_t));
        GetBuffer(&UserPwdChangeReq, len);
        SendUserPwdChangeReqByPtr(app.connId, &UserPwdChangeReq);
    } else if (0 == strcasecmp(str, "UserPwdChangeResp")) {
        UserPwdChangeResp_t UserPwdChangeResp;
        size_t len = InputUserPwdChangeResp();
        memset(&UserPwdChangeResp, 0x00, sizeof(UserPwdChangeResp_t));
        GetBuffer(&UserPwdChangeResp, len);
        SendUserPwdChangeRespByPtr(app.connId, &UserPwdChangeResp);
    } else if (0 == strcasecmp(str, "BindingDelReq")) {
        BindingDelReq_t BindingDelReq;
        size_t len = InputBindingDelReq();
        memset(&BindingDelReq, 0x00, sizeof(BindingDelReq_t));
        GetBuffer(&BindingDelReq, len);
        SendBindingDelReqByPtr(app.connId, &BindingDelReq);
    } else if (0 == strcasecmp(str, "BindingDelResp")) {
        BindingDelResp_t BindingDelResp;
        size_t len = InputBindingDelResp();
        memset(&BindingDelResp, 0x00, sizeof(BindingDelResp_t));
        GetBuffer(&BindingDelResp, len);
        SendBindingDelRespByPtr(app.connId, &BindingDelResp);
    } else if (0 == strcasecmp(str, "ReadWifiConfigReq")) {
        ReadWifiConfigReq_t ReadWifiConfigReq;
        size_t len = InputReadWifiConfigReq();
        memset(&ReadWifiConfigReq, 0x00, sizeof(ReadWifiConfigReq_t));
        GetBuffer(&ReadWifiConfigReq, len);
        SendReadWifiConfigReqByPtr(app.connId, &ReadWifiConfigReq);
    } else if (0 == strcasecmp(str, "ReadWifiConfigResp")) {
        ReadWifiConfigResp_t ReadWifiConfigResp;
        size_t len = InputReadWifiConfigResp();
        memset(&ReadWifiConfigResp, 0x00, sizeof(ReadWifiConfigResp_t));
        GetBuffer(&ReadWifiConfigResp, len);
        SendReadWifiConfigRespByPtr(app.connId, &ReadWifiConfigResp);
    } else if (0 == strcasecmp(str, "DeviceOnlineStateResp")) {
        DeviceOnlineStateResp_t DeviceOnlineStateResp;
        size_t len = InputDeviceOnlineStateResp();
        memset(&DeviceOnlineStateResp, 0x00, sizeof(DeviceOnlineStateResp_t));
        GetBuffer(&DeviceOnlineStateResp, len);
        SendDeviceOnlineStateRespByPtr(app.connId, &DeviceOnlineStateResp);
    } else if (0 == strcasecmp(str, "StateResp")) {
        StateResp_t StateResp;
        size_t len = InputStateResp();
        memset(&StateResp, 0x00, sizeof(StateResp_t));
        GetBuffer(&StateResp, len);
        SendStateRespByPtr(app.connId, &StateResp);
    } else if (0 == strcasecmp(str, "HeartbeatResp")) {
        HeartbeatResp_t HeartbeatResp;
        size_t len = InputHeartbeatResp();
        memset(&HeartbeatResp, 0x00, sizeof(HeartbeatResp_t));
        GetBuffer(&HeartbeatResp, len);
        SendHeartbeatRespByPtr(app.connId, &HeartbeatResp);
    } else if (0 == strcasecmp(str, "OnOffReq")) {
        OnOffReq_t OnOffReq;
        size_t len = InputOnOffReq();
        memset(&OnOffReq, 0x00, sizeof(OnOffReq_t));
        GetBuffer(&OnOffReq, len);
        SendOnOffReqByPtr(app.connId, &OnOffReq);
    } else if (0 == strcasecmp(str, "PatternSettingReq")) {
        PatternSettingReq_t PatternSettingReq;
        size_t len = InputPatternSettingReq();
        memset(&PatternSettingReq, 0x00, sizeof(PatternSettingReq_t));
        GetBuffer(&PatternSettingReq, len);
        SendPatternSettingReqByPtr(app.connId, &PatternSettingReq);
    } else if (0 == strcasecmp(str, "SettingWaterTempReq")) {
        SettingWaterTempReq_t SettingWaterTempReq;
        size_t len = InputSettingWaterTempReq();
        memset(&SettingWaterTempReq, 0x00, sizeof(SettingWaterTempReq_t));
        GetBuffer(&SettingWaterTempReq, len);
        SendSettingWaterTempReqByPtr(app.connId, &SettingWaterTempReq);
    } else if (0 == strcasecmp(str, "SettingPowerReq")) {
        SettingPowerReq_t SettingPowerReq;
        size_t len = InputSettingPowerReq();
        memset(&SettingPowerReq, 0x00, sizeof(SettingPowerReq_t));
        GetBuffer(&SettingPowerReq, len);
        SendSettingPowerReqByPtr(app.connId, &SettingPowerReq);
    } else if (0 == strcasecmp(str, "SettingOrderReq")) {
        SettingOrderReq_t SettingOrderReq;
        size_t len = InputSettingOrderReq();
        memset(&SettingOrderReq, 0x00, sizeof(SettingOrderReq_t));
        GetBuffer(&SettingOrderReq, len);
        SendSettingOrderReqByPtr(app.connId, &SettingOrderReq);
    } else if (0 == strcasecmp(str, "StateReq")) {
        StateReq_t StateReq;
        size_t len = InputStateReq();
        memset(&StateReq, 0x00, sizeof(StateReq_t));
        GetBuffer(&StateReq, len);
        SendStateReqByPtr(app.connId, &StateReq);
    }
}
#endif // SDK_CLI

