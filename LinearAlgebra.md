# Linear Algebra 선형대수학

## Terminology 용어

coefficient 계수

term 항

system of ~ ~계 = 연립 ~

diagonal entry 대각성분

identity matrix 항등행렬

zero matrix 영행렬





## System of linear equations 선형방정식계, 선형계

### Linear equation 선형방정식

$$
a_1x_1 + a_2x_2 + \cdots + a_nx_n =b
$$



### System of linear euqations 선형방정식계

#### 정의

하나 이상의 선형방정식의 모임

#### Solution 해

변수 $x_1, x_2, \cdots, x_n$ 에 대입했을 때 모든 식이 참이 되도록 하는 숫자들 $s_1, s_2, \cdots, s_n$ 의 목록

#### Solution set 해집합

해들을 모아놓은 집합

동일한 해집합을 갖는다 = 동치이다(**equivalent**)

#### 특징

선형방정식은

1. 해를 갖지 않는다. (두 직선이 교차하지 않음)			=> consistent
2. 단 하나의 해를 갖는다. (두 직선이 한 점에서 만남)  => consistent
3. 무수히 많은 해를 갖는다. (두 직선이 평행함)			=> **inconsistent**



### 행렬표기법

$$
3x_1 +x_2 =4 \\
x_1 + 5x_2 = 9
$$



#### coefficient matrix 계수행렬

$$
\begin{vmatrix}
3 \ 1 \\
1 \ 5
\end{vmatrix}
$$



#### augmented matrix 첨가행렬

$$
\begin{vmatrix}
3 \ 1 \ 4\\
1 \ 5 \ 9
\end{vmatrix}
$$





### 선형방정식계 풀이

#### 핵심 알고리즘: 풀기 쉬운 동치의 선형계로 바꾼다

#### 행 연산: 가역적이다!!!

#### 행 동치 row equivalent - 행 연산을 통해 같아질 수 있는 두 행렬







## 행 축약, 사다리꼴

### leading entry 선행 성분: 가장 왼쪽의 0이 아닌 성분

#### pivot position 추축 위치

#### pivoc column 추축열



### echelon form 사다리꼴

#### reduced echelon form 기약사다리꼴

$$
\begin{vmatrix}
1 \ 0 \ 0 \ 2\\
0 \ 1 \ 0 \ 3\\
0 \ 0 \ 1 \ 4
\end{vmatrix}
$$



#### reduced row echelon form (RREF) 기약행사다리꼴



### 선형계의 해

$$
\begin{vmatrix}
1 \ 0 \ 0 \ 2 \ 3 \ 4 \\
0 \ 1 \ 0 \ 5 \ 6 \ 7 \\
0 \ 0 \ 0 \ 8 \ 9 \ 0 \\
0 \ 0 \ 0 \ 0 \ 1 \ 2 \\
\end{vmatrix}
$$



#### 기본 변수 basic variable

#### 자유 변수 free variable

#### 해의 존재성

#### 해의 유일성







## Vector equation 벡터방정식



### linear combination 선형결합

#### 가중치 weight

#### span ★ 생성

Span { v } : v 의 모든 스칼라배의 집합 => 원점을 지나는 직선

Span { u, v } => 원점을 지나는 평면







## Matrix equation 행렬방정식

벡터의 선형결합 => **행렬과 벡터의 곱** ( **b 가 A 의 열의 선형결합!**!! )
$$
\bold{a_1}x_1 + \bold{a_2}x_2 + \cdots + \bold{a_n}x_n = \bold{b}
\\ \\
A\bold{x}=\bold{b}
$$

### 해집합

#### 동차선형계

$$
A\bold{x}=\bold{0}
$$







