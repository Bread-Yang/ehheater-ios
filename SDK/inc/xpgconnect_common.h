#ifndef XPG_CONNECT_COMMON_H
#define XPG_CONNECT_COMMON_H 1

/** @file
    SDK 处理逻辑部分实现，主要是手机端与模拟器都共享的逻辑。\r\n
    另有源文件分别手机端模拟器端独有的代码。\r\n
    手机端：xpgconnectcli.c/.h\r\n
    模拟器端：和xpgconnectser.c/.h\r\n
*/

#include <sys/socket.h>
#include <sys/select.h>
#include <netinet/in.h> // struct sockaddr_in
#include <pthread.h>
#include "libemqtt/libemqtt.h"
#include "openssl/ssl.h"
#include "openssl/err.h"
#include "openssl/md5.h"
#include "queue.h"

#include "xpg_connect_typedef.h"

#define MOBILE_2_BROADCAST (0x01)
#define MOBILE_2_DEVICE (0x02)
#define DEVICE_2_MOBILE (0x03)
#define DEVICE_2_CLOUD (0x04)
#define CLOUD_2_DEVICE (0x05)
#define MOBILE_2_CLOUD (0x06)
#define CLOUD_2_MOBILE (0x07)
#define MOBILE_CLOUD_DEVICE (0x08)
#define DEVICE_CLOUD_MOBILE (0x09)

#define ATTR_SET (0x02)
#define ATTR_GET (0x03)
#define ATTR_VAL (0x04)

#define ATTR_ID 0x0001
#define ATTR_NAME 0x0002

#define LOOP_INTERVAL (100 * 1000)
#define BUF_SIZE_RECV 2048

// connection pool const(s)
#define TCP_MAX_CONN 100
#define UNUSED_FD (-1)
#define INVALID_CONN_ID UNUSED_FD

#define MAX_CONNECT_RETRY 5
#define SOCKET_RECV_TIMEOUT 5   // in seconds
#define SOCKET_SEND_TIMEOUT 5   // in seconds

#define DEFAULT_MQTT_TTL (30)
#define DEFAULT_SEND_INTERVAL (0)
#define DEFAULT_CONN_TIMEOUT (10)
#define DEFAULT_LAN_TTL_TIMEOUT (30)
#define DEFAULT_EASYLINK_PORT (2415)

// helper marco(s)
#ifndef MAX
#define MAX(a,b) ( (a > b) ? (a) : (b) )
#endif

#ifndef MIN
#define MIN(a,b) ( (a < b) ? (a) : (b) )
#endif

#define IsEmptyString(a) ('\0' == a[0])

#define FOREACH(iterator, collection, filter) \
    for (iterator = collection->FirstChildElement(filter); \
        NULL != iterator; \
        iterator = iterator->NextSiblingElement(filter))

#define DUMMY_MAC_ADDR "000000000000"

typedef void (*CbOnThreadStarting)();
typedef void (*CbOnInited)(int result);
typedef void (*CbOnThreadExiting)();
typedef int (*CbOnTcpPacket)(XpgPacket * pPacket, int connId);
/** @param event, see definition in libemqtt.h */
typedef void (*CbOnMqttEvent)(int connId, int event, void * data);
typedef int (*CbOnLoginCloudResp)(unsigned short result, char * szMac);
typedef dword (*CbOnCalcChecksum)(byte * buf, size_t len);
typedef unsigned int (*CbOnProcessTcp)(XpgPacket * pPacket, int connId);
typedef unsigned int (*CbOnProcessUdp)(XpgPacket * pPacket);
typedef void (*CbOnConnectEvent)(int connId, int event);
typedef void (*CbOnVersionEvent)(XPG_VERSION_EVENT_KEY key, int value, int connId);
typedef void (*CbOnWriteEvent)(int result, int connId);

typedef void (*CbOnReleased)(const int result);

// typedef void (*CbOnSdkEvent)(const int key, const char * dataXml);

typedef struct _XpgCommonContext
{
    // connection pool
    XpgConnection ConnectionPool[TCP_MAX_CONN];
    int TcpPeersMaxIndex;
    // UDP
    int nSocketDiscovery;
    int nSocketEasyLink;
    word nEasyLinkPort;
    // MQTT
    int nMqttTtl;
    // opeartion queue
    XpgQueue_t queueConnect;
    XpgQueue_t queueConnecting;
    XpgQueue_t queueSend;
    int CloseTcpReq[TCP_MAX_CONN];
    // other
    fd_set allSet; // template fd_set of all connected socket(s)
    fd_set resSet; // temporary fd_set for each round of select()
    int maxSockFd;
    int nSendInterval;
    int nConnTimeout;
    int nLanTtlTimeout; // in second
    // threading
    pthread_t recvThreadId;
    byte bShouldCancel;
    // fixed callback(s)
    CbOnThreadStarting ThreadStarting;
    CbOnInited Inited;
    CbOnReleased onReleased;
    CbOnThreadExiting ThreadExiting;
    CbOnTcpPacket OnTcpPacket;
    CbOnMqttEvent OnMqttEvent;
    CbOnLoginCloudResp OnLoginCloudResp;
    CbOnCalcChecksum OnCalcChecksum;
    CbOnConnectEvent onConnectEvent;
    CbOnVersionEvent onVersionEvent;
    CbOnWriteEvent onWriteEvent;
    // for SDK internal usage only
    CbOnProcessTcp OnInternalTcpProcess;
    CbOnProcessUdp OnInternalUdpProcess;
    CbOnMqttEvent OnInternalMqttEvent;
    CbOnWriteEvent onInternalWriteEvent;
} XpgCommonContext;

XpgCommonContext * GetContext();
XpgConnection * GetConnection(int nConnId, unsigned char logLevel);
XpgConnection * GetUnusedConnection();
XpgEndpoint * GetEndpoint(int nConnId);

void DumpEndpoint(XpgEndpoint * pEndpoint);
void SaveEndpoint(XpgEndpoint * pEndpoint, const char * path);
void LoadEndpoint(XpgEndpoint * pEndpoint, const char * path);

void DumpConnection(XpgConnection * pConn);

void DumpData(XpgDataField * pData);
void SaveData(XpgDataField * pData, FILE * hFile);
void LoadData(XpgDataField * pData, FILE * hFile);

void DumpPacket(XpgPacket * pPacket);

const char * xpgDirectionString(int dir);
const char * xpgErrorString(int error);
const char * xpgWanLanString(int enu);
const char * xpgConnTypeString(int type);
const char * xpgLoginResultString(int type);

unsigned short xpgcCalcChecksum(XpgPacket * packet);

// Return: amount of filled bytes
int fillXpgStringField(unsigned char * buf, const char * str);
int readXpgStringField(const unsigned char * buf, char * str);

boolean IsValidEndpoint(XpgEndpoint * pEndpoint);
boolean IsValidConnection(XpgConnection * pConn, unsigned char logLevel);
boolean IsClosedConnection(XpgConnection * pConn, unsigned char logLevel);
boolean IsValidMqtt(XpgConnection * pConn);
int isValidConnectReq(XpgEndpoint * req);

XPG_RESULT xpgcSubscribeMqttTopic(int connId, const char * szReadTopic, const char * szWriteTopic);
XPG_RESULT xpgcSubscribeMqttTopic2(int connId, XpgMqttTopic * pTopic);

void xpgcIoctl(int key, int value);

XPG_RESULT _handleTcpPacket(int connId);

XPG_RESULT _closeConnection(int connId, int logLevel);
XPG_RESULT _releaseEndpoint(XpgEndpoint * pEndpoint);

void xpgcOnStackFault(int sig);

void _onMqttTtlTimer(int sig);
void _onMqttTerminated(int sig);
void _onMqttEvent(int connId, int event, void * data);
int _sendMqttPacket(void* socket_info, const void* buf, unsigned int count);
XPG_RESULT _sendMqttConnect(int connId, const char * szUid, const char * szPass);
XPG_RESULT _handleMqttPacket(int connId);

void xpgcSetAttr(word attrId, XpgDataField * value);

int xpgcConnect(XpgEndpoint endpoint);
XPG_RESULT xpgcConnectAsync(XpgEndpoint endpoint);

XPG_RESULT xpgcRead(XpgPacket * packet, int connId);

/** @return number of sent bytes if > 0, please see also XPG_RESULT for error no if < 0
    @see XPG_RESULT
    @see writePi
    @see writePm
*/
int xpgcWrite(XpgPacket * packet, int connId);
/** Remark:
        Will make a copy of the inputed packet to be pushed in queue. Caller
         should release the input packet/buffer self.
*/
XPG_RESULT xpgcWriteAsync(XpgPacket * packet, int connId);

// return 0 if success, else return -1
XPG_RESULT xpgcBroadcast(XpgPacket * packet, unsigned short port);

// return 0 if success, else return -1
XPG_RESULT xpgcWriteUdp(XpgPacket * packet, const struct sockaddr *peerAddr);

/** @param timeout
        in sec
*/
XPG_RESULT xpgcDisconnect(int connId, byte timeout);
/** @return
        see XPG_RESULT
 */
XPG_RESULT xpgcDisconnectAsync(int connId);

#pragma mark SDK生命周期管理

XPG_RESULT xpgcRelease();
XPG_RESULT xpgcReinit();
XPG_RESULT xpgcReset();

#endif // XPG_CONNECT_COMMON_H
