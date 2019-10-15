# C++ 네트워크 프로그래밍

## 기본

UNIX 계열은

`#include <sys/socket.h>`

`#include <arpa/inet.h>`

필요



Windows는 과거에

`#include <winsock.h>` (Windows Sockets 1.1 버전)



현재는

`#include <WinSock2.h>` (Windows Sockets 2 버전)

`#include <WS2tcpip.h>` ( getaddrinfo(), freeaddrinfo(), getnameinfo()를 사용하기 위해 필요함)

```cpp
// <WinSock2.h>가 내부적으로 <windows.h>를 포함하고, <windows.h>는 내부적으로 <winsock.h>를 포함하므로 충돌이 발생한다. 따라서 <windows.h>를 명시적으로 포함하기 위해서는 아래 매크로를 정의해줘야 한다.
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif

#include <windows.h>
#include <WinSock2.h>
```

```cpp
WSADATA wsaData{};
if (WSAStartup(MAKEWORD(2, 2), &wsaData) != 0)
{
    std::cerr << "Failed to initialize Windows Socket Application.\n";
    return false;
}
```

```cpp
htons()
// host to network (short)
// Windows(host)는 Little Endian
// Network는 ★★Big Endian★★ 사용!
```

### octet (== 8 bits)

## Maximum Transmission Unit (MTU)

Datagram은 IPv4에서 최대 576 octets 까지, IPv6에서 최대 1280 octets 까지 전송 가능 ?

## getaddrinfo()

### address info (ai_)

```
ADDRINFO Hints{};
```

#### address family (AF_)

```
AF_INET // Internet == IPv4
AF_INET6 // Internet 6 == IPv6
```

#### socket type (SOCK_)

```
SOCK_STREAM // TCP
SOCK_DGRAM // UDP
```

#### ip protocol (IPPROTO_)

```
IPPROTO_TCP
IPPROTO_UDP
```

#### flags (AI_)

```
AI_PASSIVE // 소켓 주소가 bind() 호출에서 사용됨
```



recvfrom, sendto ??

