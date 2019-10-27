# 프로세스

## 메모리 구조

data - 전역/static변수

code

stack - 지역변수(local variable == automatic variable), 함수 매개변수(parameter)

heap - 동적 할당된 변수



# 변수

## 전역/static 변수가 저장되는 메모리 공간

메모리 data 영역에 저장됨. 컴파일될 때 초기값이 같이 저장됨



## 전역/static 변수의 초기화

```cpp
int a; // a의 값은 0으로 초기화된다 (main()이 호출되기 전에 초기화 된다!)
int* p; // p의 값은 nullptr로 초기화된다.

int main()
{
	static int sa; // 0
    static int* sp; // nullptr
	return 0;
}
```



## 전역 변수의 초기화 시점

```cpp
#include <iostream>

using namespace std;

class CCounter
{
public:
	CCounter() { m_ID = ++ms_Counter; }
	CCounter(const CCounter& b) { m_ID = ++ms_Counter; }
	int GetID() const { return m_ID; }

private:
	int m_ID{};
	static int ms_Counter;
};

int CCounter::ms_Counter;

CCounter gA{}; // 전역변수들. main()이 호출되기 전에 초기화 된다!★
CCounter gB{};

int Foo(CCounter X) // 복사 생성자가 호출된다.
{
	CCounter* const pX{ &X }; // a와 주소가 다르다 (복사가 일어났기 때문)
	return X.GetID();
}

int Bar(CCounter& X) // 단순 참조!
{
	CCounter* const pX{ &X }; // a와 주소가 같다.
	return X.GetID();
}

int main()
{
	static CCounter sA{}; // static 변수는 처음 선언되는 순간 딱 한 번 초기화된다!
	CCounter A{};
	CCounter* const pA{ &A }; // a의 주소

	cout << gA.GetID();
	cout << gB.GetID();
	cout << sA.GetID();
	cout << A.GetID();
	cout << Foo(A);
	cout << Bar(A);

	return 0;
}
```



## 포인터

### 포인터 변수의 ++ / -- 연산 (자료형의 크기만큼 주소가 이동된다★)

```cpp
int a{};
int* pa{ &a }; // pa가 저장하고 있는 주소는 0x00AABBC0
++pa; // pa가 저장하고 있는 주소는 0x00AABBC4

void* pany{ pa };
++pany; // 컴파일 불가!!
```

```cpp
void copy_post(char* dest, char* src)
{
	while (*src != '\0')
	{
		*dest++ = *src++; // 후위 증가 연산자(post-increment operator)
        
        // 위 코드는 아래와 같음
        //*dest = *src;
		//++dest;
		//++src;
	}
}
```

```cpp
void copy_pre(char* dest, char* src)
{
	while (*src != '\0')
	{
		*++dest = *++src; // 전위 증가 연산자(pre-increment operator)
        
        // 위 코드는 아래와 같음
        // ++dest;
		//++src;
		//*dest = *src;
	}
}
```

### const * vs. * const

```cpp
#include <iostream>

using namespace std;

int main()
{
	int a{ 13 };
	int b{ 17 };
	const int* x{ &a };
	int* const y{ &a };
	const int* const z{ &a };

	x = &b; // x는 const int에 대한 그냥 포인터니까, 참조는 바꿀 수 있다.
	y = &b; // y는 int에 대한 const 포인터니까, 참조를 바꿀 수 없다.

	(*x)++; // x는 const int에 대한 포인터니까, 역참조 값을 바꿀 수 없다.
	(*y)++; // y는 int에 대한 포인터니까, 역참조 값을 바꿀 수 있다.

	(*z)++; // z는 const int에 대한 const 포인터니까, 참조도 역참조도 바꿀 수 없다.
	z = &b;

	return 0;
}
```



# 함수

## 매개변수와 객체

```cpp
#include <iostream>

using namespace std;

class CAny
{
public:
	CAny() { cout << "in constructor\n"; }
	CAny(const CAny& b) { cout << "in copy constructor\n"; }
    ~CAny() { cout << "in destructor\n"; }
};

void foo(CAny X)
{
	cout << "in foo()\n";
}

int main()
{
	cout << "in main()\n";

	CAny A{};
	foo(A);

	return 0;
}
```



## 호출 순서

```cpp
bool ReturnTrue()
{
	cout << "true\n";
	return true;
}

bool ReturnFalse()
{
	cout << "false\n";
	return false;
}

int main()
{
	if (ReturnTrue() ^ ReturnFalse())
		cout << "Case0\n";

	if (ReturnFalse() ^ ReturnTrue())
		cout << "Case1\n";

	if (ReturnTrue() ^ ReturnTrue())
		cout << "Case2\n";

	return 0;
}
```



# struct

```cpp
struct SAny // int 기준 정렬 (12바이트)
{
	char a{};
	char b{};
	int c{};
	bool d{};
};

struct SAny2 // double 기준 정렬 (16바이트)
{
	char a{};
	char b{};
	int c{};
	double d{};
};
```



# union

```cpp
union U
{
	unsigned char a;
	unsigned short b;
	unsigned int c;
};

int main()
{
	U x;
	memset(&x, 256, sizeof(x));
	return 0;
}
```

# class

## 생성자(ctor), 소멸자(dtor), 상속

```cpp
// F11 누르면서 따라가보기!!!

class A
{
public:
	A() 
	{
		cout << "A constructor\n"; 
	}
	virtual ~A()
	{
		cout << "A destructor\n"; 
	}
};

class B : public A
{
public:
	B()
	{ 
		cout << "B constructor\n"; 
	}
	virtual ~B() 
	{
		cout << "B destructor\n"; 
	}
};

int main()
{
	A x{};

	A* y{ new B() }; // B의 생성자가 호출되면 거기서 A의 생성자가 호출되어서 먼저 A의 생성자가 실행되고, 그 후 B의 생성자로 돌아와서 B의 생성자가 실행된다!
	delete y; // B의 소멸자가 먼저 호출되고, A의 소멸자가 호출된다.

	return 0;
}
```



# 연산자

비트 연산자 (bitwise operator: & | ^ ★~)

```cpp
int main()
{
	unsigned char a{ 0b11011011 };
	unsigned char b{ 0b10101010 };
	unsigned char r{};

	r = a & b;

	r = a | b;

	r = a ^ b;

	r = ~a;
	
	r = ~b;

	return 0;
}
```

비트 시프트 연산자 (<< , >>)

```cpp
int main()
{
	unsigned char a{ 0b11011011 }; // 앞의 1101
	unsigned char b{ 0b01101010 }; // 뒤의 1010
	unsigned char r{};

	a = a >> 4;
	b = b << 4; // b = (b << 4) >> 4; => 주석처럼 하면 왼쪽 비트들이 손실되지 않음! 즉, 그냥 원래 b랑 같음.
	b = b >> 4;

	return 0;
}
```

논리 연산자 (&& || ^ !)

