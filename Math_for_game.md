# 수학

## 1. 벡터

### 1). 벡터 표기법, 길이

#### (1). 벡터 표기법

벡터 $a$는 $\vec{a}$와 같이 표기하고,

벡터의 길이는 $\|\vec{a}\|$으로 표기한다.

벡터 $\vec{a}=(x,y)$의 길이는 $\|\vec{a}\|=\sqrt{x^2+y^2}$이다.

(삼차원 벡터 $\vec{b}=(x,y,z)$의 경우 그 길이는 $\|\vec{b}\|=\sqrt{x^2+y^2+z^2}$ 이다.)



#### (2). 벡터의 정규화

벡터의 길이가 $1$인 벡터를 단위 벡터(Unit vector)라 하며 $\hat{a}$와 같이 표기한다.

길이가 1이 아닌 벡터를 단위 벡터로 바꾸는 일을 정규화(Normalization)라고 한다.

벡터 $\vec{a}=(a_x,a_y,a_z)$를 정규화하면 $\hat{a}=\dfrac{\vec{a}}{\|\vec{a}\|}$

### 2). Dot product 스칼라 곱

#### (1). 내적 계산 #1 (원소의 곱)

벡터 $\bold{a}=(a_x,a_y,a_z)$ 이고

벡터 $\bold{b}=(b_x,\ b_y,\ b_z)$ 일 때

두 벡터의 스칼라 곱은 $\bold{a}\cdot\bold{b}$와 같이 나타내고 그 계산은 다음과 같다.
$$
\bold{a}\cdot\bold{b}=a_xb_x+a_yb_y+a_zb_z
$$
즉, 내적의 결과는 **벡터**가 아니라 **스칼라** 값이다!!



#### (2). 내적 계산 #2 (삼각함수)

$$
\bold{a}\cdot\bold{b}=\|\bold{a}\| \|\bold{b}\| \cos\theta
$$

두 벡터가 단위벡터 (**정규화된 벡터)**인 경우 내적은 곧 **두 벡터의 사이각**의 cos과 같다!

다시 한 번, 내적의 결과는 **벡터**가 아니라 **스칼라** 값이다!



#### (3). 내적 계산 #3 (결론)

$$
\bold{a}\cdot\bold{b}=a_xb_x+a_yb_y+a_zb_z=\|\bold{a}\| \|\bold{b}\| \cos\theta
$$



#### (4). 내적 계산 증명

* **피타고라스 정리**의 삼각함수 버전: $\sin^2\theta+\cos^2\theta=1$

  ![](Asset\trigonometry.png)

  $sin^2\theta=\dfrac{b^2}{c^2}$

  $cos^2\theta=\dfrac{a^2}{c^2}$

  $sin^2\theta+cos^2\theta=\dfrac{b^2}{c^2}+\dfrac{a^2}{c^2}=\dfrac{b^2+a^2}{c^2}$

  이때 피타고라스의 정리 $a^2+b^2=c^2$에 의해 $\dfrac{b^2+a^2}{c^2}=1$이다.

  $\therefore sin^2\theta+cos^2\theta=1$

* 내적 증명

![](Asset\vector_dot.png)

$\bold{a}=(a_x,a_y)$

$\bold{b}=(b_x,b_y)$

$\bold{c}=\bold{a}-\bold{b}=(a_x-b_x,a_y-b_y)$

i) 피타고라스의 정리에 의해 $\|\bold{c}\|^2=h^2+i^2$이다.

이때, $h=\|\bold{b}\|sin\theta$이고  $i=\|\bold{a}\|-\|\bold{b}\|cos\theta$이므로

$\|\bold{c}\|^2=(\|\bold{b}\|sin\theta)^2 + (\|\bold{a}\|-\|\bold{b}\|cos\theta)^2$ 이다.

$\|\bold{c}\|^2=\|\bold{b}\|^2sin^2\theta + \|\bold{a}\|^2-2\|\bold{a}\| \|\bold{b}\| cos\theta+\|\bold{b}\|^2cos^2\theta$

$\|\bold{c}\|^2=\|\bold{a}\|^2-2\|\bold{a}\| \|\bold{b}\| cos\theta+\|\bold{b}\|^2(cos^2\theta+sin^2\theta)$

이때, $cos^2\theta+sin^2\theta=1$이므로

$\|\bold{c}\|^2=\|\bold{a}\|^2-2\|\bold{a}\| \|\bold{b}\| cos\theta+\|\bold{b}\|^2$



ii) 피타고라스 정리에 의해 $\|\bold{c}\|^2=(a_x-b_x)^2+(a_y-b_y)^2$이고,

따라서 $\|\bold{c}\|^2=a_x^2-2a_bb_x+b_x^2+a_y^2-2a_yb_y+b_y^2$이다.



iii) i)과 ii)을 조합하면

$a_x^2-2a_bb_x+b_x^2+a_y^2-2a_yb_y+b_y^2=\|\bold{a}\|^2-2\|\bold{a}\| \|\bold{b}\| cos\theta+\|\bold{b}\|^2$

이때, $\|\bold{a}\|^2=a_x^2+a_y^2$이며, $\|\bold{b}\|^2=b_x^2+b_y^2$ 이므로

$a_x^2-2a_bb_x+b_x^2+a_y^2-2a_yb_y+b_y^2=a_x^2+a_y^2-2\|\bold{a}\| \|\bold{b}\| cos\theta+b_x^2+b_y^2$

$-2a_bb_x-2a_yb_y=-2\|\bold{a}\| \|\bold{b}\| cos\theta$

$-2(a_bb_x+a_yb_y)=-2(\|\bold{a}\| \|\bold{b}\| cos\theta)$

$a_xb_x+a_yb_y=\|\bold{a}\| \|\bold{b}\|cos\theta$



#### (5). 알아두면 좋은 내적 연산

* 제곱
  * $\vec{a}\bull\vec{a}=a_x^2+a_y^2+a_z^2$이므로, $\vec{a}$의 **길이(=원점에서 벡터 끝부분 까지의 거리)의 제곱**과 같다!★
  * $\vec{a}\bull\vec{a}=\|\vec{a}\|^2$
* **결합법칙**  $\vec{a}\bull\vec{b}+\vec{a}\bull\vec{c}=\vec{a}\bull(\vec{b}+\vec{c})$
  * $\vec{a}\bull\vec{b}=a_xb_x+a_yb_y+a_zb_z$ 이고
  * $\vec{a}\bull\vec{c}=a_xc_x+a_yc_y+a_zc_z$ 이므로
  * $\vec{a}\bull\vec{b}+\vec{a}\bull\vec{c}=a_xb_x+a_yb_y+a_zb_z+a_xc_x+a_yc_y+a_zc_z$ 이다.
  * 식을 정리하면
  * $\vec{a}\bull\vec{b}+\vec{a}\bull\vec{c}=a_x(b_x+c_x)+a_y(b_y+c_y)+a_z(b_z+c_z)$ 이다.
  * 따라서 $a_x(b_x+c_x)+a_y(b_y+c_y)+a_z(b_z+c_z)=\vec{a}\bull(\vec{b}+\vec{c})$ 이다.



* **결합법칙 응용**  $\vec{a}\bull\vec{a}+2\vec{a}\bull\vec{b}+\vec{b}\bull\vec{b}=(\vec{a}+\vec{b})\bull(\vec{a}+\vec{b})$
  * $\vec{a}\bull\vec{a}+2\vec{a}\bull\vec{b}+\vec{b}\bull\vec{b}$
  * $\vec{a}\bull\vec{a}+\vec{a}\bull\vec{b}+\vec{a}\bull\vec{b}+\vec{b}\bull\vec{b}$
  * $\vec{a}\bull(\vec{a}+\vec{b})+\vec{b}\bull(\vec{a}+\vec{b})$
  * $(\vec{a}+\vec{b})\bull(\vec{a}+\vec{b})$

### 3). Cross product 벡터 곱

$\bold{v}\times\bold{w}=(v_yw_z-v_zw_y,\ v_zw_x-v_xw_z,\ v_xw_y-v_yw_x)$

$\bold{v}\times\bold{v}=(v_yv_z-v_zv_y,\ v_zv_x-v_xv_z,\ v_xv_y-v_yv_x)=\bold{0}$

$\bold{v}\times-\bold{v}=(-v_yv_z+v_zv_y,\ -v_zv_x+v_xv_z,\ -v_xv_y+v_yv_x)=\bold{0}$



### 4). Projection 투영(사영)

![](Asset\vector_projection.png)

$\vec{a}$를 $\vec{b}$에 **투영한 벡터의 길이**는

$\|\vec{a_{proj}}\|=\|\vec{a}\|cos\theta=\dfrac{(\vec{a}\bull\vec{b})}{\|\vec{b}\|}$와 같다.

이때, $\vec{b}$가 단위벡터라면

$\|\vec{a_{proj}}\|=(\vec{a}\bull\hat{b})$ 이다.



$\vec{a}$를 $\vec{b}$에 투영한 벡터는

$\vec{a_{proj}}=\|\vec{a}\|cos\theta\dfrac{\vec{b}}{\|\vec{b}\|}=\dfrac{(\vec{a}\bull\vec{b})\vec{b}}{\|\vec{b}\|^2}$ 와 같다.

이때, $\vec{b}$가 단위벡터라면

$\vec{a_{proj}}=(\vec{a}\bull\hat{b})\hat{b}$ 이다.





### 5). Frame change 기저 변환 ★

![](Asset\frame_change.png)

위 그래프에서

벡터 $\vec{v_{xy}}$는 기저가 $\hat{x}=(1,0)$, $\hat{y}=(0,1)$일 때 $\vec{v_{xy}}=(3,5)$ 이다.

특정 기저에서 벡터의 좌표를 구하기 위해서는 **해당 벡터를 기저 벡터에 투영**하여 **길이**를 보면 된다.

예를 들어, $\vec{v_{xy}}$에 대해

$v_x=\vec{v_{xy}}\bull\hat{x}=3\times1+5\times0=3$

$v_y=\vec{v_{xy}}\bull\hat{y}=3\times0+5\times1=5$

이다.

이 계산을 행렬로 나타내면

$\vec{v_{xy}}=\vec{v}M_{proj}=(v_x,v_y)\begin{bmatrix}x_x&y_x\\ x_y& y_y\end{bmatrix}$

와 같다.



이제 벡터 $\vec{v_{xy}}$를 기저 $ij$로 옮겨보자.

먼저 $\vec{v_{xy}}-(2,2)$를 해서 원점을 새 기저의 원점으로 옮긴다.

$\vec{v}\prime=\vec{v_{xy}}-(2,2)=(1,3)$

이때

$\hat{i}=\dfrac{(2,1)}{\|\vec{i}\|}=(\dfrac{2}{\sqrt{5}},\dfrac{1}{\sqrt{5}})=(0.8944,0.4472)$ 이고

$\hat{j}=(-\dfrac{1}{\sqrt{5}},\dfrac{2}{\sqrt{5}})=(-0.4472,0.8944)$ 이다.

따라서 $\vec{v_{ij}}$에 대해

$v_i=\vec{v}\prime \bull \hat{i}$

$v_j=\vec{v}\prime \bull \hat{j}$

이고, 이를 행렬로 나타내면 다음과 같다.

$\vec{v_{ij}}=\vec{v} \prime M_{proj}=(v\prime_x,v\prime_y)\begin{bmatrix}i_x&j_x\\ i_y& j_y\end{bmatrix}=(1,3)\begin{bmatrix}0.8944&-0.4472\\ 0.4472& 0.8944\end{bmatrix}$

$=(1\times0.8944+3\times0.4472,1\times(-0.4472)+3\times0.8944)$

$=(0.8944+1.3416,-0.4472+2.6832)=(2.2236,2.2236)=(\sqrt{5},\sqrt{5})$

## 변환(transform)

### 선형 변환 (linear transform)

벡터 덧셈(vector addition), 스칼라 곱셉(scalar multiplication)

$\mathrm{f(\bold{x})+f(\bold{y})=f(\bold{x}+\bold{y})}$
$k\mathrm{f(\bold{x})=f(}k\mathrm{\bold{x})}$

### 평행 이동 (translation)

선형 변환과 평행 이동을 같이 하려면 아핀 변환(affine transform)이 필요하다.



## 평면★★

평면의 법선 벡터와 평면 위의 한 점을 알면 평면의 방정식을 구할 수 있다.

![plane](Asset\plane.png)



평면 위의 한 점 $A(x_0,\ y_0,\ z_0)$를 알고,
평면에 수직인 법선의 벡터 $\vec{h}(a,\ b,\ c)$가 주어졌을 때,
평면 위의 임의의 점 $P(x,\ y,\ z)$에 대해 $\vec{AP}\bull \vec{h}=0$이다.

이 때 $\vec{AP}=P-A$ 이므로 $(P-A)\bull{}\vec{h}=0$이다.

-> $(x-x_0,\ y-y_0,\ z-z_0)\bull (a,\ b,\ c)=0\\$
-> $a(x-x_0)+b(y-y_0)+c(z-z_0)=0\\$
-> $ax+by+cz+d=0\\$  (단, $d=-ax_0-by_0-cz_0$)

평면의 법선 벡터 $\vec{\mathrm{n}}=(a, b, c)$

평면 위의 점 $\vec{\mathrm{x}}=(x, y, z)$

평면 $\pi:\ \vec{\mathrm{n}} \cdot \vec{\mathrm{x}}+d=0$

$\vec{\mathrm{n}} \cdot \vec{\mathrm{x}}+d>0$ 일 경우 **양의 절반 공간(positive half space)**
$\vec{\mathrm{n}} \cdot \vec{\mathrm{x}}+d<0$ 일 경우 **음의 절반 공간(negative half space)**



예) $x + y + z - 5 = 0$

​	법선 벡터 $\vec{h}=(1, 1, 1)$



### 점과 평면의 거리

평면 $ax+by+cz+d=0$의 법선 벡터 $\hat{n}=(a, b, c)$가 정규화된 벡터이고, 평면 위의 점 $V$를 알 때,

공간 상 임의의 점 $P$에 대해

점 $P$와 평면 사이의 거리는

$(P-V)\bull\vec{n}=P\bull\vec{n}-V\bull\vec{n}$ 이다.

이때, 평면의 정의에 따라 $d=-V\bull\vec{n}$이므로

$P\bull\vec{n}+d$이다.

(단, $P$가 평면의 앞쪽에 있을 때 거리는 양수이고, 평면의 뒤쪽에 있을 때 거리는 음수이다.)

## 반직선의 방정식

반직선 $H$의 시작점을 $O$라 하고

이동 방향을 $D$라고 할 때,

반직선의 식은

$H=O+tD$와 같다. (단, $t>0$)

## 직선과 점의 거리

두 점 $P_0$과 $P_1$을 지나는 직선 $L$ 이 있을 때

공간 상 임의의 점 $Q$에 대해 점 $Q$와  직선 $L$ 사이의 거리는 다음과 같다.

먼저, 직선 $L$와 평행한 벡터 $\vec{v}=P_1-P_0$ 라고 하자.

직선 위의 점 $P_0$에서 점 $Q$로 향하는 벡터 $\vec{q}=Q-P_0$라고 하자.

$\vec{q}$를 $\vec{v}$에 투영한 벡터 $\vec{q}\prime=\dfrac{(\vec{q}\bull\vec{v})\vec{v}}{\|\vec{v}\|^2}$ 이다.

이 때, 직선 $L$에서 점 $Q$로 직각으로 향하는 벡터를 $\vec{d}$라고 하면

$\vec{q}=\vec{d}+\vec{q}\prime$ 이므로

$\vec{d}=\vec{q}-\vec{q}\prime$

=> $\vec{d}=\vec{q}-\dfrac{(\vec{q}\bull\vec{v})\vec{v}}{\|\vec{v}\|^2}$ 

이때, 거리는 $\|\vec{d}\|=\sqrt{\vec{d} \bull \vec{d}}$ 이다.

거리의 제곱은 $\|\vec{d}\|^2=\vec{d} \bull \vec{d}$ 이다.



## 구의 방정식

$C$를 구의 중심에 있는 점

$r$을 구의 반지름이라고 할 때,

구 위의 임의의 점 $P=(P_x,\ P_y, P_z)$는

식 $(P_x-C_x)^2+(P_y-C_y)^2+(P_z-C_z)^2=r^2$을 만족한다.



## 구 그리기 (Sphere coordinates)

각도로 $\theta$ (theta)와 $\phi$ (phi)를 사용



## 2. 행렬 (왼손좌표계 기준)

### 1). 행렬의 계산

#### (1). 행렬의 덧셈

#### (2). 행렬과 벡터의 곱셈

왼손 좌표계에서는 행 벡터와 행렬을 곱하며, 그 계산은 다음과 같다.

![](Asset\matrix_mul.png)

즉,

$x\prime = xm_{00} + ym_{10} + zm_{20}$

$y\prime = xm_{01} + ym_{11} + zm_{21}$

$z\prime = xm_{02} + ym_{12} + zm_{22}$

이다.



### 2). 월드 행렬

#### (1). 이동 (Translation)

동차좌표계의 필요성 등장!!!

$T=\begin{bmatrix}1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 1 & 0 \\ t_x & t_y & t_z & 1\end{bmatrix}$

#### (2). 크기 (Scaling)

$S=\begin{bmatrix}s_x & 0 & 0 & 0 \\ 0 & s_y & 0 & 0 \\ 0 & 0 & s_z & 0 \\ 0 & 0 & 0 & 1\end{bmatrix}$

#### (3). 회전 (Rotation)

##### i). 벡터 회전



##### ii). 기저 회전

![](Asset\rotation_frame.png)

위의 두 그래프에서 볼 수 있듯이

벡터 $\vec{v}$를 시계 반대방향으로 각 $\theta$만큼 회전시키는 것(좌측 그래프)은 각 기저를 시계 방향으로 각 $\theta$만큼 회전시키는 것(우측 그래프)과 같다.

![](Asset\rotation_frame_detail.png)

원래 기저가 $\hat{x}=(1, 0)$이고, $\hat{y}=(0, 1)$일 때,

각 기저를 시계 방향으로 $\theta$만큼 회전하면

$\hat{x}\prime=(cos\theta, -sin\theta)$

$\hat{y}\prime = (sin\theta, cos\theta)$

와 같다.

이때 (기저 회전에 의해) 회전된 벡터 $\vec{v}\prime$은

새로운 각 기저에 투영한 길이로 구성된 벡터다.

$\vec{v}\prime = (\vec{v}\bull\hat{x}\prime, \vec{v}\bull\hat{y}\prime)$

​     $=(cos\theta v_x-sin\theta v_y, sin\theta v_x, cos\theta v_y)$

이때 이 회전 변환을 $R$이라 하면

$R=\begin{bmatrix} cos\theta & -sin\theta \\ sin\theta & cos\theta \end{bmatrix}$ 이다.





$R_x=\begin{bmatrix}1 & 0 & 0 & 0 \\ 0 & cos\theta & -sin\theta  & 0 \\ 0 & sin\theta  & cos\theta  & 0 \\ 0 & 0 & 0 & 1\end{bmatrix}$





##### iii). Pitch, Yaw, Roll

![](Asset\pitch_yaw_roll.png)



### 3). 뷰 행렬

뷰 행렬이 하는 일: 기존 $x, y, z$ 기저에 있던 벡터를 새로운 기저 $i, j, k$로 옮기는 것!



카메라의 위치(eye)  $\vec{e}=(e_x,e_y,e_z)$ (= 새로운 기저의 원점)

바라보는 곳(lookat) $\vec{l}=(l_x,l_y,l_z)$ (= 새로운 기저의 $+z$방향)

상향(up) 벡터를 $\vec{u}=(u_x,u_y,u_z)$ (= 새로운 기저의 $+y$방향)

라고 하면

기저 $\hat{k}=\dfrac{\vec{l}}{|\vec{l}|}$

기저 $\hat{i}=\dfrac{\vec{i}}{|\vec{i}|}$ 이때 $\vec{i}=\vec{u} \times \vec{k}$

기저 $\hat{j}=\dfrac{\vec{j}}{|\vec{j}|}$ 이때 $\vec{j}=\vec{k} \times \vec{i}$

이다.



이때, 임의의 벡터 $\vec{v}$에 대해

먼저 벡터를 이동해 기존 원점을 새로운 기저의 원점에 맞춘다.

$\vec{v}\prime=\vec{v}-\vec{e}$

그 다음 벡터 $\vec{v}\prime$를 새로운 기저 벡터들($i, j, k$)에 투영한다.

$\vec{v_{ijk}}=\vec{v}\prime\begin{bmatrix}i_x&j_x&k_x\\ i_y&j_y&k_y \\ i_z&j_z&k_z \end{bmatrix}$

$=(v\prime_xi_x+v\prime_yi_y+v\prime_zi_z,v\prime_xj_x+v\prime_yj_y+v\prime_zj_z,v\prime_xk_x+v\prime_yk_y+v\prime_zk_z)$

$=(\vec{v}\prime \bull \hat{i},\vec{v}\prime \bull \hat{j},\vec{v}\prime \bull \hat{k})$

$=((\vec{v}-\vec{e}) \bull \hat{i},(\vec{v}-\vec{e}) \bull \hat{j},(\vec{v}-\vec{e}) \bull \hat{k})$

$=(\vec{v} \bull \hat{i}-\vec{e} \bull \hat{i},\vec{v} \bull \hat{j}-\vec{e} \bull \hat{j},\vec{v} \bull \hat{k}-\vec{e} \bull \hat{k})$



이를 동차좌표계로 옮기면 $-\vec{e} \bull \hat{i}(or\ \hat{j}\ or\ \hat{k})$ 계산을 간단히 할 수 있다.

$\vec{v_{ijkl}}=\vec{v_{xyzw}}\begin{bmatrix}i_x&j_x&k_x&0\\i_y&j_y&k_y&0\\i_z&j_z&k_z&0\\ -\vec{e}\bull\hat{i}&-\vec{e}\bull\hat{j}&-\vec{e}\bull\hat{k}&1\end{bmatrix}$



$\therefore M_{view}=\begin{bmatrix}i_x&j_x&k_x&0\\i_y&j_y&k_y&0\\i_z&j_z&k_z&0\\ -\vec{e}\bull\hat{i}&-\vec{e}\bull\hat{j}&-\vec{e}\bull\hat{k}&1\end{bmatrix}$



### 4). 투영 행렬

#### (1). 원근 투영 행렬(Perspective projection matrix)

어떤 동차 좌표 $P_4 = (x,y,z,1)$에 대해

동차 원근 투영행렬 $M_{proj}$를 곱한 결과값을 $P_{proj4} = (x_{proj4}, y_{proj4},z_{proj4},w_{proj4})$라고 하자.

이때 $P_{proj4}$를 3차원 좌표로 옮기면

$P_{proj3}=(\dfrac{x_{proj4}}{w_{proj4}},\dfrac{y_{proj4}}{w_{proj4}},\dfrac{z_{proj4}}{w_{proj4}})$ 이다.

이때, $w_{proj4}=z$라면

$P_{proj3}=(\dfrac{x_{proj4}}{z},\dfrac{y_{proj4}}{z},\dfrac{z_{proj4}}{z})$이 된다.

$x_{proj}=\dfrac{x}{z}$

$y_{proj}=\dfrac{y}{z}$

이고,

이때, $w_{proj4}=z$로 만드는 $M_{proj}$은

$M_{proj}=\begin{bmatrix}?&?&?&0 \\ ?&?&?&0 \\ ?&?&?&1 \\ ?&?&?&0\end{bmatrix}$ 이다.



![yz](Asset\perspective_projection_yz.png)



$y$의 값을 각 $\theta$와 $z$값의 관계로 정의하면 그래프에서 볼 수 있듯이

$y=[-z\tan\dfrac{\theta}{2},z\tan\dfrac{\theta}{2}]$ 이다.

여기서 우리는 $y_{proj3}=\dfrac{y_{proj4}}{z}$라고 정의했다.

이때 $y_{proj4}=\alpha y$라고 하면 $y_{proj3}=\dfrac{\alpha y}{z}$이므로

$y_{proj3}=[\dfrac{-\alpha z\tan\dfrac{\theta}{2}}{z},\dfrac{\alpha z\tan\dfrac{\theta}{2}}{z}]$이다.

즉, $y_{proj3}=[-\alpha\tan\dfrac{\theta}{2},\alpha\tan\dfrac{\theta}{2}]$이다.

이때 $y_{proj3}$의 범위를 $y_{proj3}=[-1,1]$로 만드려면 $\alpha=\dfrac{1}{tan\dfrac{\theta}{2}}$이다.



$M_{proj}=\begin{bmatrix}?&0&?&0 \\ ?&\dfrac{1}{tan\dfrac{\theta}{2}}&?&0 \\ ?&0&?&1 \\ ?&0&?&0\end{bmatrix}$



![xz](Asset\perspective_projection_xz.png)



$M_{proj}=\begin{bmatrix}\dfrac{1}{tan\dfrac{\phi}{2}}&0&?&0 \\ 0&\dfrac{1}{tan\dfrac{\theta}{2}}&?&0 \\ 0&0&?&1 \\ 0&0&?&0\end{bmatrix}$



이때 만약

$M_{proj}=\begin{bmatrix}\dfrac{1}{tan\dfrac{\phi}{2}}&0&0&0 \\ 0&\dfrac{1}{tan\dfrac{\theta}{2}}&0&0 \\ 0&0&a&1 \\ 0&0&0&0\end{bmatrix}$라고 하면

$z_{proj4}=az$이고, $z_{proj3}=\dfrac{z_{proj4}}{z}=\dfrac{az}{z}=a$이다.

그러나 $z_{proj3}$는 $[0,1]$의 범위를 가져야 하므로 상수 $a$일 수 없다!



그럼 이때

$M_{proj}=\begin{bmatrix}\dfrac{1}{tan\dfrac{\phi}{2}}&0&0&0 \\ 0&\dfrac{1}{tan\dfrac{\theta}{2}}&0&0 \\ 0&0&a&1 \\ 0&0&b&0\end{bmatrix}$라고 하면

$z_{proj4}=az+b$이고, $z_{proj3}=\dfrac{z_{proj4}}{z}=\dfrac{az+b}{z}$이다.

이때, $z_{proj3}=[0,1]$로 만드는 값 $a$를 찾아야 한다.

즉, $z=z_n$일 경우 $z_{proj3}=0$이 되고

$z=z_f$일 경우 $z_{proj3}=1$이 되는 $a$를 찾으면 된다.

즉, $\dfrac{az_n+b}{z_n}=0$이고, $\dfrac{az_f+b}{z_f}=1$인 $a$의 값을 구하면 된다!

식을 정리하면

* 식1: $az_n+b=0$

* 식2: $az_f+b=z_f$

과 같다.

식2-식2는 $a(z_f-z_n)=z_f$ 이므로 $a=\dfrac{z_f}{z_f-z_n}$ 이다.

이때 $b=-az_n$이므로 $b=\dfrac{-z_fz_n}{z_f-z_n}$ 이다.

$\therefore M_{proj}=\begin{bmatrix}\dfrac{1}{tan\dfrac{\phi}{2}}&0&0&0 \\ 0&\dfrac{1}{tan\dfrac{\theta}{2}}&0&0 \\ 0&0&\dfrac{z_f}{z_f-z_n}&1 \\ 0&0&\dfrac{-z_fz_n}{z_f-z_n}&0\end{bmatrix}$

이때 화면 비율 $r=\dfrac{width}{height}$이 주어지면

$M_{proj}=\begin{bmatrix}\dfrac{1}{r\times tan\dfrac{\theta}{2}}&0&0&0 \\ 0&\dfrac{1}{tan\dfrac{\theta}{2}}&0&0 \\ 0&0&\dfrac{z_f}{z_f-z_n}&1 \\ 0&0&\dfrac{-z_fz_n}{z_f-z_n}&0\end{bmatrix}$



#### (2). 직교 투영 행렬(Orthographic projection matrix)

![](Asset\orthographic_projection_xz.png)

![](Asset\orthographic_projection_yz.png)

카메라의 입장에서 (즉, 뷰 변환 이후의 좌표들에 대해)

화면의 가로 크기를 $width$, 세로 크기를 $height$라고 할 때,

$x = [-\dfrac{width}{2},\dfrac{width}{2}]$이다.

이를 $x=[-1.0, 1.0]$로 바꾸려면

$x$값에 $\dfrac{2}{width}$를 곱하면 된다.

마찬가지로

$y = [-\dfrac{height}{2},\dfrac{height}{2}]$이고,

이를 $y=[-1.0, 1.0]$로 바꾸려면

$y$값에 $\dfrac{2}{height}$를 곱하면 된다.

$M_{ortho}=\begin{bmatrix}\dfrac{2}{width}&0&0&0 \\ 0&\dfrac{2}{height}&0&0 \\ 0&0&?&0 \\ 0&0&?&1\end{bmatrix}$

이 때,

$z=[zn,zf]$이므로

$\dfrac{z-zn}{zf-zn}$을 계산하면 $z=[0, 1]$이 된다.

$\therefore M_{ortho}=\begin{bmatrix}\dfrac{2}{width}&0&0&0 \\ 0&\dfrac{2}{height}&0&0 \\ 0&0&\dfrac{1}{zf-zn}&0 \\ 0&0&-\dfrac{zn}{zf-zn}&1\end{bmatrix}$



#### 





## 사원수 (Quaternion)

### 정의

사원수 $\hat{q}$는 다음과 같이 정의될 수 있다.

$\hat{\bold{q}}=(\bold{q_v},\ q_w) = iq_x+jq_y+kq_z+q_w=\bold{q_v}+q_w$

$\bold{q_v}=iq_x+jq_y+kq_z=(q_x,q_y,q_z)$

이때, $i=j=k=\sqrt{-1}$이고,

$i^2=j^2=k^2=-1$ 이고,  $ij=-ji=k$, $jk=-kj=i$, $ki=-ik=j$ 이다.

$q_w$는 사원수 $\hat{\bold{q}}$의 실수부이다.

$\bold{q_v}$는 허수부이다.





### 곱셈

$\bold{\hat{q}\hat{r}}=(iq_x+jq_y+kq_z+q_w)(ir_x+jr_y+kr_z+r_w)$

=> $-q_xr_x +kq_xr_y -jq_xr_z +iq_xr_w \\ -kq_yr_x -q_yr_y +iq_yr_z+jq_yr_w \\ +jq_zr_x -iq_zr_y -q_zr_z +kq_zr_w \\ +iq_wr_x +jq_wr_y +kq_wr_z +q_wr_w$

=> $i(q_yr_z -q_zr_y +r_wq_x +q_wr_x) \\ + j(q_zr_x -q_xr_z +r_wq_y +q_wr_y) \\ + k(q_xr_y -q_yr_x +r_wq_z +q_wr_z) \\ + q_wr_w -q_xr_x -q_yr_y -q_zr_z$

이때 $\bold{q_v} \times \bold{r_v}=(q_yr_z-q_zr_y, q_zr_x-q_xr_z, q_xr_y-q_yr_x)$ 이고

$r_w\bold{q_v}=(r_wq_x, r_wq_y, r_wq_z)$, $q_w\bold{r_v}=(q_wr_x, q_wr_y, q_wr_z)$ 이므로

$\therefore \bold{\hat{q}\hat{r}}=(\bold{q_v} \times \bold{r_v} + r_w\bold{q_v} +q_w\bold{r_v},\ q_wr_w -\bold{q_v} \bull \bold{r_v})$



### 덧셈

$\bold{\hat{q}+\hat{r}}=(\bold{q_v},q_w)+(\bold{r_v},r_w)=(\bold{q_v+r_v},q_w+r_w)$



### 켤레 Conjugate

$\bold{\hat{q}}^*= (\bold{q_v},q_w)^* = (-\bold{q_v},q_w)$ (허수부 방향이 반대)



### 노름 Norm

$n(\bold{\hat{q}})=\sqrt{\bold{\hat{q}\hat{q}^*}}= \sqrt{\bold{\hat{q}^*\hat{q}}} =\sqrt{\bold{q_v \cdot q_v}+q_w^2}$

$=\sqrt{q_x^2+q_y^2+q_z^2+q_w^2}$



### 단위? identity

$\bold{\hat{i}}=(\bold{0}, 1)$



### 단위 사원수 unit quaternion

$n(\bold{\hat{q}})=1$인 사원수 $\bold{\hat{q}}$ 를 단위 사원수라고 한다.

$\bold{\hat{q}}=(\bold{q_v},q_w)$

이때, $\bold{\hat{q}}=(sin\phi\bold{u},cos\phi)$ (단, $\bold{u}$는 단위 벡터) 라고 두면

$n(\bold{\hat{q}}) = \sqrt{sin^2\phi\bold{u \cdot u}+cos^2\phi} = \sqrt{sin^2\phi+cos^2\phi} = 1$ 이다.



특정 축을 기준으로 각도가 주어지면 회전!!



## 3. 교차 (Intersection) & 충돌 (Collision)

### 1) 반직선 - 단위 구 교차 (Ray - unit sphere intersection)

반직선의 시작점: $O$

반직선의 방향: $D$

구의 중심: $C$

구의 반지름: $r$



구의 방정식 $(P_x-C_x)^2+(P_y-C_y)^2+(P_y-C_y)^2=r^2$ 을 벡터를 사용해 간단히 나타내면

$\vec{P}=\{P_x, P_y, P_z\}$

$\vec{C}=\{C_x, C_y, C_z\}$

구의 방정식: $(\vec{P}-\vec{C})\bull(\vec{P}-\vec{C})=r^2$

반직선의 방정식: $\vec{R}=\vec{O}+t\vec{D}$

두 방정식을 연립하면

$(\vec{O}+t\vec{D}-\vec{C})\bull(\vec{O}+t\vec{D}-\vec{C})=r^2$

=> $(O_x+tD_x-C_x)^2+(O_y+tD_y-C_y)^2+(O_z+tD_z-C_z)^2=r^2$



이때, $(O_x+tD_x-C_x)^2$

$= O_x^2+tO_xD_x-O_xC_x+tO_xD_x+t^2D_x^2-tD_xC_x-O_xC_x-tD_xC_x+C_x^2$

$= O_x^2 +t^2D_x^2 +C_x^2 +2tO_xD_x -2O_xC_x -2tD_xC_x$

이므로



$(O_x+tD_x-C_x)^2+(O_y+tD_y-C_y)^2+(O_z+tD_z-C_z)^2=r^2$

=> $O_x^2 +t^2D_x^2 +C_x^2 +2tO_xD_x -2O_xC_x -2tD_xC_x +\\ O_y^2 +t^2D_y^2 +C_y^2 +2tO_yD_y -2O_yC_y -2tD_yC_y +\\ O_z^2 +t^2D_z^2 +C_z^2 +2tO_zD_z -2O_zC_z -2tD_zC_z = r^2$

=> $\vec{O}\bull\vec{O} + t^2\vec{D}\bull\vec{D} + \vec{C}\bull\vec{C} + 2t\vec{O}\bull\vec{D} -2\vec{O}\bull\vec{C} -2t\vec{D}\bull\vec{C}=r^2$

=> $\vec{D}\bull\vec{D}t^2 + 2(\vec{O}\bull\vec{D}-\vec{D}\bull\vec{C})t + \vec{O}\bull\vec{O} + \vec{C}\bull\vec{C} -2\vec{O}\bull\vec{C} =r^2$

=> $\vec{D}\bull\vec{D}t^2 + 2(\vec{O}\bull\vec{D}-\vec{D}\bull\vec{C})t + \vec{O}\bull\vec{O} + \vec{C}\bull\vec{C} -2\vec{O}\bull\vec{C} =r^2$

=> $\vec{D}\bull\vec{D}t^2 + 2(\{\vec{O}-\vec{C}\}\bull\vec{D})t + (\vec{O}-\vec{C})\bull(\vec{O}-\vec{C}) - r^2 = 0$



위의 t에 관한 2차 방정식에서 판별식 $b^2-4ac \ge 0$ 일 때 근이 존재하므로 교차한다!

이때 근의 공식을 이용해 t를 구하면 교차한 지점의 좌표를 구할 수 있다.



### 2) 반직선- 삼각형 교차 (Ray - triangle intersection)

반직선 시작점 $R_o$

반직선 방향 $R_d$

삼각형 평면 법선 $N$

삼각형을 이루는 정점 $V0, V1, V2$

평면의 방정식: $\vec{P}\bull\vec{N}+\vec{C}=0$ (단, $C=-\vec{V0}\bull\vec{N}$)

반직선의 방정식: $\vec{R_o}+t\vec{R_d}$

연립

$(\vec{R_o}+t\vec{R_d})\bull\vec{N}+\vec{C}=0$

$\vec{R_o}\bull\vec{N}+t\vec{R_d}\bull\vec{N}+\vec{C}=0$

$t\vec{R_d}\bull\vec{N}=-\vec{R_o}\bull\vec{N}-\vec{C}$

$t=\dfrac{-\vec{R_o}\bull\vec{N}-\vec{C}}{\vec{R_d}\bull\vec{N}}$





### 3) 움직이는 단위 구 - 삼각형 충돌 Unit sphere- triangle collision

처음 구의 중심의 위치: $C$

구의 속도: $\vec{v}$

구가 움직이는 시간: $t$

$t$시간 동안 이동한 구의 (중심의) 위치: $C\prime=C+t\vec{v}$ 

공간 상의 임의의 점 $P$에 대해 점 $P$와 평면 사이의 거리 $Dist(P)=P\bull\vec{n}+d$



#### (1) 구와 평면의 충돌

구가 평면의 앞면과 충돌하는 시점: $t_0$

구가 평면의 뒷면과 충돌하는 시점: $t_1$

$t = [t_0, t_1]$의 범위에서 구는 평면과 충돌한다.

$t_0$시점에서 (단위) 구와 평면 사이의 거리는 $Dist(C+t_0\vec{v}) = +1.0$ 이어야 한다.

즉, $(C+t_0\vec{v})\bull\vec{n}+d=1$이어야 한다.

$(C+t_0\vec{v})\bull\vec{n}+d=1$

=> $C\bull\vec{n}+t_0(\vec{v}\bull\vec{n})=1 - d$

=> $t_0(\vec{v}\bull\vec{n})=1 - d - C\bull\vec{n}$

=> $t_0=\dfrac{1 - d - C\bull\vec{n}}{\vec{v}\bull\vec{n}}=\dfrac{1 - (C\bull\vec{n} + d)}{\vec{v}\bull\vec{n}}$

$\therefore t_0=\dfrac{1 - Dist(C)}{\vec{v}\bull\vec{n}}$

마찬가지로, $t_1$시점에 구와 평면 사이의 거리는 $Dist(C+t_1\vec{v})=-1.0$ 이어야 한다.

$\therefore t_1 = \dfrac{-1-Dist(C)}{\vec{v}\bull\vec{n}}$

다만, $\vec{v}\bull\vec{n}=0$인 경우 위 공식을 사용할 수 없다! (분모가 0이 되므로)

즉, 속도가 법선 벡터와 정확히 직각을 이루는 경우, 다시 말해 구의 진행 방향이 평면과 평행할 경우 위 공식을 사용할 수 없다.

이 경우 구와 평면의 거리가 $Dist(C+t\vec{v})<=|1.0|$인 경우에만 구가 평면과 충돌할 수 있으며, 삼각형의 내부가 아닌 꼭짓점이나 변과만 충돌할 수 있다.

#### (2) 구가 삼각형의 내부와 충돌

구가 삼각형의 앞면과 충돌하는 지점 $P_c=C-\vec{n}+t_0\vec{v}$

#### (3) 구가 삼각형의 옆(꼭짓점, 변)과 충돌 (sweep test)

##### i). 구가 삼각형의 꼭짓점(vertex)과 충돌

꼭짓점 $P$에 대해 $P$과 $C\prime$사이의 거리가 1일 때 충돌.

$\sqrt{(C\prime-P)\bull(C\prime-P)}=1$

=> $(C\prime-P)\bull(C\prime-P)=1^2$

=> $(C\prime-P)\bull(C\prime-P)-1=0$

=> $C\prime \bull C\prime - 2C\prime \bull P + P \bull P -1=0$

=> $(C+t\vec{v}) \bull (C+t\vec{v}) - 2(C+t\vec{v}) \bull P + P \bull P -1=0$

이때, 벡터 연산에서 $(\vec{a}+\vec{b}) \bull (\vec{a}+\vec{b})=\vec{a} \bull \vec{a} + 2\vec{a} \bull \vec{b} + \vec{b} \bull \vec{b}$ 이므로

=> $C \bull C + 2C\bull t \vec{v} +t\vec{v} \bull t\vec{v} - 2(C+t\vec{v}) \bull P + P \bull P -1=0$

=> $C \bull C + 2C\bull t \vec{v} +t\vec{v} \bull t\vec{v} - 2C \bull P-2t\vec{v} \bull P + P \bull P -1=0$

식을 $t$에 대해 정리하면

=> $C \bull C + (2C\bull \vec{v})t +(\vec{v} \bull \vec{v}) t^2 - 2C \bull P-(2\vec{v} \bull P) t + P \bull P -1=0$

=> $(\vec{v} \bull \vec{v}) t^2 + (2C\bull \vec{v})t - (2\vec{v} \bull P) t + C \bull C - 2C \bull P + P \bull P -1=0$

=> $(\vec{v} \bull \vec{v}) t^2 + (2C\bull \vec{v}-2P \bull \vec{v})t + C \bull C - 2C \bull P + P \bull P -1=0$

=> $(\vec{v} \bull \vec{v}) t^2 + \{2(C-P) \bull \vec{v}\}t + C \bull C - 2C \bull P + P \bull P -1=0$

=> $(\vec{v} \bull \vec{v}) t^2 + \{2(C-P) \bull \vec{v}\}t + (C - P) \bull (C - P) -1=0$

$t$에 대한 이차 방정식 $at^2 + bt + c =0$에 대해

$a=\vec{v}\bull\vec{v}$

$b=2(C-P)\bull\vec{v}$

$c=(C-P)\bull(C-P)-1$

이때 $t=\dfrac{-b \pm \sqrt{b^2-4ac} }{2a}$ 이다.

우리는 두 개의 근 중 작은 근 $t_s=\dfrac{-b - \sqrt{b^2-4ac} }{2a}$ 을 사용한다(== 처음으로 구가 정점과 충돌하는 시점)

##### ii). 구가 삼각형의 변(edge)과 충돌

삼각형의 한 변을 꼭지점 $P_1-P_0$로 정의하면

변과 $C\prime$ 사이의 거리가 1일 때 충돌.

변을 $\vec{e}=P_1-P_0$ 이라 하고

정규화된 변을 $\hat{e}=\dfrac{\vec{e}}{\|\vec{e}\|}$ 라고 하자.

$P_0$에서 $C\prime$으로 향하는 벡터를

 $\vec{c}\prime=C\prime-P_0=\vec{c}+t\vec{v}$이라 하자.

$\vec{c}=C-P_0$

이때 거리의 제곱은 $\|\vec{d}\|^2=\{\vec{c}\prime-(\vec{c}\prime\bull\hat{e})\hat{e}\} \bull \{\vec{c}\prime-(\vec{c}\prime\bull\hat{e})\hat{e}\}$ 이다.

=> $1=\vec{c}\prime \bull \vec{c}\prime - 2 \vec{c}\prime \bull (\vec{c}\prime \bull \hat{e})\hat{e}+(\vec{c}\prime\bull\hat{e})\hat{e} \bull (\vec{c}\prime\bull\hat{e})\hat{e}$

=> $1=\vec{c}\prime \bull \vec{c}\prime - 2 (\vec{c}\prime \bull \hat{e}) \vec{c}\prime \bull \hat{e}+(\vec{c}\prime\bull\hat{e})(\vec{c}\prime\bull\hat{e})\hat{e} \bull \hat{e}$

이때, $\hat{e}$는 정규화된 벡터이므로 $\hat{e}\bull\hat{e}=1$이다.

=> $1=\vec{c}\prime \bull \vec{c}\prime - 2 (\vec{c}\prime \bull \hat{e}) (\vec{c}\prime \bull \hat{e})+(\vec{c}\prime\bull\hat{e})(\vec{c}\prime\bull\hat{e})$

=> $1=\vec{c}\prime \bull \vec{c}\prime - (\vec{c}\prime \bull \hat{e}) (\vec{c}\prime \bull \hat{e})$

=> $1=(\vec{c}+t\vec{v}) \bull (\vec{c}+t\vec{v}) - \{(\vec{c}+t\vec{v}) \bull \hat{e}\} \{(\vec{c}+t\vec{v}) \bull \hat{e}\}$

=> $1=\vec{c} \bull \vec{c}+2(\vec{c} \bull \vec{v})t + (\vec{v} \bull \vec{v})t^2 - \{(\vec{c}+t\vec{v}) \bull \hat{e}\} \{(\vec{c}+t\vec{v}) \bull \hat{e}\}$

=> $1=\vec{c} \bull \vec{c}+2(\vec{c} \bull \vec{v})t + (\vec{v} \bull \vec{v})t^2 - (\vec{c} \bull \hat{e} + \vec{v} \bull \hat{e}t)(\vec{c} \bull \hat{e} + \vec{v} \bull \hat{e}t)$

=> $1=\vec{c} \bull \vec{c}+2(\vec{c} \bull \vec{v})t + (\vec{v} \bull \vec{v})t^2 - \{ (\vec{c} \bull \hat{e})(\vec{c} \bull \hat{e}) + 2(\vec{c} \bull \hat{e})( \vec{v} \bull \hat{e})t + (\vec{v} \bull \hat{e})(\vec{v} \bull \hat{e})t^2 \}$

=> $1=\vec{c} \bull \vec{c}+2(\vec{c} \bull \vec{v})t + (\vec{v} \bull \vec{v})t^2 - (\vec{c} \bull \hat{e})(\vec{c} \bull \hat{e}) - 2(\vec{c} \bull \hat{e})( \vec{v} \bull \hat{e})t - (\vec{v} \bull \hat{e})(\vec{v} \bull \hat{e})t^2$

=> $1= (\vec{v} \bull \vec{v})t^2 - (\vec{v} \bull \hat{e})(\vec{v} \bull \hat{e})t^2 + 2(\vec{c} \bull \vec{v})t - 2(\vec{c} \bull \hat{e})( \vec{v} \bull \hat{e})t + \vec{c} \bull \vec{c} - (\vec{c} \bull \hat{e})(\vec{c} \bull \hat{e}) $

=> $1= \{ (\vec{v} \bull \vec{v}) - (\vec{v} \bull \hat{e})(\vec{v} \bull \hat{e}) \}t^2 + 2\{ (\vec{c} \bull \vec{v}) - (\vec{c} \bull \hat{e})( \vec{v} \bull \hat{e}) \}t + \vec{c} \bull \vec{c} - (\vec{c} \bull \hat{e})(\vec{c} \bull \hat{e}) $

=> $0= \{ (\vec{v} \bull \vec{v}) - (\vec{v} \bull \hat{e})(\vec{v} \bull \hat{e}) \}t^2 + 2\{ (\vec{c} \bull \vec{v}) - (\vec{c} \bull \hat{e})( \vec{v} \bull \hat{e}) \}t + \vec{c} \bull \vec{c} - (\vec{c} \bull \hat{e})(\vec{c} \bull \hat{e}) - 1$

=> $0= ( \vec{v} \bull \vec{v} - \dfrac{(\vec{v} \bull \vec{e})(\vec{v} \bull \vec{e})}{\| \vec{e} \|^2} ) t^2 + 2 ( \vec{c} \bull \vec{v} - \dfrac{(\vec{c} \bull \vec{e})( \vec{v} \bull \vec{e})}{\| \vec{e} \|^2} ) t + \vec{c} \bull \vec{c} - \dfrac{\vec{c} \bull \vec{e})(\vec{c} \bull \vec{e})}{\| \vec{e} \|^2} - 1$

이때 양변에 $\| \vec{e} \|^2$를 곱하면

=> $0= \{ \| \vec{e} \|^2(\vec{v} \bull \vec{v}) - (\vec{v} \bull \vec{e})(\vec{v} \bull \vec{e}) \} t^2 + 2 \{ \| \vec{e} \|^2 (\vec{c} \bull \vec{v}) - (\vec{c} \bull \vec{e})( \vec{v} \bull \vec{e}) \} t - (\vec{c} \bull \vec{e})(\vec{c} \bull \vec{e}) + \| \vec{e} \|^2(\vec{c} \bull \vec{c} - 1)$

$t$에 대한 이차 방정식 $at^2+bt+c=0$에서

$a = \| \vec{e} \|^2(\vec{v} \bull \vec{v}) - (\vec{v} \bull \vec{e})(\vec{v} \bull \vec{e})$

$b = 2 \| \vec{e} \|^2(\vec{c} \bull \vec{v}) - 2(\vec{c} \bull \vec{e})( \vec{v} \bull \vec{e})$

$c= - (\vec{c} \bull \vec{e})(\vec{c} \bull \vec{e}) + \| \vec{e} \|^2(\vec{c} \bull \vec{c} - 1)$

$t=\dfrac{-b \pm \sqrt{b^2-4ac} }{2a}$ 이다.



### 4) 단위 구 - 타원체 충돌 (Unit sphere - ellipsoid collision) ??

다른 모든 타원체를 기준이 되는 타원체의 공간으로 변환한다

기준이 되는 타원체는 이제 단위 구이다.

타원체의 중심 $E$ 에서 구의 중심 $C$ 으로 반직선을 그린다.

이때 반직선과 타원체의 경계가 교차하는 지점을 $I$라고 하면

$I$와 $C$사이의 거리가 1 이하이면 충돌이다 ??

$I$를 찾기 위해서는 먼저 타원체의 공간에서 반직선과의 교차점을 찾아 월드 공간으로 변환한다

![](Asset\sphere_ellipsoid_collision.png)