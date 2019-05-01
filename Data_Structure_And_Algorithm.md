# 자료구조와 알고리즘 Structure and algorithm

## I. 구현상 자료구조(C++)

### 1. 배열 - 직접 접근

### 2. 연결 리스트 - 순서 접근

포인터를 활용.

노드(node)

#### 1) 단순 연결 리스트 (singly linked list)

#### 2) 원형 연결 리스트 (circular linked list)

#### 3) 이중 연결 리스트 (double linked list)



STL 자료구조

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





## II. 이론상 자료구조

### 1. 선형 - 스택 (Stack)

용도: 파싱(괄호 검사), 되돌리기(Undo & Redo - Ctrl+Z)

용어: top, overflow, underflow

size(), capacity(), display() & empty(), push(), pop(), is_full(), is_empty(), top()



### 2. 선형 - 큐 (Queue)

용도: 이벤트 처리(버퍼 활용)

용어: (전단)front, (후단)rear

size(), capacity(), display() & empty(), push(), pop(), is_full(), is_empty(), back()

#### 1) 선형 큐

#### 2) 원형 큐

#### 3) 우선순위 큐 - 힙에서 다시 배우자



### 3. 선형 - 덱 (Deque)

deque = **d**ouble-**e**nded-**que**ue

size(), capacity(), display() & empty(), push_front(), pop_front(), push_back(), pop_back(), is_full(), is_empty(), front(), back()



### 4. 선형 - 리스트



### 5. 선형??? 해시

#### 1) 해시 테이블(Hash table)

### 6. 비선형 - 트리

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



### 7. 비선형 - 그래프

#### 1) 그래프

#### 2) 가중치 그래프



## II. 알고리즘

### 1. 정렬

#### 1) 퀵 정렬 (Quick sort)

#### 2) 합병 정렬 (Merge sort) - 분할정복법(Divide-And-Conquer), stable sort

#### 3) 힙 정렬 (Heap sort)

#### 4) 셸 정렬 (Shell sort)

#### 5) 삽입 정렬 (Insertion sort)

#### 6) 선택 정렬 (Selection sort)

#### 7) 버블 정렬 (Bubble sort)

#### * 기수 정렬 (Radix sort)



### 2. 탐색

#### 1) 순차 탐색

#### 2) 이진 탐색

#### 3) 색인 순차 탐색

#### 4) 보간 탐색

#### 5) 깊이 우선 탐색 (DFS, Depth First Search)

#### 6) 너비 우선 탐색 (BFS, Breadth First Search)



### 3. 순환 (Recursion)



### * 사례

#### 최댓값, 최솟값 찾기

#### 미로 탐색

