# 자료구조와 알고리즘 Structure and algorithm (C++)

## I. 기초 자료구조

### 지역성 (locality => cache locality)

### 1. 배열 - 직접 접근



엔트리(entry)

spatial locality(공간 지역성) 보장



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

**노드(Node)**

근노드(Root)

부모 노드(Parent)

자식 노드(Child) => 자식의 수 == **차수(Degree)**

단말 노드(Leaf) = 자식이 없는 말단 노드

크기(Size) = 총 노드의 개수

**레벨(Level)** - **근노드에서 특정 노드까지 경로의 길이**

깊이(Depth) = 트리의 최대 레벨

#### Traverse방식

#### 1) 이진 트리 (Binary tree)

- 완전 이진 트리??

#### 2) 이진 탐색 트리 (BST, Binary search tree) ★

- **균형★**이 안 맞으면 탐색/삽입/삭제 시간이 O(n)이 된다...

단어장, 사전

#### 3) 힙 (Heap) - 완전 이진 트리

##### * 우선순위 큐

#### 4) AVL 트리 (AVL tree) 

#### 5) B트리 (B-Tree) ★★

[그림: 5차 B-Tree]



![5차](Asset\Order5BTree.png)



- 데이터베이스, 파일 시스템에 주로 사용됨

##### 정의

- 노드에 들어가는 값: **key (키)**
- 자식 개수 최대치: **order (차수)** ★ (key 개수는 order - 1)
  - key가 최대 4개면 Order-5 B-Tree (5차 B-Tree)
  - (non-leaf 노드의) 자식 노드가 k 개면 키는 k-1개다
- ★ 루트 노드는 (leaf 노드가 아닌 경우) 최소 두 개의 child 노드가 있어야 한다
- ★ (루트 제외) non-leaf 노드는 최소 Order / 2개의 키를 가진다.
- **★★ 모든 leaf는 같은 level에 존재해야 한다.**

##### 삽입

- 항상 leaf 노드에 삽입
- 하향 탐색하여 위치 찾음? 해당 leaf 노드에 공간 없으면 분할! (분할하려면 키 하나를 부모 노드로 올린다!! 부모 노드가 꽉 찼으면? 부모노드도 분할!)

#### 6) R-B트리 (Red-black tree) ★★

- 모든 노드는 R/B
- **★ root와 leaf는 항상 B** (**B로 시작해서 B로 끝난다**)
- **★ 노드가 R이면 자식은 무조건 B** (즉, R와 B는 계층 상 **번갈아** 나타난다!!)
- **★★ root에서 leaf까지 모든 경로에서 ★B의 갯수★는 같아야 한다** (가장 짧으면 B만 나오는 경로, 가장 길면 B-R-B-R-B처럼 번갈아 나오는 경우)



### 6. 비선형 - 그래프

구현은 인접 행렬(adjacent matrix)로

#### 1) 그래프

#### 2) 가중치 그래프



## III. 알고리즘 기초

### 시간 복잡도, 공간 복잡도

### 표기법

Big-O notation: 최악의 경우 복잡도 $\mathcal{O}(n)$

Big-Theta notation: 평균적 복잡도 $\Theta(n)$

Big-Omega notation: 최적의 경우 복잡도 $\Omega(n)$



### 마스터 정리 (Master theorum) -> 재귀 시간 복잡도 계산

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

```cpp
std::vector<int> v{ 5, 3, 8, 4, 9, 1, 6, 2, 7 };
std::vector<int> v{ 3, 5, 4, 2, 1 };
```

#### 1) 퀵 정렬 (Quick sort) ★

분할정복법(Divide-And-Conquer)

시간 복잡도: $\Theta(n\log{n})$ ~ $\mathcal{O}(n^2)$★

##### begin, end, left, right, pivot

##### pivot의 왼쪽은 작고, pivot의 오른쪽은 커야 한다 (오름차순)★

##### pivot은 항상 0번 항목으로 둔다고 생각하자 (pivot을 제외하고 두 배열로 나뉘는 것과 같다!)

```cpp
#include <vector>
void quick_sort(std::vector<int>& v, const int begin, const int end)
{
	if (begin >= end) return;
	int pivot{ begin }, left{ begin + 1 }, right{ end };
	while (left < right)
	{
		if (v[left] > v[pivot] && v[right] < v[pivot]) std::swap(v[left], v[right]);
		if (v[left] <= v[pivot]) ++left;
		if (v[right] >= v[pivot]) --right;
	}
	if (v[right] < v[pivot]) std::swap(v[right], v[pivot]);	// @주의: 조건문 필수
	quick_sort(v, begin, right - 1);						// @주의: right - 1
	quick_sort(v, right, end);
}
```

```cpp
//[EXMAPLE #0]     [EXAMPLE #1]
// =========        =========
// 7 3 1 5 9        9 5 1 3 7
// p l     r        p l     r
// 7 3 1 5 9        9 5 1 3 7
// p   l r          p   l   r
// 7 3 1 5 9        9 5 1 3 7
// p     r          p     l r
//       l          9 5 1 3 7
// =========        p       r
// 5 3 1 7 9                l
//       p          =========
// ===== ===        7 5 1 3 9
// 5 3 1 7 9                p
// p l r            ======= =
// 5 3 1            7 5 1 3
// p   r            p l   r
//     l            7 3 1 5
// =====            p l   r
// 1 3 5            7 3 1 5
//     p            p   l r
// === =            7 3 1 5
// 1 3 5            p     r
//                        l
//                  =======
//                  5 3 1 7
//                        p
//                  ===== =
//                  5 3 1
//                  p l r
//                  5 1 3
//                  p l r
//                  5 1 3
//                  p   r
//                      l
//                  =====
//                  3 1 5
//                      p
//                  === =
//                  3 1
//                  ===
//                  1 3
```



#### 2) 병합 정렬 (Merge sort) ★

분할정복법(Divide-And-Conquer), stable sort -> Master theorum 참고

합병 시 두 개의 목록의 원소에서 조건에 맞게 합병된 공간으로 옮긴다!

```cpp
#include <vector>
void _merge(std::vector<int>& v, const size_t lbegin, const size_t rbegin, const size_t rend)
{
	const size_t lend{ rbegin - 1 };
	std::vector<int> sorted{};
	size_t lat{ lbegin };
	size_t rat{ rbegin };
	while (lat <= lend && rat <= rend)							// @주의: 삽입 방식
	{
		bool is_left_smaller{ v[lat] < v[rat] };				// @주의: 인덱싱
		sorted.emplace_back(is_left_smaller ? v[lat] : v[rat]);
		is_left_smaller ? ++lat : ++rat;
	}
	while (lat <= lend)
	{
		sorted.emplace_back(v[lat]);
		++lat;
	}
	while (rat <= rend)
	{
		sorted.emplace_back(v[rat]);
		++rat;
	}
	for (size_t i = 0; i < sorted.size(); ++i)
	{
		v[lbegin + i] = sorted[i];
	}
}

void merge_sort(std::vector<int>& v, size_t begin, size_t end)
{
	if (begin >= end) return;

	size_t mid{ begin + (end - begin) / 2 };	// @주의: begin 더하는 것 까먹지 말기!
	merge_sort(v, begin, mid);
	merge_sort(v, mid + 1, end);

	_merge(v, begin, mid + 1, end);
}
```

#### 3) 힙 정렬 (Heap sort)

#### 4) 셸 정렬 (Shell sort)

#### 5) 삽입 정렬 (Insertion sort) ★

##### 왼쪽이 정렬된 부분, 정렬 안 된 ★맨 앞 항목부터★ (정렬된) 바로 앞의 항목과 비교해서 계속 교환(swap)★

```cpp
#include <vector>
void insertion_sort(std::vector<int>& v)
{
	for (int unsorted = 1; unsorted < (int)v.size(); ++unsorted)
	{
		for (int at = unsorted; at > 0; --at)
		{
			if (v[at] < v[at - 1])
			{
				std::swap(v[at], v[at - 1]);
			}
			else
			{
				break;
			}
		}
	}
}
```

#### 6) 선택 정렬 (Selection sort)

왼쪽: 정렬된 항목들 / 오른쪽: 미정렬 항목들

선형 탐색해서 **최소값★ 찾아서** 미정렬 맨 앞 항목과 교환! (**동적 프로그래밍★**)

```cpp
#include <vector>
void selection_sort(std::vector<int>& v)
{
	for (size_t sorted_end = 0; sorted_end < v.size(); ++sorted_end)
	{
		int min{ (int)0x7FFFFFFF };
		size_t min_at{};
		for (size_t i = sorted_end; i < v.size(); ++i)
		{
			if (v[i] < min)
			{
				min_at = i;
				min = v[i];
			}
		}
		std::swap(v[sorted_end], v[min_at]);
	}
}
```



#### 7) 버블 정렬 (Bubble sort)

첫 항목부터 그 다음 항목과 비교 시작.

1라운드 끝나면 맨 마지막은 가장 큰 항목. (즉, 오른쪽이 곧 정렬된 목록)

인접한 두 개를 비교해서 교환(swap)

#### * 기수 정렬 (Radix sort)



### 2. 탐색

#### 1) 순차 탐색 (Linear search = Sequential serach)

시간 복잡도: $\mathcal{O}(n)$



#### 2) 이진 탐색 (Binary search) ★★★

반드시 정렬된 데이터에 한해 실행할 수 있는 알고리즘이다.

절반을 잘라서 확인 -> 반복 ★

시간 복잡도: $\mathcal{O}(\log{n})$



#### 3) 색인 순차 탐색 (Indexed sequential search)

시간 복잡도: $\mathcal{O}(\log{n})$



#### 4) 보간 탐색 (Interpolation search)

시간 복잡도: $\Theta(\log{(\log{n})})$ ~ $\mathcal{O}(n)$



#### 5) 깊이 우선 탐색 (DFS, Depth First Search)

#### 6) 너비 우선 탐색 (BFS, Breadth First Search)



### 3. 재귀 (Recursion)

★★ 하노이의 탑 ★★

```cpp
void Move(int From, in To)
{
    std::cout << "Move from " << From << " to " << To << '\n';
}

void Hanoi(int N, int From, int By, int To)
{
	if (n == 1)
	{
		Move(From, To);
	}
	else
	{
		Hanoi(N - 1, From, To, By);
		Move(From, To);
		Hanoi(N - 1, By, From, To);
	}
}
```



### 4. 해시 (Hash) - 해시 테이블

해시 테이블 (테이블 크기는 소수로, 인덱스가 모듈로 연산이니까!!)

해시 맵

사전! 만들어봐 (dictionary)



### * 사례

#### 최댓값, 최솟값 찾기

#### 미로 탐색



## IV. STL (Standard Template Library)

### vector<>

- sequence container (선형 순서로 정렬되어 있다. 각각 위치를 통해 원소에 접근한다.)
- 탐색 속도: $O(1)$
- 삽입/삭제 속도: $O(N)$ (단, 마지막 원소의 경우 $O(1)$)

#### operator [] , at()

#### front(), back()

#### operator =, assign()

#### begin(), end()

#### push_back(), emplace_back() <> pop_back()

#### reserve()

#### resize()

#### capacity(), size(), empty()

#### shrink_to_fit()

#### swap()

### string

#### operator =, assign(), copy()

#### operator +

#### operator +=, append()

```cpp
string a{}, b{};
a += 'a'; // 가능 ★
a += "bc";
a += b;
a.append('a'); // 불가능 ★
a.append("bc"); // 가능
a.append(b); // 가능
```

#### operator [], at()

#### operator ==, operator !=, compare()

#### c_str()

#### find(), rfind(), string::npos ★

#### replace()

#### substr() ★

#### std::to_string() ★

#### std::stoi(), std::stof(), ... ★

### list<>

#### list -> 스택이나 큐 구현 (stack이나 queue 컨테이너는 iterator가 없어서 불편할 수 있다!)

- sequence container
- doubly-linked-list 이중 연결 리스트로 구현됨.
- 탐색 속도: $O(N)$
- 삽입/삭제 속도: $O(1)$

#### insert() <> erase(), remove(), remove_if()

#### push_back(), push_front(), emplace_back(), emplace_front() <> pop_back(), pop_front()

#### merge()

##### (정렬된 두 리스트에서) 다른 리스트의 모든 요소를 이 리스트로 정렬된 상태로 가져온다.

#### sort()

#### splice()

##### (정렬되지 않은 두 리스트에서) 다른 리스트에서 이 리스트로 일부분을 빼서 넣는다.

#### unique()

##### 동일한 값을 지니는 노드 중 하나만 남기고 나머지를 다 지운다.

### deque<>

#### operator [], at()

#### ★ deque (iterator가 있고, random access도 가능..!!★ stack이나 queue보다 훨씬 편의성이 높다!)

### queue<> -> heap ★

```cpp
#include <queue>

void foo()
{
    // 기본 힙은 ★최대 힙★이므로 pop_heap()을 하면 최대값이 벡터의 맨 끝으로 온다.
    // 최소 힙을 만드려면? greater<> 를 써야한다! ★★
    make_heap(scoville.begin(), scoville.end(), greater<int>());
    
    pop_heap(scoville.begin(), scoville.end(), greater<int>());
    int z{ scoville.back() };
    scoville.pop_back();
    
    pop_heap(scoville.begin(), scoville.end(), greater<int>());
    int y{ scoville.back() };
    scoville.pop_back();

    scoville.push_back(z + y * 2);
    push_heap(scoville.begin(), scoville.end(), greater<int>());
}
```



### hash<>

```cpp
#include <functional>

void foo()
{
    size_t a{ hash<string>{}("abcd") };
	size_t b{ hash<string>{}("abcd") };
}
```

### unordered_map<>

- **associative container (컨테이너 상의 위치 말고 key를 통해 원소에 접근하는 컨테이너!)**
- key와 value 쌍(std::pair)이 하나의 원소를 이룬다 (단, key값은 중복될 수 없다)
- VS에서는 red-black tree를 이용해 구현됨?
- 탐색 속도: $O(logN)$
- 삽입/삭제 속도: $O(logN)$

#### 배열처럼 저장해야 하나 인덱스가 순서대로 주어지지 않는다! (특히, 문자열로 검색해야 한다!)

```cpp
#include <unordered_map> // ★★ <map>이 아님에 주의하자

unordered_map<string, int> map{};
map.insert(make_pair(a, b));
map.erase(a);

auto found{ map.find(a) };
if (found != map.end())
{
    auto value{ found.second };
}
```

```cpp
unordered_map<string, int> map{};
cout << map["abc"]; // 0이 출력된다.
map["abc"] = 10; // ★★ (해당 키가 아직 없으면 알아서 추가된다... 대박;) ★★
cout << map["abc"]; // 10이 출력된다.

for (auto& row : clothes)
{
    ++map[row[1]]; // ★★ (해당 키가 아직 없으면 알아서 추가된다... 대박;) ★★
}
```



### sort()

#### ★주의★ pred 함수 내 비교는 '<' 나  ''>' 만 쓰자!  not (!) 을 했을 시 반드시 반대 결과가 나와야 하기 때문!!!★

#### ★sort의 기본 정렬은 ★오름차순★ (즉, 0번이 제일 작다!!!)★

```cpp
bool operator<(const SAny& a, const SAny& b)
{
	return (a.Value < b.Value);
}
```

```cpp
#include <vector>
#include <algorithm>

using namespace std;

struct SAny
{
	SAny() {}
	SAny(int _Index, int _Value) : Index{ _Index }, Value{ _Value } {}

	int Index{};
	int Value{};
};

bool operator<(const SAny& a, const SAny& b)
{
	return (a.Value < b.Value);
}

bool operator>(const SAny& a, const SAny& b)
{
	return (a.Value > b.Value);
}

int main()
{
	vector<SAny> v{ {0, 3}, {1, 1}, {2, 10}, {3, 0} };

	// 오름차순: operator<
	sort(v.begin(), v.end());

	// 내림차순: operator>
	sort(v.begin(), v.end(), greater<SAny>{});
	
	return 0;
}
```

```cpp
#include <string>
#include <algorithm>

using namespace std;

bool pred(char a, char b)
{
	char la{ (char)tolower(a) };
	char lb{ (char)tolower(b) };
	
	if (la == lb)
	{
		return a < b;
	}
	else
	{
		return la < lb;
	}
}

int main()
{
	string s{ "aAbcCB" };
	sort(s.begin(), s.end(), pred);
	
	return 0;
}
```



### max(a, b)

### min(a, b)

### max_element()

### min_element()

### lower_bound()

### upper_bound()

### lexicographical_compare()



## V. 알고리즘 심화

### 알고리즘의 정당성 증명

#### 수학적 귀납법 & 불변식 & 단정문

#### 귀류법★

 -> 최적의 결론이 나왔다고 가정하고, 그 반대 상황을 생각해 보기

#### 비둘기집의 원리★ (<= 머리카락 수)



## VI. 알고리즘 실전에서 주의할 사항

### 산술 오버플로우

```cpp
int a{ 100'000 * 480'000 / 5'000 }; // 오버플로우
int b{ 100'000 / 5'000 * 480'000 }; // 정상 작동 (계산 순서 변경 ★)
```

```cpp
long long combination_a(long long left, long long right)
{
	long long result{ 1 };

	if (left - right < right) right = left - right;

	for (long long i = 0; i < right; ++i)
	{
		result *= (left - i);
	}

	for (long long i = 0; i < right; ++i)
	{
		result /= (right - i);
	}

	return result;
}

// 점화식 (재귀) 활용
long long combination_b(long long left, long long right)
{
	if (left == right) return 1;
	if (right == 0) return 1;

	return combination(left - 1, right - 1) + combination(left - 1, right);
}
```

### 소수 정밀도 (float보다 double을 선호하고, double보다 int를 선호하자)

#### IEEE-754

```cpp
union U
{
    unsigned int i{};
    float f;
};

int main()
{
    U x;

    // [IEEE-754]
    //
    // case #0
    // ┌───────┐
    // │  dec  │
    // ├───────┤
    // │   0   │
    // └───────┘
    //  │      ┌───┬─────────┬─────────────────────────────┐
    //  │      │sgn│   exp   │           fraction          │
    //  └────→ ├───┼─────────┼─────────────────────────────┤
    //         │ 0 │0000 0000│0000 0000 0000 0000 0000 000 │
    //         └───┴─────────┴─────────────────────────────┘
    // case #1
    // ┌───────┬───┬───────┬───┬─────────────────────┬────────────────────────────────────┐
    // │  dec  │   │  bin  │   │     encoded bin     │                result              │
    // ├───────┼───┼───────┼───┼─────────────────────┼────────────────────────────────────┤
    // │  1.0  │ = │ 1.0   │ = │ (1 + 0.0) * 2^(0)   │ sgn[0] exp[127 + 0] fraction [0]   │
    // └───────┴───┴───────┴───┴─────────────────────┴────────────────────────────────────┘
    //  │      ┌───┬─────────┬─────────────────────────────┐
    //  │      │sgn│   exp   │           fraction          │
    //  └────→ ├───┼─────────┼─────────────────────────────┤
    //         │ 0 │0111 1111│0000 0000 0000 0000 0000 000 │
    //         └───┴─────────┴─────────────────────────────┘
    // case #2
    // ┌───────┬───┬───────┬───┬─────────────────────┬────────────────────────────────────┐
    // │  dec  │   │  bin  │   │     encoded bin     │                result              │
    // ├───────┼───┼───────┼───┼─────────────────────┼────────────────────────────────────┤
    // │  1.5  │ = │ 1.1   │ = │ (1 + 0.1) * 2^(0)   │ sgn[0] exp[127 + 0] fraction [1]   │
    // └───────┴───┴───────┴───┴─────────────────────┴────────────────────────────────────┘
    //  │      ┌───┬─────────┬─────────────────────────────┐
    //  │      │sgn│   exp   │           fraction          │
    //  └────→ ├───┼─────────┼─────────────────────────────┤
    //         │ 0 │0111 1111│1000 0000 0000 0000 0000 000 │
    //         └───┴─────────┴─────────────────────────────┘
    // case #3
    // ┌───────┬───┬───────┬───┬─────────────────────┬────────────────────────────────────┐
    // │  dec  │   │  bin  │   │     encoded bin     │                result              │
    // ├───────┼───┼───────┼───┼─────────────────────┼────────────────────────────────────┤
    // │  0.5  │ = │ 0.1   │ = │ (1 + 0.0) * 2^(-1)  │ sgn[0] exp[127 - 1] fraction [0]   │
    // └───────┴───┴───────┴───┴─────────────────────┴────────────────────────────────────┘
    //  │      ┌───┬─────────┬─────────────────────────────┐
    //  │      │sgn│   exp   │           fraction          │
    //  └────→ ├───┼─────────┼─────────────────────────────┤
    //         │ 0 │0111 1110│0000 0000 0000 0000 0000 000 │
    //         └───┴─────────┴─────────────────────────────┘                       
    // case #4
    // ┌───────┬───┬───────┬───┬─────────────────────┬────────────────────────────────────┐
    // │  dec  │   │  bin  │   │     encoded bin     │                result              │
    // ├───────┼───┼───────┼───┼─────────────────────┼────────────────────────────────────┤
    // │  2.75 │ = │ 10.11 │ = │ (1 + 0.011) * 2^(1) │ sgn[0] exp[127 + 1] fraction [011] │
    // └───────┴───┴───────┴───┴─────────────────────┴────────────────────────────────────┘
    //  │      ┌───┬─────────┬─────────────────────────────┐
    //  │      │sgn│   exp   │           fraction          │
    //  └────→ ├───┼─────────┼─────────────────────────────┤
    //         │ 0 │1000 0000│0110 0000 0000 0000 0000 000 │
    //         └───┴─────────┴─────────────────────────────┘
    // case #5
    // ┌───────┐
    // │  dec  │
    // ├───────┤
    // │ -2.75 │
    // └───────┘
    //  │      ┌───┬─────────┬─────────────────────────────┐
    //  │      │sgn│   exp   │           fraction          │
    //  └────→ ├───┼─────────┼─────────────────────────────┤
    //         │ 1 │1000 0000│0110 0000 0000 0000 0000 000 │
    //         └───┴─────────┴─────────────────────────────┘

    x.f = -2.75f;
    U* px{ &x };
    return 0;
}
```

유리수 클래스를 만드는 것도 한 방법

실수를 아예 안 쓸 수 있으면 안 쓰는 게 최고★

```cpp
// 틀린 예
if (a==b) ... 
    
// 옳은 예
if (fabs(a-b) < 1e-9) ...
```



### 변수 초기화

```cpp
vector<int> a{};
while (true)
{
	a.clear();    
};
```



### 근사 최대치 활용하기

```cpp
constexpr int KBigInt{ 987'654'321 };
//constexpr float KBigFloat{ 1e+30f };
constexpr double KBigDouble{ 1e+300 };
```





### 스트림 속도

```cpp
cin.sync_with_stdio(false);
```

### 스캐폴딩 (scaffolding) - 알고리즘 검증

### 유용한 매크로

```cpp
#define FOR(i, n) for (int i = 0; i < n; ++i)
```

### cin, cout VS. printf(), scanf()

```cpp
cout << fixed;
cout.precision(11);
```

```cpp
ios::sync_with_stdio(false);
```

### size() 캐스팅

```cpp
for (int i = 0; i < v.size() - 1; ++i) // 문제 발생 가능성!
for (int i = 0; i < (int)v.size() - 1; ++i) // 문제 해결!
```



## VII. 알고리즘 실전 연습

### ★★★정렬만 잘 해도 많은 문제가 간단해진다!!!★★★

### 무식하게 풀기 == 완전 탐색 (brute-force search, exhaustive search)

#### 다음 단계를 예측할 수 없어 모든 경우를 확인해보아야만 알 수 있는 경우 사용한다!★

#### 재귀 활용

##### 기저 사례(base case)★ -> return 을 잘 해야....

##### 문제(problem)와 부분문제(subproblem) -> 점화식!★★

##### 반복을 피하고 싶으면 Offset을 활용!!★

##### 예) 팩토리얼 계산

```cpp
// ★ 1! = 1, 0! = 1 ★
// 4! = 4 * 3 * 2 * 1 = 4 * 3! (문제와 부분문제)
// 3! = 3 * 2!
// 2! = 2 * 1!
int Factorial(int n)
{
	if (n <= 1) return 1;
	return n * Factorial(n - 1);
}
```

##### 예) 등차수열의 합

```cpp
// ★ S_1 = a ★
// S_3 = a + a + d + a + 2d = S_2 + a + 2d (문제와 부분문제)
// S_2 = a + a + d = S_1 + a + d
int SumOfArithmeticProgression(int a, int d, int n)
{
	if (n == 1) return a;
	return (a + (n - 1) * d) + SumOfArithmeticProgression(a, d, n - 1);
}
```

##### 예) 등비수열의 합

```cpp
double SumOfGeometricProgression(double a, double r, int n)
{
	if (n == 1) return a;
	return (a * pow(r, n - 1)) + SumOfGeometricProgression(a, r, n - 1);
}
```

##### 예) 조합 계산하기

```cpp
// ★ n_C_0 == n_C_n == 1 ★
// 4_C_3 = 3_C_2 + 3_C_3
// 3_C_3 = 1 && 3_C_2 = 2_C_1 + 2_C_2
// 2_C_2 = 1 && 2_C_1 = 1_C_0 + 1_C_1
// 1_C_0 = 1 && 1_C_1 = 1
long long GetCombination(long long left, long long right)
{
	if (left == right) return 1;
	if (right == 0) return 1;

	return GetCombination(left - 1, right - 1) + GetCombination(left - 1, right);
}
```

##### 예) 가능한 모든 조합(combination) ★ / 중복조합(multiset) 만들기

```cpp
#include <iostream>
#include <vector>

using namespace std;

void DisplayGroup(const vector<int>& List, const vector<int>& Indices)
{
	for (auto& i : Indices)
	{
		cout << '[' << List[i] << ']';
	}
	cout << '\n';
	return;
}

void GetMultiset(const vector<int>& List, vector<int>& UsedIndices, int CountToGo)
{
	if (CountToGo == 0)
	{
		DisplayGroup(List, UsedIndices);
		return;
	}

	int offset{ (UsedIndices.size()) ? UsedIndices.back() : 0 };
	for (int i = offset; i < (int)List.size(); ++i)
	{
		UsedIndices.emplace_back(i);
		GetMultiset(List, UsedIndices, CountToGo - 1);
		UsedIndices.pop_back();
	}
}

void GetCombination(const vector<int>& List, vector<int>& UsedIndices, int CountToGo)
{
	if (CountToGo == 0)
	{
		DisplayGroup(List, UsedIndices);
		return;
	}

	int offset{ (UsedIndices.size()) ? UsedIndices.back() + 1 : 0 };
	for (int i = offset; i < (int)List.size(); ++i)
	{
		UsedIndices.emplace_back(i);
		GetCombination(List, UsedIndices, CountToGo - 1);
		UsedIndices.pop_back();
	}
}

int main()
{
	vector<int> used_indices{};

	GetCombination({ 1, 3, 5, 7, 9 }, used_indices, 3);

	GetMultiset({ 1, 3, 5, 7, 9 }, used_indices, 3);

	return 0;
}
```

##### 예) 순열 (permutation)

```cpp
#include <iostream>
#include <vector>

using namespace std;

void DisplayPermutations(const vector<int>& List, int Count, int Depth, vector<vector<int>>& Prevs)
{
	for (auto& i : List)
	{
		if (Depth < Count - 1)
		{
			if (Depth == 0) Prevs.resize(Prevs.size() + 1);

			Prevs.back().emplace_back(i);
			DisplayPermutations(List, Depth + 1, Count, Prevs);
			Prevs.back().pop_back();
		}
		else
		{
			for (auto& j : Prevs.back())
			{
				cout << '[' << j << ']';
			}
			cout << '[' << i << "]\n";
		}
	}
}

int main()
{
	vector<int> l{ 1, 3, 5, 7, 9 };
	vector<vector<int>> prevs{};
	DisplayPermutations(l, 3, 0, prevs);

	return 0;
}
```



#### 동적 계획법 + 점화식 활용 ??







### PALINDROME ...?

```cpp
bool is_palindrome(const string& s)
{
	if (s.size() % 2 == 0) return false;

	for (size_t i = 0; i < s.size(); ++i)
	{
		if (s[i] != s[s.size() - 1 - i])
		{
			return false;
		}
	}

	return true;
}
```
