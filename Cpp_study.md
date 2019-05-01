# C++ tutorial

## 1. Base

메모리 조작

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

5.4라는 소수는 5라는 정수로 강제 형변환이 일어나고, 코드는 정상적으로 실행이 된다. 그러나 이 과정에서 **축소 변환(narrowing conversion)**으로 인한 데이터 손실이 발생할 수 있다.

이러한 데이터 손실이 발생하는 일을 막기 위해 더 나은 초기화 방법이 있다. 바로 중괄호를 사용하는 것이다.

```cpp
int my_variable{ 5.4 }; // 오류 발생! 코드는 실행되지 않는다.
```

위와 같이 코드를 작성하면  축소 변환에 대한 오류가 발생하여 코드가 실행이 되지 않는다!

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
리턴자료형 함수명(매개변수자료형 매개변수명)
{
    // 실행할 코드를 입력할 곳 //
    return 결과값;
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

## 포인터

32비트에선 4바이트, 64비트에선 8바이트!!

### Static

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

    // This is legal!
	*p = 5;
	
	return 0;
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

