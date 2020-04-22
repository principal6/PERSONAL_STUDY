# C++ tutorial

## 0. 개요

1. Hello world (#include, cout)
2. 변수와 함수 (char, int, float, double + 배열, 문자열)
3. 콘솔 입력 받기 (cin)
4. 조건문 (if, switch) & 비교 연산자, 논리 연산자
5. 반복문 (for, while)
6. 구조체 (struct)
   1. 캐릭터 관리 프로그램 만들기 (인간 캐릭터, 거인 캐릭터, 난쟁이 캐릭터 등 다양화)
7. 클래스 (class) + #include, namespace, static 키워드
8. 별칭, 매크로 using, #define
9. 포인터 (pointer), 참조형 (reference type)
10. 상속 (inheritance) 과 다형성(polymorphism) + private, protected, public
11. 열거형 (enum class)



## 프로세스

### 메모리 구조

data - 전역/static변수

code

stack - 지역변수(local variable == automatic variable), 함수 매개변수(parameter)

heap - 동적 할당된 변수



## 변수

### 변수 선언

변수를 선언하는 방법은 다음과 같다.

```cpp
int my_variable; // 변수를 선언하고 있다.
```

int는 integer의 줄임말로, 영어로 '정수'를 뜻하는 단어이고, my_variable는 변수의 이름이다.

즉, 우리는 정수형 변수 my_variable을 선언했다. 이제 해당 변수에 값을 대입해 보자.

```cpp
int my_variable;
my_variable = 5; // 변수에 값을 대입하고 있다.
```

my_variable = 5;라는 코드 한 줄이 더 추가됐다.

이는 my_variable라는 변수에 5라는 정수를 **대입(assign)**한다는 뜻이다.

그런데, 위의 코드를 더 간단하게 쓸 수 있는 방법은 없을까?

```cpp
int my_variable = 5; // 선언과 대입 두 줄이 한 줄로 줄어들었다!
```

위와 같이 쓰면 변수를 선언함과 동시에 대입을 할 수 있다.

사실 이렇게 변수를 선언할 때 초기값을 지정하는 일을 **초기화(initialization)**라고 부른다.

```cpp
int my_variable = 5.4; // 정상적으로 실행된다. 하지만...?
```

그렇다면 정수형 변수에 소수를 대입하면 어떻게 될까?

5.4라는 소수는 5라는 정수로 강제 형변환이 일어나고, 코드는 정상적으로 실행이 된다. 그러나 이 과정에서 **축소 변환(narrowing conversion)**으로 인한 데이터 손실이 발생한다.

이러한 데이터 손실이 발생하는 일을 막기 위해 더 나은 초기화 방법이 있다. 바로 중괄호를 사용하는 것이다. (**유니폼 초기화**)

```cpp
int my_variable{ 5.4 }; // 오류 발생! 코드는 실행되지 않는다.
```

위와 같이 코드를 작성하면  축소 변환에 대한 오류가 발생하여 코드가 컴파일되지 않는다!

따라서 중괄호를 사용하면 초기화 시 실수로 축소 변환하는 일을 원천적으로 막을 수 있다.

```cpp
int my_variable{ 5 }; // 정상적으로 실행된다!
```

기본적으로 변수를 선언할 때는 **항상 초기화를 해야 한다.** 그렇지 않으면 우리가 원하지 않는 이상한 값이 변수 안에 들어 있어 후에 오류가 발생할 확률이 높아지기 때문이다.

그런데, 어떤 값으로 초기화해야할 지 모를 땐 어떻게 하면 좋을까?

```cpp
int my_variable{}; // 자동으로 0이라는 숫자로 초기화 된다!
```

위와 같이 쓰면 특정 값을 지정하지 않고 초기화를 진행할 수 있다.

이와 같은 초기화 방법은 굉장히 유용한데, 나중에 클래스를 배울 때 다시 한 번 이야기하겠다.



```cpp
int my_variable{}; // my_variable이라는 변수를 선언 및 0으로 초기화했다.
my_variable = my_variable + 1; // my_variable의 값을 1 증가시킨다.
```

my_variable이라는 변수를 선언했고 초기화도 했는데, 변수의 값을 증가시키고 싶을 땐 어떻게 하면 될까?

결론은 my_variable + 1 (즉, 0 + 1)이라는 값을 my_variable이라는 변수에 다시 대입하면 된다.

```cpp
my_variable = my_variable + 1;
```

위 줄이 바로 해당 코드다.

```cpp
int my_variable{};
my_variable = my_variable + 4; // 더하기 4
my_variable = my_variable * 3; // 곱하기 3
my_variable = my_variable - 2; // 빼기 2
my_variable = my_variable + 1; // 더하기 1
my_variable = my_variable - 1; // 빼기 1
```

하지만, 위와 같은 방법은 my_variable이라는 변수명을 두 번 써야하는 번거로움이 있다.

그래서 C++에서는 더욱 간편한 계산 방법을 제공한다.

```cpp
int my_variable{};
my_variable += 4; // 코드 가독성이 훨씬 높아졌고, 쓰기도 편하다.
my_variable *= 3;
my_variable -= 2;
my_variable += 1;
my_variable -= 1;
```

코드가 훨씬 간단해졌다.

실제 프로그래밍에서는 정수형 변수의 값을 1씩 증가 혹은 감소시키는 일이 굉장히 흔하다.

따라서 더욱 더 간편한 방법도 제공된다.

```cpp
int my_variable{};
my_variable += 4;
my_variable *= 3;
my_variable -= 2;
++my_variable; // 훨씬 간편해졌다!
--my_variable; // 마찬가지.
```

지금까지는 정수형 변수만 다뤄봤다.

다른 **자료형(data type)**에 대해서도 알아보자.

```cpp
int my_integer{}; // 정수형
char my_character{}; // 문자
float my_floating_point{}; // 부동소숫점
double my_double_precision_floating_point{}; // 정확도가 더 높은 부동소숫점
```

이 외에도 다음과 같은 자료형들이 존재한다.

```cpp
short my_short_integer{};
long my_long_interger{};
long long my_long_long_integer{};
wchar_t my_wide_character{};
```

위에서 언급된 자료형들은 모두 C++에 기본적으로 존재하는 **내장형 자료형(built-in type)**들이다.

사실 우리 인간이 보기에는 정말 다양하고 많은 자료형이 존재하지만, 컴퓨터 입장에서는 0 또는 1만을 볼 수 있다. (컴퓨터는 0과 1만으로 이루어져 있다!)

그런데 0과 1로 표현할 수 있는 경우의 수는 고작 2개(`0 또는 1`)에 불과하다. 그래서 컴퓨터는 똑똑하게도, 8칸을 하나로 묶어서 데이터 저장의 최소 단위로 사용한다. 0또는 1이라는 값을 가질 수 있는 한 칸을 **비트**(**bit** = **bi**nary digi**t**)라고 부른다. 그리고 8개의 비트를 모아 **바이트**(**byte**, **b**inar**y** **te**rm)라고 부른다.
$$
한\ 개의\ 바이트가\ 나타낼\ 수\ 있는\ 경우의\ 수는\ 총\ 2^8가지다.\\
2^8 = 256가지
$$


예를 들어, **십진법(decimal system)**으로 표기된 `13`이라는 숫자를 컴퓨터의 시각에서 보려면 **이진법(binary system)**으로 바꾸어야 한다. 십진법으로 표기된 `13` 은 이진법으로 표기하면  `111`이다. 잠깐, 그런데 그냥 `111`이라고만 표기하면 십진수 백십일(`111`)과 혼동할 우려가 있으므로, 앞으로 십진수는 `111` , 이진수는 `0b00000111`처럼 표기하겠다.

예를 들어, 십진법으로 표기된 숫자 `12`는 이진법으로 나타내면 `0b00000110`이다.
$$
0 = 0b0\\
1 = 0b1\\
2 = 0b10\\
3 = 0b11\\
4 = 0b100\\
...\\
12 = 0b110\\
13 = 0b111
$$
사실 컴퓨터 내에 저장되는 모든 정보는 이렇듯 **이진수**로 바뀌어 저장된다.

잠깐, 그러면 `abcd`와 같은 **문자**들은 어떻게 숫자로 저장되는 걸까?

문자를 숫자로 바꾸기(`convert`) 위해 각각의 문자는 그에 해당하는 고유의 숫자를 가진다. 예를 들어, 문자 `a`는 숫자 `97` 즉, `0b01100001`이라는 숫자에 해당한다. 문자 `b`는 숫자 `98`, 즉 `0b01100010`에 해당한다.

`hello`와 같은 **문자열**(**문자**의 배**열**이라는 의미에서 이렇게 부른다)은 컴퓨터 입장에서는 `104` `101` `108` `108` `111` 처럼 5개의 연속된 숫자에 불과하다. 물론 컴퓨터 입장에선 `0b01101000` `0b01100101` `0b01101100` `0b01101100` `0b01101111` 처럼 위의 숫자들을 이진법으로 저장한다.
$$
a=97=0b01100001\\
b=98=0b01100010\\
...\\
e=101=0b01100101\\
...\\
h=104=0b01101000\\
...\\
l=108=0b01101100\\
...\\
o=111=0b01101111\\
　\\
\begin{matrix}
|h|e|l|l|o|&=&|104|101|108|108|111|
\end{matrix}
\\
$$









```cpp
#include <iostream>

int MultiplyByTwo(int input_value)
{
    return input_value * 2;
}

int main()
{
    int integer_variable{};
    integer_variable = MultiplyByTwo(3);
    
    std::cout << integer_variable;
    
    return 0;
}
```

프로그램은 함수의 조합으로 이루어진다.

잠시 고등학교 수학 시간에 배운 내용을 떠올려 보자.

함수 `f(x) = 2x + 1`이라고 할 때,

`a = f(2)`라면, `a`의 값은 `2 × 2 + 1 = 5` 로, `a = 5`가 된다.

여기서 f는 함수의 영어 이니셜(**f**unction)에서 온 글자이고,

`f(x)`에서 괄호 안에 들어가 있는 `x`값이 바로 입력값이 되고,

`f(2)`가 `5`가 된 사실에서 볼 수 있듯이, `f(x)`는 `x`라는 입력값이 있을 때 그 **결과값**이 된다.

C++에서 함수도 수학에서의 함수와 마찬가지다.

C++의 **함수**는 아래와 같은 형태로 만들어진다.

(C++에서는 함수의 입력값을 **매개변수(parameter)**라고 부른다.)

```cpp
리턴자료형 함수이름(매개변수1자료형 매개변수1이름, 매개변수2자료형 매개변수2이름, ...)
{
    // 실행할 코드를 입력할 곳 //
    return 리턴값;
}
```

예를 들어,

```cpp
int TwoXPlusOne(int input)
{
    return input * 2 + 1;
}
```

위의 `TwoXPlusOne()` 함수는 정수(int) 값을 `input`이라는 이름의 변수에 입력받는다. 그리고 `input`변수에 저장된 값에 2를 곱하여 리턴(return)한다. int값에 2를 곱하면 결과 역시 int이므로 리턴자료형은 int여야 한다.



### scope

```cpp
void foo()
{
    a = 4;
}
int main()
{
    int a{};
    foo();
    return 0;
}
```

#### static / extern



### 전역/static 변수가 저장되는 메모리 공간

메모리 data 영역에 저장됨. 컴파일될 때 초기값이 같이 저장됨



### 전역/static 변수의 초기화★

```cpp
int a; // a의 값은 0으로 초기화된다
int* p; // p의 값은 nullptr로 초기화된다.

int main()
{
	static int sa; // 0
    static int* sp; // nullptr
	return 0;
}
```



### 전역 변수의 초기화 시점

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

CCounter gA{}; // ★ 전역변수들. main()이 호출되기 전에 초기화 된다! ★
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



## 전처리기

### include

헤더 파일: `.h` / `.hpp` (hpp는 명시적으로 C++의 헤더파일임을 알려줌)

#### forward declaration (전방 선언)

### macro

#### Source-code Annotation Language (SAL)

`<sal.h>`에 정의됨

```cpp
void foo(_In_ int a, _Inout_ int* b, _Out_ int* c, _Outptr_ int** d, _In_opt_ int e)
{
    // ...
}
```



## 포인터

### 바이트 크기

32비트에선 4바이트, 64비트에선 8바이트!!

### shallow copy VS. deep copy

포인터를 복사하면 얕은 복사(shallow copy)

포인터가 가리키는 데이터를 복사하면 깊은 복사(deep copy)

### 포인터 변수의 ++ / -- 연산 (자료형의 크기만큼 주소가 이동된다★)

```cpp
int a{};
int* pa{ &a }; // pa가 저장하고 있는 주소는 0x00AABBC0
++pa; // pa가 저장하고 있는 주소는 0x00AABBC4

void* pany{ pa };
++pany; // 컴파일 불가!!★
```

```cpp
void copy_post(char* dest, char* src)
{
	while (*src != '\0')
	{
		*dest++ = *src++; // 후위 증가 연산자(post-increment operator)
        
        /* 위 코드는 아래와 같음
        *dest = *src;
		++dest;
		++src;
		*/
	}
}
```

```cpp
void copy_pre(char* dest, char* src)
{
	while (*src != '\0')
	{
		*++dest = *++src; // 전위 증가 연산자(pre-increment operator)
        
        /* 위 코드는 아래와 같음
        ++dest;
		++src;
		*dest = *src;
		*/
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



## 참조형

```cpp
void foo(int (&ref)[4])
{
	
};
```



## 함수

### 매개변수와 객체

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
	cout << "head of foo()\n";
	cout << "tail of foo()\n";
}

int main()
{
	cout << "head of main()\n";

	CAny A{};
	foo(A);

	cout << "tail of main()\n";

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



## struct

### 바이트 크기

```cpp
struct Empty // 1 바이트
{
};

struct One // 1 바이트
{
    char character{};
};

struct Two // 2 바이트
{
    char character[2]{};
};
```



### 바이트 정렬

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



## union

### 바이트 크기

```cpp
union Empty // 1 바이트
{
};

union Four // 4 바이트
{
	char ch[4];
	int i{};
};
```

### 구조

```cpp
union U
{
    unsigned char a;
    unsigned short b;
    unsigned int c{};
};

int main()
{
    U x;
    //      ┌───────────────────┐
    //      │         U         │
    //      ├────┬────┬────┬────┤
    // (0x) │ 00 │ 01 │ 02 │ 03 │
    //      ├────┴────┼────┼────┤
    //      │         │    │ a  │
    //      │         ├────┴────┤
    //      │         │    b    │
    //      ├─────────┴─────────┤
    //      │         c         │
    //      └───────────────────┘
    x.c = 0x00010203;
    return 0;
}
```



### union + struct

```cpp
union UnionTest
{
	struct
	{
		float x, y, z, w;
	};
	float v[4]{};
};
```



## class

### 바이트 크기

```cpp
class Empty // 1 바이트
{
public:
	Empty() {}
	~Empty() {}
};
```

```cpp
class One // 1 바이트
{
public:
	One() {}
	~One() {}

private:
	char m_char{ 'k' };
};
```

```cpp
class Eight // 8 바이트
{
public:
	Eight() {}
	~Eight() {}

private:
	char m_char{ 'k' };
	int m_int{ 7 };
};
```

```cpp
class Base // 8바이트 (vtable(4) + char(1) => 바이트 정렬)
{
public:
	Base(char ID) : m_ID{ ID } { std::cout << m_ID << ": in base constructor\n"; }
	virtual ~Base() { std::cout << m_ID << ": in base destructor\n"; }
protected:
	char m_ID{};
};
```



### ★생성자(ctor), 소멸자(dtor), 상속

```cpp
#include <iostream>

class Base
{
public:
	Base() { std::cout << "In base constructor\n"; }
	virtual ~Base() { std::cout << "In base destructor\n"; }
};

class Derived : public Base
{
public:
	Derived()  { std::cout << "In derived constructor\n"; }
	~Derived() { std::cout << "In derived destructor\n"; }
};

int main()
{
	Base* a{ new Derived() };
	delete b;

	// In base constructor
	// In derived constructor
	// In derived destructor
	// In base destructor

	return 0;
}
```



```cpp
#include <iostream>

class Base
{
public:
	Base(char ID) : m_ID{ ID } { std::cout << m_ID << ": in base constructor\n"; }
	virtual ~Base() { std::cout << m_ID << ": in base destructor\n"; }
protected:
	char m_ID{};
};

class Derived : public Base
{
public:
	Derived(char ID) : Base(ID) { std::cout << m_ID << ": in derived constructor\n"; }
	~Derived() { std::cout << m_ID << ": in derived destructor\n"; }
};

int main()
{
	Base a{ 'a' };

	// Derived의 생성자가 호출★되면 거기서 Base의 생성자가 호출★되어서 먼저 Base의 생성자가 실행★되고, 그 후 Derived의 생성자로 돌아와서 B의 생성자가 실행★된다!
	Base* b{ new Derived('b') };
	delete b; // Derived의 소멸자가 먼저 실행되고, Base의 소멸자가 실행된다.
    
    // a: in base constructor
	// b: in base constructor
	// b: in derived constructor
	// b: in derived destructor
	// b: in base destructor
	// a: in base destructor

	return 0;
}
```



```cpp
#include <iostream>

class Base
{
public:
	Base(char ID) : m_ID{ ID } { std::cout << "in base constructor\n"; }
	virtual ~Base() { std::cout << "in base destructor\n"; }
};

class Derived : public Base
{
public:
	Derived() { std::cout << "in derived constructor\n"; }
	virtual ~Derived() { std::cout <<"in derived destructor\n"; }
};

int main()
{
	Derived a{};
	Base b{ a };
	return 0;
}
```



```cpp
#include <iostream>

class Base
{
public:
	Base() {}
	virtual ~Base() {}
};

class Derived : public Base
{
public:
	Derived(int _value) : value{ _value } {}
	~Derived() {}
	int value{};
};

int main()
{
	Derived a{ 7 };
	Base b{ a };
	std::cout << a.value << std::endl;
	std::cout << ((Derived*)&b)->value << std::endl;
	return 0;
}
```



### 멤버 초기화

in-class 말고 생성자에서 초기화, 소멸자에서 해제하면 좋겠다! (forward declaration이 많을 수록 더더욱..?)



### 오버라이딩

```cpp
#include <iostream>

class Base
{
public:
	Base() {}
	virtual ~Base() {}
	virtual void OverrideThis() { std::cout << "base function\n"; }
};

class Derived : public Base
{
public:
	Derived() {}
	~Derived() {}
	void OverrideThis() override { std::cout << "override function\n"; }
};

int main()
{
	Base* a{ new Base() };
	Base* b{ new Derived() };
    Base c{ *b };
	a->OverrideThis(); // "base function"
	b->OverrideThis(); // "override function"
    c.OverrideThis(); // "base function"
	delete b;
	delete a;
	return 0;
}
```



## 연산자

### 비트 연산자 (bitwise operator: & | ^ ★~)

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

### 비트 시프트 연산자 (<< , >>)

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

### 논리 연산자 (&& || ^ !)



## enum flags

```cpp
#define ENUM_CLASS_FLAG(enum_type)\
static enum_type operator|(enum_type a, enum_type b)\
{\
	return static_cast<enum_type>(static_cast<int>(a) | static_cast<int>(b));\
}\
static enum_type& operator|=(enum_type& a, enum_type b)\
{\
	a = static_cast<enum_type>(static_cast<int>(a) | static_cast<int>(b));\
	return a;\
}\
static enum_type operator&(enum_type a, enum_type b)\
{\
	return static_cast<enum_type>(static_cast<int>(a) & static_cast<int>(b));\
}\
static enum_type& operator&=(enum_type& a, enum_type b)\
{\
	a = static_cast<enum_type>(static_cast<int>(a) & static_cast<int>(b));\
	return a;\
}\
static enum_type operator^(enum_type a, enum_type b)\
{\
	return static_cast<enum_type>(static_cast<int>(a) ^ static_cast<int>(b)); \
}\
static enum_type& operator^=(enum_type& a, enum_type b)\
{\
	a = static_cast<enum_type>(static_cast<int>(a) ^ static_cast<int>(b)); \
	return a; \
}\
static enum_type operator~(enum_type a)\
{\
	return static_cast<enum_type>(~static_cast<int>(a)); \
}

enum class EFlagsPosition
{
	None	= 0x00,
	Top		= 0x01,
	Bottom	= 0x02,
	Left	= 0x04,
	Right	= 0x08,
};
ENUM_CLASS_FLAG(EFlagsPosition)

int main()
{
	EFlagsPosition eFlagsPosition{ EFlagsPosition::Top | EFlagsPosition::Bottom };
	eFlagsPosition |= EFlagsPosition::Left;

	return 0;
}
```



## static

```cpp
int* p{};

void foo()
{
    // Static variable's lifetime differs from its scope!
	static int x{ 4 };
	p = &x;
}

int main()
{
	foo();

    // This is legal!★
	*p = 5;
	
	return 0;
}
```



## class

### 생성자

#### 복사생성자

```cpp
// 컴파일러가 만들어주는 기본 복사생성자는
// 얕은 복사(shallow copy)를 한다.
Vector(const Vector& other)
{
    if (this != &other)
    {
        m_size = other.m_size;
        m_capacity = other.m_capacity;
        m_data = other.m_data;
    }
    return *this;
}
```

```cpp
Vector(const Vector& other)
{
    // 자기 자신을 복사하려 할 경우
    // new가 동일한 포인터에 일어나므로 메모리 누수가 발생한다!
    if (this != &other)
    {
        m_size = other.m_size;
        m_capacity = other.m_capacity;

        // 깊은 복사(deep copy)
        m_data = new T[m_capacity]{};
        memcpy(m_data, other.m_data, sizeof(T) * m_size);
    }
    return *this;
}
```



#### 복사대입연산자

```cpp
Vector& operator=(const Vector& other)
{
    // 자기 자신을 복사하려 할 경우
    // new가 동일한 포인터에 일어나므로 메모리 누수가 발생한다!
    if (this != &other)
    {
        m_size = other.m_size;
        m_capacity = other.m_capacity;

        // 깊은 복사(deep copy)
        m_data = new T[m_capacity]{};
        memcpy(m_data, other.m_data, sizeof(T) * m_size);
    }

    return *this;
}
```



## constexpr, const

```cpp
static int value = 10;
static constexpr int* ptr_value{ &value };
*ptr_value = 20; // 포인터 자체는 const지만, 포인터가 가리키는 값은 const가 아니기 때문에 변경할 수 있다!
static constexpr const int* const_ptr_value{ &value };
// *const_ptr_value = 30; // 오류 발생! const 한정자가 붙은 포인터는 포인터가 가리키는 값도 변경할 수 없다!!
```

## std::string

std::stoi(), std:stof() ...

## std::pair

```cpp
std::pair<int, char> test{std::make_pair(3, 'a')};
std::pair<int, char> test{3, 'a'}; // C++ 11 이후

// 개별 값은 first, second로 접근
```



## std::tuple

std::get<0>(~)

std::get<1>(~)

float a, b, c;

std::tie<a, b> = foo(3, 5); 로 리턴하는 것도 가능

 **=> 이제 auto [a, b] = foo(3, 5); 로 가능 (C++ 17)**

std::tie<a, std::ignore, c>로 무시도 가능



```cpp
// 좌변값 반환을 위해서는 std::tie 사용 필요
std::tuple<float&, float&> foo(float& a, float& b)
{
	return std::tie(a, b);
}
```



## 메모리 누수

### CRT DEBUG ###

```cpp
#include <crtdbg.h>

int main()
{
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
    return 0;
}
```



```cpp
// 메인 cpp 꼭대기에서
#ifdef _DEBUG
	#define _CRTDBG_MAP_ALLOC
	#include <stdlib.h>
	#include <crtdbg.h>
#endif

// 메인 함수 내에서
#ifdef _DEBUG
	_CrtSetDbgFlag(_CRTDBG_ALLOC_MEM_DF | _CRTDBG_LEAK_CHECK_DF);
	//_CrtSetBreakAlloc(1374600);
#endif
```



## __declspec

### __declspec(deprecated("~"))

```cpp
__declspec(deprecated("This function is deprecated. Use DrawInstancedBoundingVolume() instead.")) void DrawBoundingVolumesNoInstancing(SComponentRender& Component) noexcept;
```



## 어셈블리

### 레지스터

AX = Accumulator register (덧셈 뺄셈 등에 이용)

CX = Counter register (반복문 등)



SP = Stack pointer

BP = stack Base Pointer

IP = Instruction pointer

```cpp
int Add(int a, int b)
{
    return a + b;
}

int main()
{
    int my_sum = Add(3, 4);
}

// 함수 호출 방식: C, PASCAL, STDCALL
// EIP 레지스터에 다음 실행될 주소가 저장됨
// ASM
__asm
{
push 4 // 인수#1에 4 대입
push 3 // 인수#0에 3 대입
call Add (0D8137Ah) // 함수 호출
add  esp, 8 // Caller에서 스택의 높이를 낮춤!!★
mov dword ptr [my_sum], eax
...
ret
}


```



## GUID, UUID

```cpp
// UUID의 마이크로소프트 버전이 바로 GUID
#include <guiddef.h>

// 참고
typedef struct _GUID {
    unsigned long  Data1;
    unsigned short Data2;
    unsigned short Data3;
    unsigned char  Data4[ 8 ];
} GUID;

// 사용법
struct __declspec(uuid("00000001-0002-0003-0004-000000000005")) STest
{
	static constexpr int KAnyValue{ 5 };
	static constexpr const char* KAnyString{ "Test it." };
};

GUID what = __uuidof(STest);
```

## 멀티스레딩

thread safety

**concurrency 동시성**

API races (== data races + object races)

thread-safe type (동시에 사용해도 API race 발생 안 함!!)

deadlock (mutex lock때문에 발생...)

std::vector의 서로 다른 항목을 수정하는 것은 safe하지만... 웬만하면 하지 말까..? ㅋㅋ

### 주의할 것

#### 다수의 스레드가 같은 메모리(전역/static 변수)에 [쓰기] 작업을 하면 안 된다!★★★

#### const 속성이 있더라도 mutable이 있는지 확인!

#### const * 에 주의!!!!!★ (함수 포인터 포함...)

#### 여러 스레드가 같은 자료형을 읽거나 쓰는 걸 피하자...???

기타

```cpp
std::atomic;
std::this_thread;
sleep_for();
sleep_until();
yield(); //활동 포기, 다른 스레드에 자리 양보
std::lock_guard<std::mutex> guard(my_mutex); //(scope를 벗어나면 자동으로 unlock 호출!)
```

### atomic

atomicity = 실행 전이나 후 상태는 볼 수 있고, 실행 중에는 볼 수 없음! (즉, corruption 방지)

기본적으로 mutex 보다 빠르다! 하지만 spinlock이 atomic보다 더 빠른 경우는 있을 수 있다.

```cpp
std::atomic<int> x{};

void thread_1()
{
	++x;
}

void thread_2()
{
	++x;
}

// Result: x = 2;
```

#### atomic 연산

```cpp
std::atomic<int> x{};
x++; // atomic increment
++x; // atomic increment
x += 2; // atomic increment
x *= 2; // ERROR (There is no atomic multiplication)
x = x + 1; // NOT atomic (atomic read + atomic write => could be corrupted between the two operations!!)
x = x * 2; // NOT atomic (")
int y = x * 2; // atomic read
x = y + 1; // atomic write

int y = x.load();
x.store(y, std::memory_order_relaxed);
x.store(y, std::memory_order_acquire);
x.store(y, std::memory_order_release);
x.exchange(y);
bool is_done = x.compare_exchange_strong(y, z);
```

#### atomic 곱하기는?

```cpp
std::atomic<int> x{};
int x_save = x;
while (!x.compare_exchange_strong(x_save, x_save * 2)) {};
```

less error-prone atomic operation

```cpp
std::atomic<int> x{};
x.fetch_add(y); // x += y;
// fetch_sub(), fetch_and(), ...
```

#### atomic != lock_free

```cpp
std::atomic<T>::is_lock_free();

struct C {long x; long y; long z;} // not lock-free!
```

#### atomic != wait_free

서로 다른 atomic 변수더라도 같은 캐시 라인 (예를 들면 64바이트 이내)에 있다면 ... write할 때마다 캐시 업데이트 필요.. 즉 not-wait-free!!!

#### memory barrier

```cpp
x.store(1, std::memory_order_relaxed); // no memory barrier..
x.store(2, std::memory_order_release); // 이 instruction 이전에 '쓰기'한 메모리들은 실제로 먼저 쓰기를 한다!!★
x.load(std::memory_order_acquire); // 이 instruction 다음에 실행되는 '읽기'작업들은 실제로 다음에 일어난다!
x.store(3, std::memory_order_seq_cst); // default, and the strongest barrier
```

# SIMD (Single Instruction Multiple Data)
_ss = Scalar Single precision floating point
_ps = Packed Single-Precision Floating Point
SSE => __m128