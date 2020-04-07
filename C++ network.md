# C++ 네트워크 프로그래밍

https://www.winsocketdotnetworkprogramming.com/winsock2programming/

http://www.codersblock.org/blog/multiplayer-fps-part-1

https://gafferongames.com/post/deterministic_lockstep/



## 기본

### octet (== 8 bits)

예전에는 1 byte == 8 bits 가 아닐 수 있었다. 네트워크에서는 한 단위를 고정적으로 정할 필요가 있었고, 8 bits를 묶어 1 octet이라 칭한다.



### endianness

![](Asset\endianness.png)

host와 network의 endianness가 다를 수 있음에 주의하자!



### internet protocol = IP

packet에 담긴 IP 주소로 패킷을 전송하는 것이 목적.

IP는 태생이 비연결형 데이터그램 서비스다. (나중에 TCP가 추가되어 연결형도 가능해진 것!)

버전은 IPv4, IPv6이 있다.

IPv4는 32-bit (= 4바이트) 주소 공간을 사용한다. 즉, 이론적으로 $2^{32}$ 가지 주소를 쓸 수 있다.

 e.g.) 192.0.2.235

IPv6는 128-bit (= 16 바이트) 주소 공간을 사용한다. 즉 이론적으로 $2^{128}$ 가지 주소를 쓸 수 있다. 4자리의 16진수가 한 단위로, 총 8그룹으로 이루어져 있다.

 e.g.) 2001:0db8:0000:0000:0000:8a2e:0370:7334

클라이언트가 서버와 통신하려면 서버의 IP 주소와 서비스 포트 번호를 알아야 한다. 마찬가지로 서버도 클라이언트의 접속 요청을 받으려면 IP 주소와 포트 번호를 명시해야한다?



## 클라이언트 신뢰

서버가 모든 걸 통제하는 편이 낫다... 그래야 cheating 예방이 쉽다.



## 서버-클라이언트 동기화(synchronization)

### snapshot interpolation★

### state synchronization

### deterministic lockstep

input이 같다면 simulation 결과가 같다는 전제가 필요함... (floating point determinism 때문에 힘듦!) -> 모든 클라이언트의 input을 기다려야 함 -> 사람 수가 적은 RTS/LAN에 적합



## TCP vs. UDP

인원이 많은 실시간 게임이라면 UDP를 써야... TCP는 패킷 올 때까지 기다리고 순서도 지켜야 하니까 게임이 멈추기 십상

UDP는 패킷이 도착하거나/안 하거나!



## 코드

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



### WSAStartup

Windows Socket 버전을 지정하여 버전에 해당하는 구현(라이브러리)을 얻어온다(즉, DLL 로드). 자세한 정보는 WSADATA 구조체에 저장된다.

성공 시 0을 리턴. 실패 시 에러 코드 리턴.

Winsock API를 다 사용한 후에는 WSACleanup()을 호출하여 Winsock 내부 리소스를 해제한다. (프로그램 종료 시에는 윈도우즈가 자동으로 해줌)

```cpp
WSADATA wsaData{};
// MAKEWORD(2, 2) == 0x202
int ErrorCode{ WSAStartup(MAKEWORD(2, 2), &wsaData) };
if (ErrorCode != 0)
{
    printf( "Failed - WSAStartup(): %d", ErrorCode);
    return false;
}
```



### SOCKET

#### TCP에서 SOCKET의 상태(STATE)

모든 소켓은 CLOSED 상태로 시작됨. 

클라이언트: 서버에 연결 시도하면 소켓이 SYN_SENT 상태가 됨. 연결 완료되면 ESTABLISHED 상태가 됨. 타임아웃으로 연결 실패 시 다시 CLOSED 상태가 됨.

서버: 소켓이 듣는 중이면 LISTEN 상태가 됨. 클라이언트가 연결 시도했다면 SYN_RCVD 상태가 됨. 연결되면 ESTABLISHED가 됨.

내가 소켓을 닫으려고 하면 active socket closure고, 상대방이 닫으면 passive다. 먼저 닫으려는 쪽이 FIN 패킷을 전송한다. 그럼 FIN_WAIT_1 상태가 된다. 상대방이 ACK을 보내면 나는 FIN_WAIT_2 상태가 된다. 상대방도 연결을 닫으면 나는 TIME_WAIT 상태(= 2MSL 상태)가 된다.  마지막으로 CLOSED 상태가 된다.



#### socket() / WSASocket()

```cpp
// 1st param: AF_INET
// 2nd param: SOCK_DGRAM(UDP) / SOCK_STREAM(TCP)
// 3rd param: IPPROTO_UDP / IPPROTO_TCP
socket();
WSASocket();
```

##### UDP 소켓 예시

```cpp
SOCKET Socket = socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
if (Socket == INVALID_SOCKET)
{
	printf("Failed - socket(): %d", WSAGetLastError());
	return;
}
```



#### bind()

패킷은 특정 포트를 통해 (IP주소로 식별되는) 특정 기기로 보내진다.

따라서 **서버의 경우** 소켓을 만들고 나면 소켓을 특정 주소와 포트에 묶어야 한다. 포트번호의 경우 1024 밑은 전부 예약되었으므로 그보다 큰 숫자를 고르자.

클라이언트는 bind()할 필요가 없다.



##### SOCKADDR_IN (sin_)

SOCKADDR_IN은 AF_INET IPv4 용

SOCKADDR_STORAGE는 크기가 커서 IPv4, IPv6 다 됨!

SOCKADDR_IN6은 <WS2tcpip.h>에 정의되어 있음!

```cpp
struct sockaddr_in
{
    short           sin_family; // AF_INET
    u_short         sin_port; // Port 번호 (endianness에 주의!)
    struct in_addr  sin_addr; // IPv4 주소
    char            sin_zero[8]; // padding
};
```

##### 예시

```cpp
SOCKADDR_IN local_address{};
local_address.sin_family = AF_INET;
local_address.sin_port = htons(9999);
local_address.sin_addr.s_addr = INADDR_ANY;
if (bind(Socket, (SOCKADDR*)&local_address, sizeof(local_address)) == SOCKET_ERROR)
{
    printf( "Failed - bind(): %d", WSAGetLastError());
    return;
}
```



#### endianness 관련 함수

```cpp
htons() // host to network (short)
ntohs() // network to host (short)
```

Inet_ntop() 문자열 -> 숫자 바이트

```
Family // AF_INET or AF_INET6
```

Inet_pton() 숫자 바이트 -> 문자열

```
Family // AF_INET or AF_INET6
```



#### getsockname()

#### getpeername()



### 서버

#### TCP/IP

##### socket() -> bind() -> listen() -> accept() -> closesocket()



#### UDP/IP

##### socket() -> bind() -> recvfrom() -> closesocket()



#### 내 IP 얻어오기 #1

```cpp
char HostName[256]{};
if (gethostname(HostName, 255))
{
    std::cerr << "Failed - gethostname(): " << WSAGetLastError() << std::endl;
    return false;
}

ADDRINFOA AddrInfoHint{};
AddrInfoHint.ai_family = AF_INET;
AddrInfoHint.ai_socktype = SOCK_STREAM;
AddrInfoHint.ai_protocol = IPPROTO_TCP;
ADDRINFOA* AddrInfo{};
int Error{ getaddrinfo(HostName, nullptr, &AddrInfoHint, &AddrInfo) };
if (Error)
{
    std::cerr << "Failed - getaddrinfo(): " << Error << std::endl;
    return false;
}
```



#### 내 IP 얻어오기 #2

```cpp
bool GetHostIP()
{
    SOCKET Socket{ socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP) };
    if (Socket == INVALID_SOCKET)
    {
        printf("Failed - socket(): %d", WSAGetLastError());
        return false;
    }

    SOCKADDR_IN loopback{};
    loopback.sin_family = AF_INET;
    loopback.sin_port = htons(9);
    loopback.sin_addr.S_un.S_addr = INADDR_LOOPBACK;
    if (connect(Socket, (sockaddr*)&loopback, sizeof(loopback)))
    {
        printf("Failed - connect(): %d", WSAGetLastError());
        return false;
    }

    SOCKADDR_IN host{};
    int host_length{ (int)sizeof(host) };
    if (getsockname(Socket, (sockaddr*)&host, &host_length))
    {
        printf("Failed - getsockname(): %d", WSAGetLastError());
        return false;
    }
    else
    {
        auto& bytes{ host.sin_addr.S_un.S_un_b };
        printf("Host IP: %d.%d.%d.%d", bytes.s_b1, bytes.s_b2, bytes.s_b3, bytes.s_b4);
    }

    if (closesocket(Socket))
    {
        printf("Failed - closesocket(): %d", WSAGetLastError());
    }

    return true;
}
```



```
// Some info on the receiver side...

   getsockname(ReceivingSocket, (SOCKADDR *)&ReceiverAddr, (int *)sizeof(ReceiverAddr));

 

   printf("Server: Receiving IP(s) used: %s\n", inet_ntoa(ReceiverAddr.sin_addr));

   printf("Server: Receiving port used: %d\n", htons(ReceiverAddr.sin_port));
   
   // Some info on the sender side

   getpeername(ReceivingSocket, (SOCKADDR *)&SenderAddr, &SenderAddrSize);

   printf("Server: Sending IP used: %s\n", inet_ntoa(SenderAddr.sin_addr));

   printf("Server: Sending port used: %d\n", htons(SenderAddr.sin_port));
```



#### listen()

묶인 socket을 '듣기' 상태로 둔다.

```cpp
int listen(SOCKET s, int backlog);
// backlog는 총 몇 개의 연결이 동시에 가능한지 정함. 만약 이 숫자를 2로 지정하면 세 명이 동시에 접속 시 앞의 2명만 처리되고 3번째 사람은 연결 거부됨... => SOMAXCONN 가 최댓값!
// 최대 클라이언트 수가 제한적이라면 backlog도 작게 배당하자.
// Bluetooth 환경에선 backlog를 작은 숫자(2~4)로 하자 => https://docs.microsoft.com/en-us/windows/win32/api/winsock2/nf-winsock2-listen
```



#### accept()

듣는 중인 socket을 통해 클라이언트가 연결 시도를 하면 받아들인다!

```
accept(); // 리턴되면 addr에 해당 클라이언트의 IP주소가 저장되고, 리턴값은 연결된 새로운 소켓!! 기존 듣던 소켓은 앞으로도 계속 듣기만 하면 된다!
WSAAccept();
AcceptEx();
```



#### shutdown() => Graceful Close

이미 shutdown한 socket은 다시 connect할 수 없다!



#### closesocket()



### 클라이언트

#### TCP

##### socket() -> connect() -> closesocket()

#### UDP

##### socket() -> sendto() -> closesocket()



### 데이터 전송

#### TCP

##### send() / WSASend()

##### recv() / WSARecv()

연결이 gracefully closed된 상태면 recv()는 0을 리턴한다!



#### UDP

##### recvfrom() / WSARecvFrom()

##### sendto() / WSASendTo()



#### select()

```cpp
int recvfromTimeOutUDP(SOCKET socket, long sec, long usec)
{
    // 타임아웃 시간
    timeval timeout;
    timeout.tv_sec = sec; // 초
    timeout.tv_usec = usec; // 밀리초

    // fd_set (file descriptor set)
    fd_set fds;
    FD_ZERO(&fds);
    FD_SET(socket, &fds);

    // 리턴값
    // -1: error occurred
    // 0: timed out
    // > 0: data ready to be read
    return select(0, &fds, 0, 0, &timeout);
}
```



## Maximum Transmission Unit (MTU)

Datagram은 IPv4에서 최대 576 octets 까지, IPv6에서 최대 1280 octets 까지 전송 가능 ?

```cpp
WSAEnumProtocols() // Datagram 최대 크기
```



## getaddrinfo() / freeaddrinfo()



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
SOCK_STREAM // for TCP (Transmission Control Protocol)
SOCK_DGRAM // for UDP (User Datagram Protocol)
```

#### ip protocol (IPPROTO_)

```
IPPROTO_TCP
IPPROTO_UDP
```

#### flags

```
AI_PASSIVE // 소켓 주소가 bind() 호출에서 사용됨
```



## inet_pton()

#include <WS2tcpip.h>

