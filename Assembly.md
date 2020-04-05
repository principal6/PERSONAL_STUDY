# C++ & Assembly

## 어셈블리 기초 지식

```assembly
mov 복사
add 더하기
sub 빼기
mul imul 정수 곱하기
div idiv 정수 나누기 (몫은 eax, 나머지는 edx)
cdq ;Convert Doubleword to Quadword

movss 소수 복사
addss 소수 더하기
subss 소수 빼기
mulss 소수 곱하기
divss 소수 나누기

lea 주소 복사
rep movs ; string 반복 복사 (MOVe String)
push 스택에 넣기 (sp 감소)
pop 스택에서 빼기 (sp 증가)
call 함수 호출

eax = accumulator register 산술 연산 결과 / 함수 리턴값 저장
ecx = counter register 반복 횟수 저장

esp = stack pointer 스택 꼭대기를 가리키는 포인터
ebp = base pointer 스택 바닥을 가리키는 포인터

esi = source index 복사할 것
edi = destination index 복사될 곳

xmm0 = 소수용 산술 연산 레지스터
```



## 산술 연산

### 더하기 빼기 (정수)

```cpp
int main()
{
	int a{ 15 };
	int b{ 5 };
	int c{ a - b };
    int d{ a + b - c};
	return 0;
}
```

```assembly
00651A88  mov         dword ptr [a],0Fh ; a = 15
00651A8F  mov         dword ptr [b],5  	; b = 5
00651A96  mov         eax,dword ptr [a] ; eax = a
00651A99  sub         eax,dword ptr [b] ; eax -= b
00651A9C  mov         dword ptr [c],eax ; c = eax
00651A9F  mov         eax,dword ptr [a] ; eax = a
00651AA2  add         eax,dword ptr [b] ; eax += b
00651AA5  sub         eax,dword ptr [c] ; eax -= c
00651AA8  mov         dword ptr [d],eax ; d = eax
```



### 곱하기 (정수)

```cpp
int main()
{
	int a{ 15 };
	int b{ 5 };
	int c{ a * b };
	return 0;
}
```

```assembly
00EC1A88  mov         dword ptr [a],0Fh ; a = 15
00EC1A8F  mov         dword ptr [b],5   ; b = 5
00EC1A96  mov         eax,dword ptr [a] ; eax = a
00EC1A99  imul        eax,dword ptr [b] ; eax *= b (imul)
00EC1A9D  mov         dword ptr [c],eax ; d = eax
```



### 곱하기 2

```cpp
int main()
{
	unsigned int a{ 65536 };
	unsigned int b{ 65535 };
	unsigned long long c{ a * b };
	unsigned long long d{ a * a };
	unsigned long long e{ (unsigned long long)a * a };
	return 0;
}
```

```assembly
00DE1728  mov         dword ptr [a],10000h    ; a = 65536
00DE172F  mov         dword ptr [b],0FFFFh    ; b = 65535

00DE1736  mov         eax,dword ptr [a]       ; eax = a
00DE1739  imul        eax,dword ptr [b]       ; eax *= b (imul)
00DE173D  xor         ecx,ecx                 ; ecx = 0
00DE173F  mov         dword ptr [c],eax       ; c = ecx
00DE1742  mov         dword ptr [ebp-20h],ecx

00DE1745  mov         eax,dword ptr [a]       ; eax = a
00DE1748  imul        eax,dword ptr [a]       ; eax *= a (imul)
00DE174C  xor         ecx,ecx                 ; ecx = 0
00DE174E  mov         dword ptr [d],eax       ; d = eax
00DE1751  mov         dword ptr [ebp-30h],ecx

00DE1754  mov         eax,dword ptr [a]       ; eax = a
00DE1757  mul         eax,dword ptr [a]       ; eax *= a (mul)
00DE175A  mov         dword ptr [e],eax       ; e = eax
00DE175D  mov         dword ptr [ebp-40h],edx 
```



### 나누기 (정수)

```cpp
int main()
{
	int a{ 15 };
	int b{ 5 };
	int c{ a / b };
	int d{ a % b };
	int e{ b / a };
	return 0;
}
```

```assembly
00731728  mov         dword ptr [a],0Fh ; a = 15
0073172F  mov         dword ptr [b],5   ; b = 5

00731736  mov         eax,dword ptr [a] ; eax = a
00731739  cdq  
0073173A  idiv        eax,dword ptr [b] ; eax /= b (idiv)
0073173D  mov         dword ptr [c],eax ; c = eax(몫)

00731740  mov         eax,dword ptr [a] ; eax = a
00731743  cdq  
00731744  idiv        eax,dword ptr [b] ; eax /= b (idiv)
00731747  mov         dword ptr [d],edx ; c = edx(나머지)

0073174A  mov         eax,dword ptr [b] ; eax = b
0073174D  cdq  
0073174E  idiv        eax,dword ptr [a] ; eax /= a (idiv)
00731751  mov         dword ptr [e],eax ; e = eax(몫)
```



### 나누기 2

```cpp
int main()
{
	unsigned int a{ 256 };
	unsigned int b{ 255 };
	unsigned int c{ a / b };
	return 0;
}
```

```assembly
00A84118  mov         dword ptr [a],100h   ; a = 256
00A8411F  mov         dword ptr [b],0FFh   ; b = 255
00A84126  mov         eax,dword ptr [a]    ; eax = a
00A84129  xor         edx,edx              ; edx = 0
00A8412B  div         eax,dword ptr [b]    ; eax /= b (div)
00A8412E  mov         dword ptr [c],eax    ; c = eax
```



### 더하기 빼기 (소수)

```cpp
int main()
{
	float a{ 1.5f };
	float b{ 2.25f };
	float c{ a + b };
	float d{ a + b - c };
	return 0;
}
```

```assembly
00451728  movss       xmm0,dword ptr [__real@3fc00000 (0457B30h)]  
00451730  movss       dword ptr [a],xmm0 ; a = 1.5f
00451735  movss       xmm0,dword ptr [__real@40100000 (0457B34h)]  
0045173D  movss       dword ptr [b],xmm0 ; b = 2.25f
00451742  movss       xmm0,dword ptr [a] ; xmm0에 a 복사
00451747  addss       xmm0,dword ptr [b] ; xmm0에서 b 빼기
0045174C  movss       dword ptr [c],xmm0 ; c에 xmm0 복사
00451751  movss       xmm0,dword ptr [a] ; xmm0에 a 복사
00451756  addss       xmm0,dword ptr [b] ; xmm0에서 b 더하기
0045175B  subss       xmm0,dword ptr [c] ; xmm0에서 c 빼기
00451760  movss       dword ptr [d],xmm0 ; d에 xmm0 복사
```



### 곱하기 나누기 (소수)

```cpp
int main()
{
	float a{ 1.5f };
	float b{ 2.25f };
	float c{ a * b };
	float d{ a / b };
	return 0;
}
```

```assembly
00561728  movss       xmm0,dword ptr [__real@3fc00000 (0567B30h)]  
00561730  movss       dword ptr [a],xmm0 ; a = 1.5f;
00561735  movss       xmm0,dword ptr [__real@40100000 (0567B34h)]  
0056173D  movss       dword ptr [b],xmm0 ; b = 2.25f;
00561742  movss       xmm0,dword ptr [a] ; xmm0에 a 복사
00561747  mulss       xmm0,dword ptr [b] ; xmm0에 b (소수)곱하기
0056174C  movss       dword ptr [c],xmm0 ; c에 xmm0 복사
00561751  movss       xmm0,dword ptr [a] ; xmm0에 a 복사 
00561756  divss       xmm0,dword ptr [b] ; xmm0에서 b (소수)나누기
0056175B  movss       dword ptr [d],xmm0 ; d에 xmm0 복사
```



## 변수

```cpp
int main()
{
	int a{ 1 };
	int b{};
	b = 2;
	int c;
	c = 3;
	int d = 4;
	return 0;
}
```

```assembly
00E21A88  mov         dword ptr [a],1 
00E21A8F  mov         dword ptr [b],0 
00E21A96  mov         dword ptr [b],2 
00E21A9D  mov         dword ptr [c],3 
00E21AA4  mov         dword ptr [d],4 
```



## 함수 호출

### 인수 순서

```cpp
void foo(char ch, short s, int i) {}
int main()
{
	foo('a', 256, 65536);
	return 0;
}
```

```assembly
00561AE8  push        10000h ; i = 65536
00561AED  push        100h ; s = 256
00561AF2  push        61h ; ch = 'a'
00561AF4  call        foo (056155Fh)  
00561AF9  add         esp,0Ch ; 스택 해제 (4 * 3 = 12)
```



### 스택의 단위

```cpp
void foo(char ch0, char ch1) 
{
	char* _ch0{ &ch0 }; // 메모리 확인용
	char* _ch1{ &ch1 }; // 메모리 확인용
}
int main()
{
	foo('a', 'b');
	return 0;
}
```

```assembly
00781AE8  push        62h ; ch1 = 'b'
00781AEA  push        61h ; ch0 = 'a'
00781AEC  call        foo (078156Eh)  
00781AF1  add         esp,8 ; 스택 해제 (4 * 2 = 8)
```



## 매개변수 자료형 비교

### 오브젝트 자료형 매개변수 1

```cpp
struct Name
{
	char name[256]{};
};
void print_name(Name x)
{
    printf("%s\n", x.name);
}
int main()
{
	Name a{ "first" };
	print_name(a);
    return 0;
}
```

```asm
005821BB  sub         esp,100h ; 스택 확보(256 바이트) == 인수
005821C1  mov         ecx,40h ; 반복 횟수 저장(4바이트 * 64회)
005821C6  lea         esi,[a] ; 반복할 source의 주소 저장
005821CC  mov         edi,esp ; 반복될 곳의 주소 지정
005821CE  rep movs    dword ptr es:[edi],dword ptr [esi] ; dword(4바이트) 단위로 반복 복사
; 함수 호출 전 연산 == 4 + 64 == 70회
005821D0  call        print_name (058152Dh) ; print_name() 호출
005821D5  add         esp,100h ; 스택 해제
```



### 오브젝트 자료형 매개변수 2

```cpp
struct Name
{
	char name[256]{};
};
void print_name(Name x, Name y)
{
	printf("%s\n%s\n", x.name, y.name);
}
int main()
{
	Name a{ "first" }, b{ "second" };
	print_name(a, b);
	return 0;
}
```

```assembly
00912201  sub         esp,100h  
00912207  mov         ecx,40h  
0091220C  lea         esi,[b]  
00912212  mov         edi,esp  
00912214  rep movs    dword ptr es:[edi],dword ptr [esi]  
00912216  sub         esp,100h  
0091221C  mov         ecx,40h  
00912221  lea         esi,[a]  
00912227  mov         edi,esp  
00912229  rep movs    dword ptr es:[edi],dword ptr [esi]
; 함수 호출 전 연산 == (4 + 64) + (4 + 64) == 140회
0091222B  call        print_name (0911537h)  
00912230  add         esp,200h 
```



### 포인터 매개변수 1

```cpp
struct Name
{
	char name[256]{};
};
void print_name(Name* x)
{
    printf("%s\n", x->name);
}
int main()
{
	Name a{ "first" };
	print_name(&a);
    return 0;
}
```

```assembly
009821BB  lea         eax,[a] ; a의 주소를 eax에 복사
009821C1  push        eax ; 스택에 eax의 값(a의 주소)이 저장됨 == 인수
; 함수 호출 전 연산 == 2회
009821C2  call        print_name (0981532h) ; 함수 호출
009821C7  add         esp,4 ; 스택 해제
```



### 포인터 매개변수 2

```cpp
struct Name
{
	char name[256]{};
};
void print_name(Name* x, Name* y)
{
	printf("%s\n%s\n", x->name, y->name);
}
int main()
{
	Name a{ "first" }, b{ "second" };
	print_name(&a, &b);
	return 0;
}
```

```assembly
00B02201  lea         eax,[b]
00B02207  push        eax
00B02208  lea         ecx,[a]
00B0220E  push        ecx
; 함수 호출 전 연산 == 2 * 2 == 4회
00B0220F  call        print_name (0B0153Ch)
00B02214  add         esp,8
```



### 포인터 매개변수 3

```cpp
struct Name
{
	char name[256]{};
};
void print_name(Name* x, Name* y, Name* z, Name* w)
{
	printf("%s\n%s\n%s\n%s\n", x->name, y->name, z->name, w->name);
}
int main()
{
	Name a{ "first" }, b{ "second" }, c{ "third" }, d{ "last" };
	print_name(&a, &b, &c, &d);
	return 0;
}
```

```assembly
00EC2128  lea         eax,[d] 
00EC212E  push        eax
00EC212F  lea         ecx,[c]
00EC2135  push        ecx
00EC2136  lea         edx,[b]
00EC213C  push        edx
00EC213D  lea         eax,[a]
00EC2143  push        eax
; 함수 호출 전 연산 == 4 * 2 == 8회
00EC2144  call        print_name (0EC1582h)  
00EC2149  add         esp,10h
```

