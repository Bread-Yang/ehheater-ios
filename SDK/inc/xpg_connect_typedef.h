#ifndef XPG_CONNECT_TYPEDEF_H
#define XPG_CONNECT_TYPEDEF_H

/** @file
    SDK 核心声明，如自定义变量类型、错误码枚举、静态代码的数据结构声明。\r\n
    独立成一个文件主要是为了方便 SWIG 生成各个声明的语言映射。\r\n
    此文件已被包含在经常补引用的xpgconnect_common.h中。一般不用独立包含。\r\n
*/

#define MAX_DATA 32768
#define MAX_PATH 256
#define MAX_TEXT 1024

typedef unsigned char   byte;
typedef unsigned short  word;
typedef unsigned int    dword;

typedef byte            boolean;

typedef signed char         int8_t;
typedef unsigned char       uint8_t;
typedef signed short int    int16_t;
typedef unsigned short int  uint16_t;
typedef signed int          int32_t;
typedef unsigned int        uint32_t;
typedef unsigned long long  uint64_t;
typedef long long           int64_t;

typedef int8_t      int8;
typedef uint8_t     uint8;
typedef int16_t     int16;
typedef uint16_t    uint16;
typedef int32_t     int32;
typedef uint32_t    uint32;
typedef int64_t     int64;
typedef uint64_t    uint64;

typedef unsigned char   uchar_t;
// typedef uint32_t        wchar_t;
// typedef uint32_t        size_t; // already defined in sys/types.h

typedef uint32_t    addr_t;
typedef int32_t     pid_t;

typedef enum _XPG_RESULT
{
    ERROR_NONE = 0,
    ERROR_GENERAL = -1,
    ERROR_NOT_IMPLEMENTED = -2,
    ERROR_DESCRIPTOR_FAIL = -3,
    ERROR_PACKET_DATALEN = -4,
    ERROR_CONNECTION_ID = -5,
    ERROR_PATH = -6,
    ERROR_CONNECTION_CLOSED = -7,
    ERROR_PACKET_CHECKSUM = -8,
    ERROR_LOGIN_FAIL = -10,
    ERROR_DOMAIN_NAME = -11,
    ERROR_MQTT_FAIL = -12,
    ERROR_DISCOVERY_MISMATCH = -13,
    ERROR_SET_SOCK_OPT = -14,
    ERROR_THREAD_CREATE = -15,
    ERROR_NULL_MAC = -16,
    ERROR_CONNECTION_POOL_FULLED = -17,
    ERROR_NULL_CLIENT_ID = -18,
    ERROR_CONNECTION_ERROR = -19,
    ERROR_INVALID_PARAM = -20,
    ERROR_CONNECT_TIMEOUT = -21,
    ERROR_INVALID_VERSION = -22,
    ERROR_INSUFFIENT_MEM = -23,
    ERROR_THREAD_BUSY = -24,
} XPG_RESULT;

typedef enum _XPG_WAN_LAN
{
    LAN = 0,
    WAN = 1,
    MQTT = 2,
} XPG_WAN_LAN;

typedef enum _XPG_CONN_TYPE
{
    TCP = 0,
    STCP = 1,
    BT = 2,
    BLE = 3,
} XPG_CONN_TYPE;

typedef enum _XPG_LOGIN_RESULT
{
    CONTROL_ENABLED = 0,
    LOGINED,
    FAILED,
} XPG_LOGIN_RESULT;

typedef enum _XPG_CONFIG_KEY
{
    INTERVAL_BEFORE_SEND,
    CONNECT_TIMEOUT,
    LOG_LEVEL,
    LAN_TTL_TIMEOUT,
} XPG_CONFIG_KEY;

typedef enum _XPG_VERSION_EVENT_KEY
{
    PI_VERSION = 1,
    P0_VERSION = 2,
} XPG_VERSION_EVENT_KEY;

#pragma pack(1) // structure align/pack to every byte

/****************************************************************
    data structs
*****************************************************************/

typedef struct _XpgDataField
{
    word len;
    byte * val;
} XpgDataField;

typedef struct _XpgMqttTopic
{
    char szTopic[32];
    uint16_t nTopicId;
} XpgMqttTopic;

typedef struct _XpgEndpoint
{
    int id; // reserved for the moment
    // alias: ipStr of XpgEndpoint
    char addr[MAX_PATH]; // ipStr
    unsigned short port;
    XPG_WAN_LAN mode; // default as LAN (=0)
    XPG_CONN_TYPE connType; // default as TCP (=0)
    // alias: macStr of XpgEndpoint
    char szMac[13]; // e.g. "FF1122334455"
    char szWriteTopic[16]; // e.g. device => read Command, write Status
    char szClientId[33]; // TODO: it's duplicated with client id in broker?
    char szDid[24];
    char szFwVer[33];
    char szProductKey[33];
    char szPasscode[33];
    dword piVersion;
    dword p0Version;
    byte isOnline;
    unsigned int nConnectRetry;
} XpgEndpoint;

typedef struct _XpgConnection
{
    int id;
    XPG_CONN_TYPE type;
    int fd; // POSIX socket/file
    BIO * pBio; // OpenSSL BIO
    mqtt_broker_handle_t broker;
    XpgEndpoint endpoint;
    XpgMqttTopic topics[3];
} XpgConnection;

typedef struct _XpgPacket
{
    dword version;
    word dataLen; // len
    word command;
    byte data[MAX_DATA];
    dword CRC;
    byte flag;
    int nConnId;
    struct sockaddr_in peerAddr; // used when packet is read from udp socket
} XpgPacket;

#endif // XPG_CONNECT_TYPEDEF_H