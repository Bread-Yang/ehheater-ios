#ifndef _PROTOCOL_H
#define _PROTOCOL_H

#include "xpgconnect_common.h"

/*version 1 packet format
 ---------------
 field       len      
 version     4byte
 varlen      1-4 byte      p0+sizeof(cmd)
 cmd         1 byte
 p0 
**/

/*version 3 packet format
 ---------------
 field       len      
 version     4byte
 varlen      1-4 byte      p0+sizeof(cmd) +sizeof(flag)
 flag        1 byte
 cmd         2 byte
 p0 
**/

#define CMD_ONBOARDING_REQ  0x0001
#define CMD_ONBOARDING_RESP 0x0002
#define CMD_DISCOVERY_REQ   0x0003
#define CMD_DISCOVERY_RESP  0x0004
#define CMD_BOOTSTRAP_RESP  0x0005
#define CMD_PASSCODE_REQ    0x0006
#define CMD_PASSCODE_RESP   0x0007
#define CMD_DEV_LOGIN_REQ   0x0008
#define CMD_DEV_LOGIN_RESP  0x0009
#define CMD_P0_PI_VER_REQ   0x000A
#define CMD_P0_PI_VER_RESP  0x000B
#define CMD_APP_2_DEV       0x0090
#define CMD_DEV_2_APP       0x0091

void setVer(byte * ver);
const byte * getVer();
int compareVer(byte major, byte minor, byte build, byte revision, byte * ver);
int currentVer(byte major, byte minor, byte build, byte revision);

boolean isCmdTopic(XpgPacket * pPacket, char * szTopic);
const char * getTopic4Cmd(XpgPacket * pPacket);

/** @desc invoked by writePi() & writePm() */
int patchHi(XpgPacket * pPacket);
int patchHi_0_0_0_1(XpgPacket * pPacket);
int patchHi_0_0_0_3(XpgPacket * pPacket);

/** @desc invoked by _handleMqttPacket() */
int stripHi(XpgPacket * pPacket);
int stripHi_0_0_0_1(XpgPacket * pPacket);
int stripHi_0_0_0_3(XpgPacket * pPacket);

int patchHm(XpgPacket * pPacket);
int patchHm_0_0_0_3(XpgPacket * pPacket);

int stripHm(XpgPacket * pPacket, const char * szTopic);
int stripHm_0_0_0_3(XpgPacket * pPacket);

/** @desc invoked by readPi() */
XPG_RESULT readP0_raw(XpgConnection * pConn, XpgPacket * pPacket);
XPG_RESULT readP0_0_0_0_1(XpgConnection * pConn, XpgPacket * pPacket);
XPG_RESULT readP0_0_0_0_3(XpgConnection * pConn, XpgPacket * pPacket);

#endif // _PROTOCOL_H