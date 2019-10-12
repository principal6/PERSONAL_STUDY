# C++ 멀티 스레딩

## thread

**C++ 03땐 없다가 C++11에 소개됨!**

### atomic

```cpp
#include <atomic>
std::atomic<int> x{ 3 };

void thread0()
{
	++x;
}

void thread1()
{
	++x;
}
```

 => atomic을 하면 cache나 main memory까지 내려가서 값을 바꿔야 함

### atomic 사용 시 주의!

```
std::atomic<int> x{ 1 };
x *= 2; // (NOT ATOMIC)
x = x + 1; // (atomic read & atomic write)
x = x * 2; // (atomic read & atomic write)
```

### atomic

```cpp
std::atomic<T> x{};
T y = x.load();
x.store(y);
x.exchange(y); // atomic swap!
```



전역 변수에 동시에 write()는 아주 위험!!!

여러 thead가 자기 지역 변수에 동시에 write() 하는 건 문제 없음!

## lock-free

lock()을 하지 않고 멀티 스레딩 하기!



## deadlock



## Data race

Data race == 한 스레드가 특정 메모리 위치에 write하는 동안 다른 스레드가 동일한 메모리 위치에 접근하는 경우!

## API race

동시에 일어나면 안 되는 일이 일어남..?

예) A.foo()와 A.bar() 는?

A.foo(C)와 B.bar(C) 는?



## mutex

오직 한 쓰레드만이 접근 가능?? (single exclusive ownership)

```
std::mutex
std::mutex::lock()
std::mutex::unlock()
std::scoped_lock()
std::lock_guard<std::mutex>
```

## semaphore ??





## mutable이면..?