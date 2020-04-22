# C++ thread

## 개념

### thread

스레드는 명령어 실행의 흐름이다. 프로세스는 thread로 이루어져 있다.

하나의 프로세스가 여러 개의 thread를 가질 수 있다. 여러 개의 thread를 가질 경우 이를 multithreading이라 한다. 이 경우 각 thread는 프로세스의 자원(resources)을 공유한다.

프로세스는 최소 하나의 thread를 가진다. 하나의 thread만 가질 경우 single-threading이라고 한다.



### concurrency vs. parallelism

프로세서가 하나라면 멀티 스레딩은 실제로 동시에 일어나는 게 아니라 시간 분할(time slicing)을 통해 이루어진다. 이를 concurrency라고 한다.

프로세서가 여러 개라면 실제로 동시에 여러개의 스레드가 실행될 수 있다. 이를 병렬성(parellelism)이라고 한다.



### multithreading 기본 예시

```cpp
#include <thread>
#include <iostream>
#include <Windows.h>
#include <conio.h>

constexpr CONSOLE_CURSOR_INFO KCCI{ sizeof(CONSOLE_CURSOR_INFO), false };
int g_a{}, g_b{};

void loop_a();
void loop_b();
void display(HANDLE hConsoleOutput);

int main()
{
	HANDLE hConsoleOutput{ GetStdHandle(STD_OUTPUT_HANDLE) };
	SetConsoleCursorInfo(hConsoleOutput, &KCCI);

	std::thread th_a{ loop_a };
	std::thread th_b{ loop_b };
	std::thread th_disp{ display, hConsoleOutput };
	th_disp.join();
	th_a.detach();
	th_b.detach();
	return 0;
}

void loop_a()
{
	while (true)
	{
		++g_a;
		Sleep(100);
	}
}

void loop_b()
{
	while (true)
	{
		g_b += 3;
		Sleep(400);
	}
}

void display(HANDLE hConsoleOutput)
{
	ULONGLONG StartTime{ GetTickCount64() };
	while (GetTickCount64() < StartTime + 5'000)
	{
		SetConsoleCursorPosition(hConsoleOutput, COORD{ 0, 0 });
		printf("[g_a : % d]  [g_b : % d]", g_a, g_b);
	}
}
```



### Most common issues

#### critical section

다수의 스레드가 접근하는 공유된 메모리(여기선 전역변수)를 임계 구역(critical section)이라고 한다.



#### race condition

다수의 스레드가 공유된 메모리에 접근하여 문제가 발생하는 경우를 경쟁 상태(race condition)이라고 한다.

공유된 메모리에서 read만 할 경우 전혀 문제가 되지 않지만, 단 한 번이라도 write를 할 경우 문제가 발생할 수 있다!!

##### Data race

Data race == 한 스레드가 특정 메모리 위치에 write하는 동안 다른 스레드가 동일한 메모리 위치에 접근하는 경우!

##### API race

동시에 일어나면 안 되는 일이 일어남..?

예) A.foo()와 A.bar() 는?

A.foo(C)와 B.bar(C) 는?





#### race condition 예시

```cpp
#include <thread>
#include <iostream>

int g_value{}; // critical section

void add();
void subtract();

int main()
{
	std::thread th_a{ add };
	std::thread th_b{ subtract };
	th_a.join();
	th_b.join();
	printf("%d", g_value);
	return 0;
}

void add()
{
	for (int i = 0; i < 1'000'000; ++i)
	{
		++g_value;
	}
}

void subtract()
{
	for (int i = 0; i < 1'000'000; ++i)
	{
		--g_value;
	}
}
```



#### deadlock

두 쓰레드가 서로가 점유하고 있는 자원을 획득하길 기다리면 둘 다 계속 실패할 수 밖에 없다. 즉, 무한히 대기 상태에 빠지게 된다!



## thread synchronization 쓰레드 동기화

### 서론

동기화를 안 할 수있다면 안 하는 방법을 고려하자!!

지역변수만 잘 써도 해결되는 경우도 있다!

보통 하드웨어 자체에 atomic 연산이 있다



### cache coherency 캐시 일관성

코어가 여러개면 서로 다른 L1, L2 캐시를 가지므로 같은 변수에 대해 다른 값을 보고있을 수 있다!!!



### mutex

상호 배제(**mut**ual **ex**clusion)

서로 배제할 쓰레드들은 동일한 mutex를 공유해야 한다!!



#### mutex 예시

```cpp
#include <thread>
#include <iostream>
#include <mutex>

std::mutex g_mutex{};
int g_value{};

void add();
void subtract();

int main()
{
	std::thread th_a{ add };
	std::thread th_b{ subtract };
	th_a.join();
	th_b.join();
	printf("%d", g_value);
	return 0;
}

void add()
{
	for (int i = 0; i < 1'000'000; ++i)
	{
		g_mutex.lock();
		++g_value;
		g_mutex.unlock();
	}
}

void subtract()
{
	for (int i = 0; i < 1'000'000; ++i)
	{
		g_mutex.lock();
		--g_value;
		g_mutex.unlock();
	}
}
```



### lock

생성자에서 할당할 것??

#### std::lock_guard

```cpp
std::lock_guard<std::mutex>
```



### atomic

원자적. 말 그대로 더 이상 쪼갤 수 없는 하나의 행동을 뜻함.

atomic으로 선언된 변수의 연산은 실제 1번만에 이루어지는 것으로 여길 수 있다!

여기서 연산은 atomic read와 atomic write를 말함!



#### lock-free

즉, atomic 변수와 atomic 연산을 이용하면 lock 없이 race condition을 방지할 수 있다!



#### atomic 연산

```cpp
std::atomic<int> x{ 1 };
x *= 2; // (NOT ATOMIC)
x = x + 1; // (atomic read & atomic write)
x = x * 2; // (atomic read & atomic write)
```



#### atomic 예시

```cpp
#include <thread>
#include <iostream>
#include <atomic>

std::atomic<int> g_value{};

void add();
void subtract();

int main()
{
	std::thread th_a{ add };
	std::thread th_b{ subtract };
	th_a.join();
	th_b.join();
	printf("%d", g_value.load());
	return 0;
}

void add()
{
	for (int i = 0; i < 1000000; ++i)
	{
		++g_value;
	}
}

void subtract()
{
	for (int i = 0; i < 1000000; ++i)
	{
		--g_value;
	}
}
```



### condition_variable

windows에서는 Event라는 이름으로 존재?

mutex랑 같이 쓴다. (atomic이 있더라도!)

wait(), wait_for(), wait_until()

notify_one(), notify_all() 는 mutex lock의 바깥에서 하자



=> 스레드 두 개 번갈아가며 홀수/짝수 출력하기 동기화!!



### semaphore



## thread_local

예전엔

```cpp
__declspec(thread) int g_i = 11;
```

처럼 사용했다.

지금은

```cpp
thread_local int g_i = 11;
```

처럼 사용한다.

모든 thread에 공통으로 생성될 지역변수!



## thread pool (thread + template)

여러 개의 쓰레드...

condition_variable 생성자에서 쓰레드 시작시켜놓고 일이 생길 때까지 wait() => 일이 끝나도 다시 wait()

소멸자에서 모든 쓰레드 join()

임의의 함수를 받는 법? 가변인자 템플릿!! <typename F, typename... Args> 식으로

리턴값은 future를 통해!

```
template<class F, class... Args>
future<typename result_of<F(Args...)> addJob(F f, Args... args)
```

