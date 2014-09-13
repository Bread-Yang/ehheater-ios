#ifndef XPG_LOGIC_H_
#define XPG_LOGIC_H_

#include "xpgconnect_common.h"

/** Desc:
        check sum function for specified project protocol
*/
dword calcChecksum(byte * buf, size_t len);

#endif // XPG_LOGIC_H_