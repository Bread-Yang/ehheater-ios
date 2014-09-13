#ifndef _UTILDEBUG_H
#define _UTILDEBUG_H 1

#include <stdio.h>
#include "xpgconnect_common.h"

/** @file
	与业务逻辑无关的底层助手函数，比如：\r\n
	# 缓冲区中byte/word/dword/fix string/varible data的读与写。\r\n
	# XpgDataField结构体的拷贝、清理、字符串转换
	# MAC地址的获取、字节转字符格式、长字符格式、短字符格式
	# socket 助手函数：监听、广播、连接
	# ssl 助手函数：连接
	# 基于 XpgConnection 的各种读写，大、小循环。
*/

#define LV_ERROR (0)
#define LV_WARN (1)
#define LV_INFO (2)
#define LV_NONE (3)

#define PLV_DEBUG (0)
#define PLV_RELEASE (1)

#define LOG_BUFFER_SIZE 524288

typedef struct _ConnectThreadContext_t
{
	struct sockaddr_in addr;
	int nSocket;
    unsigned char bShouldCancel;
} ConnectThreadContext_t;

byte * put_byte(void * buf, byte value, size_t len);
byte * put_word(void * buf, word value, size_t len);
byte * put_dword(void * buf, dword value, size_t len);
byte * put_char(void * buf, char * value, size_t len);
byte * put_data(void * buf, XpgDataField * value);
byte * put_size(void * buf, size_t size);

/** @desc read field from buffer and move the pointer for next field */
byte * get_byte(byte * src, byte * dst);
byte * get_word(byte * src, word * dst);
byte * get_dword(byte * src, dword * dst);
byte * get_char(byte * src, char * dst, size_t len);
byte * get_data(byte * src, XpgDataField * dst, size_t len);
byte * get_size(byte * src, size_t * len);

size_t read_size(XpgConnection * pConn);

/** @remark
		the XpgDataField output by this func is not allocating new memory.
		so make a copy of the data self, if you need it to be persistent.
*/
XpgDataField str2data(const char * str);
char * data2str(XpgDataField * field);

void free_data(XpgDataField * ptr, int bFreeSelf);
void copy_data(XpgDataField * dst, XpgDataField * src);
boolean IsEmptyData(XpgDataField * ptr);

void DumpAndAlignToColumn(char * szLine, size_t columnLen);

void DumpTypeSize();

void printDataLevel(byte level);
void printData(byte level, const void *data, int dataLen, const char *prefix, ...);
char * compactMacStr(char * mac);
char * expendMacStr(char * mac);
/** @desc parse a buffer that contains mac address either in binary or string format.\r\n
		the result is copied in to parameter dst.\r\n
		e.g.\r\n
		"00:23:12:13:f3:69" => "00231213f369"\r\n
        0x00231213f369" => "00231213f369"
	@return ERROR_NONE or ERROR_GENERAL
	@see compactMacStr
*/
XPG_RESULT parseMac(char * dst, void * mac, size_t len);

char * xpg_inet_ntoa(dword ip);

/** @desc logging API
*/
void logHandle(FILE * file);
void logLevel(byte level);
void logMsg(byte level, const char * format, ...);

/** @desc TCP/UDP helper functions
*/
int udpListen(const int port);
int udpBroadcastSocket();

int tcpListen(const int port);
/** @Return
		succeed if greater than 0. return negative value if error.
		see also enum XPG_RESULT in xpgconnect_common.h for detailed error list
*/
int tcpConnect(const char * addr, const int port, const int connTimeout, const int ttlTimeout);

/** @desc SSL helper functions
*/
BIO * sslConnect(const char * addr, const int port);
int sslClose(BIO * bio);

// try to read n bytes
int try_read_n(XpgConnection * pConn, void *buf, int count);

// read until n bytes
int readn(XpgConnection * pConn, void *buf, int count);
int writen(XpgConnection * pConn, void *buf, int count);

// read into XpgPacket
XPG_RESULT readUdp(int udpSocket, XpgPacket * pPacket);
XPG_RESULT readPi(XpgConnection * pConn, XpgPacket * pPacket);
int readPm(XpgConnection * pConn, XpgPacket * pPacket);

// write XpgPacket out
int writePi(XpgConnection * pConn, XpgPacket * pPacket);
int writePm(XpgConnection * pConn, XpgPacket * pPacket);

// fill local ip into given buffer
void getLocalIp(int cb, char * szIp);
void fillMacString(char * szMac);
void fillMacAddr(void * pMac);

#endif /* _UTILDEBUG_H */
