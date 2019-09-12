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

#### 1) 퀵 정렬 (Quick sort) ★

분할정복법(Divide-And-Conquer)

시간 복잡도: $\Theta(n\log{n})$ ~ $\mathcal{O}(n^2)$★



#### 2) 합병 정렬 (Merge sort) ★

분할정복법(Divide-And-Conquer), stable sort -> Master theorum 참고

합병 시 두 개의 목록의 원소에서 조건에 맞게 합병된 공간으로 옮긴다!



#### 3) 힙 정렬 (Heap sort)

#### 4) 셸 정렬 (Shell sort)

#### 5) 삽입 정렬 (Insertion sort) ★

왼쪽이 정렬된 부분, 정렬 안 된 맨 처음 항목을 앞의 정렬된 항목과 비교해서 교환(swap)★

#### 6) 선택 정렬 (Selection sort)

#### 7) 버블 정렬 (Bubble sort)

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

IEEE-754

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



## VII. 알고리즘 실전 연습 (프로그래머스)

### ★★★정렬만 잘 해도 많은 문제가 간단해진다!!!★★★

### 가능한 모든 조합 만들기...?

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
