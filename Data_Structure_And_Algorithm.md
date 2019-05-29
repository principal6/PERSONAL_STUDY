# 자료구조와 알고리즘 Structure and algorithm (C++)

## I. 기초 자료구조

### 지역성 (locality => cache locality)

### 1. 배열 - 직접 접근



엔트리(entry)

spatial locality(공간 지역성) 보장

메모리 인접성 보장 (contiguous memory block)

#### 1) 정적 배열 (static array)

```cpp
// 컴파일 시간(Compile-time)에 배열의 크기가 결정되어야 한다.
// 정적 배열은 범위(scope)를 벗어나면 수명(lifetime)이 다해
// 언어 차원에서 자동으로 메모리가 해제된다.
int static_array_int[20]{};
static_array_int[0] = 3;
static_array_int[1] = 1;
static_array_int[2] = 4;
```



#### 2) 동적 배열 (dynamic array)

```cpp
// 실행 시간(Runtime)에 메모리 할당(new ~[])이 가능하다.
// 동적 배열은 범위(scope)를 벗어나도 수명(lifetime)이 끝나지 않는다.
// 따라서 사용이 끝난 동적 배열은 반드시 메모리 해제(delete[])를 해주어야 한다.
int* dynamic_array_int = new int[20]{};

dynamic_array_int[0] = 3;
dynamic_array_int[1] = 1;
dynamic_array_int[2] = 4;

// new ~[] 명령어로 할당한 동적 배열은 반드시 delete[]로 해제해 주어야 한다.
// 그렇지 않으면 메모리 누수(memory leak)가 발생한다.
delete[] dynamic_array_int;
```



### 2. 연결 리스트 - 순서 접근

포인터를 활용.

노드(node)

non-contiguous memory blocks

#### 1) 단순 연결 리스트 (singly linked list)

#### 2) 이중 연결 리스트 (double linked list)

#### 3) 원형 연결 리스트 (circular linked list)



### [*] STL 자료구조

```cpp
#include <vector>
#include <string>

#include <stack> // => deque으로 구현
#include <queue> // => deque으로 구현
#include <deque>
#include <list> // => deque으로 구현

#include <map>
#include <set>
```



## II. 추상자료형(ADT, Abstract Data Type)

### 1. 선형 - 스택 (Stack)

용도: 파싱(괄호 검사), 되돌리기(Undo & Redo - Ctrl+Z)

용어: top(peek), overflow, underflow

size(), capacity(), display() & push(), pop(), **top()**, **empty()==is_empty()**

top() -> 참조형!(non-const, const)★★



### 2. 선형 - 큐 (Queue)

용도: 이벤트 처리(버퍼 활용)

용어: (전단)front, (후단, rear)back

size(), capacity(), display() & push(), pop(), **front()**, **back()**, empty()

#### 1) 선형 큐

#### 2) 원형 큐

#### 3) 우선순위 큐 - 힙에서 다시 배우자



### 3. 선형 - 덱 (Deque)

deque = **d**ouble-**e**nded-**que**ue

size(), capacity(), display() & push_front(), pop_front(), push_back(), pop_back(), **clear()**, front(), back(), empty()



### 4. 선형 - 리스트



### 5. 비선형 - 트리

뿌리(Root)

부모(Parent)

자식(Child)

잎(Leaf) = 자식이 없는 노드

크기(Size) = 총 노드의 개수

깊이(Depth) = 총 계층의 개수 - 1

#### 1) 이진 트리 (Binary tree)

#### 2) 이진 탐색 트리 (BST, Binary search tree)

단어장, 사전

#### 3) 힙 (Heap) - 완전 이진 트리

##### * 우선순위 큐

#### 4) AVL 트리 (AVL tree) 

#### 5) B트리 (B-Tree)

#### 6) R-B트리 (Red-black tree)



### 6. 비선형 - 그래프

#### 1) 그래프

#### 2) 가중치 그래프

## III. Standard Template Library (STL)

### std::vector

**sequence container (선형 순서로 정렬되어 있다. 각각 위치를 통해 원소에 접근한다.)**

dynamic array 동적 배열로 구현됨.

탐색 속도: $O(1)$

삽입/삭제 속도: $O(N)$ (단, 마지막 원소의 경우 $O(1)$)

### std::deque

sequence container

### std::stack

container adaptor (deque -> stack, LIFO)

### std::queue

container adaptor (deque -> queue, FIFO)

### std::list

sequence container

doubly-linked-list 이중 연결 리스트로 구현됨.

탐색 속도: $O(N)$

삽입/삭제 속도: $O(1)$

### std::map

**associative container (컨테이너 상의 위치 말고 key를 통해 원소에 접근하는 컨테이너!)**

key와 value 쌍(std::pair)이 하나의 원소를 이룬다

(단, key값은 중복될 수 없다)

각 원소는 항상 key값을 기준으로 정렬된다.

red-black tree를 이용해 구현됨?

탐색 속도: $O(logN)$

삽입/삭제 속도: $O(logN)$

### free functions

#### std::find

```cpp
auto iter = std::find(c.begin(), c.end(), 16);
if (iter != c.end())
{
	//~
}
```

std::swap

std::erase

std::erase_if

## IV. 알고리즘

### * 복잡도

### 표기법

Big-O notation: 최악의 경우 복잡도 $\mathcal{O}(n)$

Big-Theta notation: 평균적 복잡도 $\Theta(n)$

Big-Omega notation: 최적의 경우 복잡도 $\Omega(n)$



### 마스터 정리 (Master theorum)

$T(n)=aT \left( \dfrac{n}{b} \right) + f(n)$ (단, $a\ge1, b>1$) 라는 관계식이 주어졌을 때 총 세 가지 경우가 있다.

경우 1) $f(n)=\mathcal{O}(n^c)$이고  $c < \log_ba$일 때 (즉  $f(n)=\mathcal{O}(n^{\log{_ba}-\epsilon})$ (단, $\epsilon>0$) 일 때)

$T(n)=\Theta(n^{\log{_ba}})$



경우 2) $f(n)=\Theta(n^{\log{_ba}})$일 때, (즉 $f(n)=\Theta(n^{\log{_ba}}\log{^kn})$ (단, $k\ge0$) 일 때)

$T(n)=\Theta(n^{\log{_ba}}\log{^{k+1}n})$



경우 3) $f(n)=\Omega(n^c)$이고  $c > \log{_ba}$ 이고, (즉 $f(n)=\Omega(n^{\log{_ba}+\epsilon})$ (단, $\epsilon>0$) 이고)

$af \left( \dfrac{n}{b} \right) \le kf(n)$ (단, $k < 1$이고 $n$이 충분히 클 때) 이면

$T(n)=\Theta(f(n))$

예시 1) $T(n)=8T\left(\dfrac{n}{2}\right)+1000n^2$

예시 2) $T(n)=2T\left(\dfrac{n}{2}\right)+10n$

예시 3) $T(n)=2T\left(\dfrac{n}{2}\right)+n^2$



### 1. 정렬

#### 1) 퀵 정렬 (Quick sort) ★

분할정복법(Divide-And-Conquer)

시간 복잡도: $\Theta(n\log{n})$ ~ $\mathcal{O}(n^2)$★



#### 2) 합병 정렬 (Merge sort) ★

분할정복법(Divide-And-Conquer), stable sort -> Master theorum 참고



#### 3) 힙 정렬 (Heap sort)

#### 4) 셸 정렬 (Shell sort)

#### 5) 삽입 정렬 (Insertion sort)

#### 6) 선택 정렬 (Selection sort)

#### 7) 버블 정렬 (Bubble sort)

#### * 기수 정렬 (Radix sort)



### 2. 탐색

#### 1) 순차 탐색 (Linear search = Sequential serach)

시간 복잡도: $\mathcal{O}(n)$



#### 2) 이진 탐색 (Binary search)

반드시 정렬된 데이터에 한해 실행할 수 있는 알고리즘이다.

시간 복잡도: $\mathcal{O}(\log{n})$



#### 3) 색인 순차 탐색 (Indexed sequential search)

시간 복잡도: $\mathcal{O}(\log{n})$



#### 4) 보간 탐색 (Interpolation search)

시간 복잡도: $\Theta(\log{(\log{n})})$ ~ $\mathcal{O}(n)$



#### 5) 깊이 우선 탐색 (DFS, Depth First Search)

#### 6) 너비 우선 탐색 (BFS, Breadth First Search)



### 3. 재귀 (Recursion)

### 4. 해시 (Hash) - 해시 테이블

해시 테이블 (테이블 크기는 소수로, 인덱스가 모듈로 연산이니까!!)

해시 맵

사전! 만들어봐 (dictionary)



### * 사례

#### 최댓값, 최솟값 찾기

#### 미로 탐색

