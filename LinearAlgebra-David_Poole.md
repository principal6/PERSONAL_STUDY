# 선형대수학 Linear Algebra

## 01. 벡터 vector

TODO



## 02. 연립일차방정식 system of linear equations

TODO



## 03. 행렬 matrix

### 행렬의 연산

#### 행렬의 정의

행렬은 성분 entry 또는 원소 element 라고 하는 수들의 직사각형 형태의 배열이다.
$$
\begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \end{bmatrix}
$$


#### 행렬의 크기

$m$ 개의 행과 $n$ 개의 열을 갖는 행렬의 크기는 $m \times n$ 이라 하고, `m by n` 으로 읽는다.

$1 \times n$ 행렬은 **행행렬(row matrix)** 또는 **행벡터(row vector)** 라 하고

$m \times 1$ 행렬은 **열행렬(column matrix)** 또는 **열벡터(column vector)** 라 한다.

> 엄밀하게는 행(열)행렬과 행(열)벡터는 차이가 있다!!!

>  $m \times n$ 행렬과  $n \times m$ 행렬은 서로 크기가 다르다!!!



#### 행렬의 성분

행렬 A 의 i행과 j열의 성분은 $a_{ij}$ 로 나타낸다.

$a_{11}, a_{22}, a_{33}, \cdots$ 처럼 행과 열이 같은 번호의 성분을 **행렬의 대각성분(diagonal entry)** 이라고 한다.



#### 표기법

##### 성분 표기

$$
A = [a_{ij}]
$$



##### 열벡터 표기 (column vector)

행렬 $A$ 의 열벡터가 $\bold{a_1}, \bold{a_2}, \cdots, \bold{a_n}$ 이면
$$
A = \begin{bmatrix} \bold{a_1} & \bold{a_2} & \cdots & \bold{a_n} \end{bmatrix}
$$
으로 나타낸다.



##### 행벡터 표기 (row vector)

행렬 $A$ 의 행백터가 $A_1, A_2, \cdots, A_m$ 이면
$$
A = \begin{bmatrix} A_1 \\ A_2 \\ \vdots \\ A_m \end{bmatrix}
$$
으로 나타낸다.



#### 기본적인 행렬의 종류

행과 열의 수가 같으면 **정사각행렬(square matrix)**
$$
\begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}
$$
대각성분을 제외한 모든 성분이 0인 정사각행렬은 **대각행렬(diagonal matrix)**
$$
\begin{bmatrix} 3 & 0 & 0 \\ 0 & 9 & 0 \\ 0 & 0 & 6 \end{bmatrix}
$$
대각성분이 모두 같은 대각행렬은 **스칼라 행렬(scalar matrix)**
$$
\begin{bmatrix} 3 & 0 & 0 \\ 0 & 3 & 0 \\ 0 & 0 & 3 \end{bmatrix}
$$
대각성분이 모두 1인 스칼라 행렬은 **단위행렬(identity matrix)**
$$
\begin{bmatrix} 1 & 0 & 0 \\ 0 & 1 & 0 \\ 0 & 0 & 1 \end{bmatrix}
$$
모든 성분이 0인 행렬은 **영행렬(zero matrix)**
$$
\begin{bmatrix} 0 & 0 & 0 \\ 0 & 0 & 0 \end{bmatrix}
$$


#### 행렬의 같음

서로 크기가 같고 대응되는 성분이 모두 같은 두 행렬은 **같다(equal)**



#### 행렬의 덧셈과 스칼라배

$A=[a_{ij}]$ 와 $B=[b_{ij}]$ 가 모두 $m \times n$ 행렬이면 **두 행렬의 합** $A + B$ 는 대응되는 성분을 더하여 얻어진 $m \times n$ 행렬이다.
$$
A + B = [a_{ij} + b_{ij}]
$$


$A$ 가 $m \times n$ 행렬이고 $c$ 가 스칼라이면 **스칼라배** $cA$ 는 $A$ 의 각 성분에 $c$ 를 곱하여 얻어진 $m \times n$ 행렬이다.
$$
cA = c[a_{ij}] = [ca_{ij}]
$$


##### 행렬의 음(negative)

$$
(-1)A = -A
$$

$-A$ 를 행렬 $A$ 의 **음(negative)** 이라 한다.



##### 행렬의 차

$$
A-B = A+(-B)
$$

##### 영행렬의 성질

$$
A + O = A = O + A \\
A -A = O = -A + A
$$



#### 행렬의 곱셈

$A$ 가 $m \times n$ 행렬이고 $B$ 가 $n \times r$ 행렬이면 **곱(product)** $C=AB$ 는 $m \times r$ 이고
$$
c_{ij} = a_{i1}b_{1j} + a_{i2}b_{2j} + \cdots + a_{in}b_{nj}
$$

$$
c_{ij} = \sum_{k=1}^{n}{a_{ik}b_{kj}}
$$





