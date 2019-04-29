# 수학

## 1. 벡터

### 1-1. 벡터 표기법, 길이

#### 1-1-1. 벡터 표기법

벡터 $a$는 $\vec{a}$와 같이 표기하고,

벡터의 길이는 $|\vec{a}|$으로 표기한다.

벡터 $\vec{a}=(x,y)$의 길이는 $|\vec{a}|=\sqrt{x^2+y^2}$이다.

(삼차원 벡터 $\vec{b}=(x,y,z)$의 경우 그 길이는 $|\vec{b}|=\sqrt{x^2+y^2+z^2}$ 이다.)



#### 1-1-2. 벡터의 정규화

벡터의 길이가 $1$인 벡터를 단위 벡터(Unit vector)라 하며 $\hat{a}$와 같이 표기한다.

길이가 1이 아닌 벡터를 단위 벡터로 바꾸는 일을 정규화(Normalization)라고 한다.

벡터 $\vec{a}=(a_x,a_y,a_z)$를 정규화하면 $\hat{a}=\dfrac{\vec{a}}{|\vec{a}|}$

### 1-2. Dot product 내적

#### 1-2-1. 내적 계산 #1 (원소의 곱)

벡터 $\vec{a}$가 $(a_x,\ a_y,\ a_z)$이고

벡터 $\vec{b}$가 $(b_x,\ b_y,\ b_z)$이면

두 벡터의 내적은 $\vec{a}\bull\vec{b}$와 같이 나타내고 그 계산은 다음과 같다.
$$
\vec{a}\bull\vec{b}=a_xb_x+a_yb_y+a_zb_z
$$
즉, 내적의 결과는 **벡터**가 아니라 **스칼라** 값이다!!



#### 1-2-2. 내적 계산 #2 (삼각함수)

$$
\vec{a}\bull\vec{b}=|\vec{a}||\vec{b}|\cos\theta
$$

두 벡터가 단위벡터 (**정규화된 벡터)**인 경우 내적은 곧 **두 벡터의 사이각**의 cos과 같다!

다시 한 번, 내적의 결과는 **벡터**가 아니라 **스칼라** 값이다!



#### 1-2-3. 내적 계산 #3 (결론)

$$
\vec{a}\bull\vec{b}=a_xb_x+a_yb_y+a_zb_z=|\vec{a}||\vec{b}|\cos\theta
$$



#### 1-2-4. 내적 계산 증명

* 피타고라스의 정리 삼각함수 버전: $\sin^2\theta+\cos^2\theta=1$

  ![](Asset\trigonometry.png)

  $sin^2\theta=\dfrac{b^2}{c^2}$

  $cos^2\theta=\dfrac{a^2}{c^2}$

  $sin^2\theta+cos^2\theta=\dfrac{b^2}{c^2}+\dfrac{a^2}{c^2}=\dfrac{b^2+a^2}{c^2}$

  이때 피타고라스의 정리 $a^2+b^2=c^2$에 의해 $\dfrac{b^2+a^2}{c^2}=1$이다.

  $\therefore sin^2\theta+cos^2\theta=1$

* 내적 증명

![](Asset\vector_dot.png)

$\vec{a}=(a_x,a_y)$

$\vec{b}=(b_x,b_y)$

$\vec{c}=\vec{a}-\vec{b}=(a_x-b_x,a_y-b_y)$

i) 피타고라스의 정리에 의해 $|\vec{c}|^2=h^2+i^2$이다.

​	이때, $h=|\vec{b}|sin\theta$이고  $i=|\vec{a}|-|\vec{b}|cos\theta$이므로

​	$|\vec{c}|^2=(|\vec{b}|sin\theta)^2 + (|\vec{a}|-|\vec{b}|cos\theta)^2$이다.

​	$|\vec{c}|^2=|\vec{b}|^2sin^2\theta + |\vec{a}|^2-2|\vec{a}||\vec{b}|cos\theta+|\vec{b}|^2cos^2\theta$

​	$|\vec{c}|^2=|\vec{a}|^2-2|\vec{a}||\vec{b}|cos\theta+|\vec{b}|^2(cos^2\theta+sin^2\theta)$

​	이때, $cos^2\theta+sin^2\theta=1$이므로

​	$|\vec{c}|^2=|\vec{a}|^2-2|\vec{a}||\vec{b}|cos\theta+|\vec{b}|^2$

ii) 피타고라스 정리에 의해 $|\vec{c}|^2=(a_x-b_x)^2+(a_y-b_y)^2$이고,

​	따라서 $|\vec{c}|^2=a_x^2-2a_bb_x+b_x^2+a_y^2-2a_yb_y+b_y^2$이다.

iii) i)과 ii)을 조합하면

​	$a_x^2-2a_bb_x+b_x^2+a_y^2-2a_yb_y+b_y^2=|\vec{a}|^2-2|\vec{a}||\vec{b}|cos\theta+|\vec{b}|^2$

​	이때, $|\vec{a}|^2=a_x^2+a_y^2$이며, $|\vec{b}|^2=b_x^2+b_y^2$ 이므로

​	$a_x^2-2a_bb_x+b_x^2+a_y^2-2a_yb_y+b_y^2=a_x^2+a_y^2-2|\vec{a}||\vec{b}|cos\theta+b_x^2+b_y^2$

​	$-2a_bb_x-2a_yb_y=-2|\vec{a}||\vec{b}|cos\theta$

​	$-2(a_bb_x+a_yb_y)=-2(|\vec{a}||\vec{b}|cos\theta)$

​	$a_xb_x+a_yb_y=|\vec{a}||\vec{b}|cos\theta$



#### 1-2-5. 알아두면 좋은 내적 연산

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

### 1-3. Cross product 외적

### 1-4. Projection 투영(사영)

![](Asset\vector_projection.png)

$\vec{a}$를 $\vec{b}$에 **투영한 벡터의 길이**는

$|\vec{a_{proj}}|=|\vec{a}|cos\theta=\dfrac{(\vec{a}\bull\vec{b})}{|\vec{b}|}$ 와 같다.

이때, $\vec{b}$가 단위벡터라면

$|\vec{a_{proj}}|=(\vec{a}\bull\hat{b})$ 이다.



$\vec{a}$를 $\vec{b}$에 투영한 벡터는

$\vec{a_{proj}}=|\vec{a}|cos\theta\dfrac{\vec{b}}{|\vec{b}|}=\dfrac{(\vec{a}\bull\vec{b})\vec{b}}{|\vec{b}|^2}$ 와 같다.

이때, $\vec{b}$가 단위벡터라면

$\vec{a_{proj}}=(\vec{a}\bull\hat{b})\hat{b}$ 이다.





### 1-5. Frame change 기저 변경

![](Asset\frame_change.png)

위 그래프에서

벡터 $\vec{v_{xy}}$는 기저가 $\hat{x}=(1,0)$, $\hat{y}=(0,1)$일 때 $\vec{v_{xy}}=(3,5)$ 이다.

특정 기저에서 벡터의 좌표를 구하기 위해서는 해당 벡터를 기저 벡터에 투영하여 길이를 보면 된다.

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

$\hat{i}=(\dfrac{2}{\sqrt{5}},\dfrac{1}{\sqrt{5}})=(0.8944,0.4472)$ 이고

$\hat{j}=(-\dfrac{1}{\sqrt{5}},\dfrac{2}{\sqrt{5}})=(-0.4472,0.8944)$ 이다.

따라서 $\vec{v_{ij}}$에 대해

$v_i=\vec{v}\prime \bull \hat{i}$

$v_j=\vec{v}\prime \bull \hat{j}$

이고, 이를 행렬로 나타내면 다음과 같다.

$\vec{v_{ij}}=\vec{v} \prime M_{proj}=(v\prime_x,v\prime_y)\begin{bmatrix}i_x&j_x\\ i_y& j_y\end{bmatrix}=(1,3)\begin{bmatrix}0.8944&-0.4472\\ 0.4472& 0.8944\end{bmatrix}$

$=(1\times0.8944+3\times0.4472,1\times(-0.4472)+3\times0.8944)$

$=(0.8944+1.3416,-0.4472+2.6832)=(2.2236,2.2236)=(\sqrt{5},\sqrt{5})$



## 평면의 방정식

평면의 법선 벡터와 평면 위의 한 점을 알면 평면의 방정식을 구할 수 있다.

![plane](Asset\plane.png)



평면 위의 한 점 $A(x_0,\ y_0,\ z_0)$를 알고,
평면에 수직인 법선의 벡터 $\vec{h}(a,\ b,\ c)$가 주어졌을 때,
평면 위의 임의의 점 $P(x,\ y,\ z)$에 대해 $\vec{AP}\bull \vec{h}=0$이다.

이 때 $\vec{AP}=P-A$ 이므로 $(P-A)\bull{}\vec{h}=0$이다.

-> $(x-x_0,\ y-y_0,\ z-z_0)\bull (a,\ b,\ c)=0\\$
-> $a(x-x_0)+b(y-y_0)+c(z-z_0)=0\\$
-> $ax+by+cz+d=0\\$  (단, $d=-ax_0-by_0-cz_0$)

## 반직선의 방정식

반직선 $H$의 시작점을 $O$라 하고

이동 방향을 $D$라고 할 때,

반직선의 식은

$H=O+tD$와 같다. (단, $t>0$)



## 구의 방정식

$C$를 구의 중심에 있는 점

$r$을 구의 반지름이라고 할 때,

구 위의 임의의 점 $P=(P_x,\ P_y, P_z)$는

식 $(P_x-C_x)^2+(P_y-C_y)^2+(P_z-C_z)^2=r^2$을 만족한다.



## 구 그리기 (Sphere coordinates)

각도로 $\theta$ (theta)와 $\phi$ (phi)를 사용



## 2. 행렬 (왼손좌표계 기준)

### 2-1. 행렬의 계산

#### 2-1-1. 행렬의 덧셈

#### 2-1-2. 행렬과 벡터의 곱셈

왼손 좌표계에서는 행 벡터와 행렬을 곱하며, 그 계산은 다음과 같다.

![](Asset\matrix_mul.png)

즉,

$x\prime = xm_{00} + ym_{10} + zm_{20}$

$y\prime = xm_{01} + ym_{11} + zm_{21}$

$z\prime = xm_{02} + ym_{12} + zm_{22}$

이다.



### 2-2. 월드 행렬

#### 2-2-1. 이동 (Translation)

동차좌표계의 필요성 등장!!!

$T=\begin{bmatrix}1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 1 & 0 \\ t_x & t_y & t_z & 1\end{bmatrix}$

#### 2-2-2. 크기 (Scaling)

$S=\begin{bmatrix}s_x & 0 & 0 & 0 \\ 0 & s_y & 0 & 0 \\ 0 & 0 & s_z & 0 \\ 0 & 0 & 0 & 1\end{bmatrix}$

#### 2-2-3. 회전 (Rotation)

##### 2-2-3-1. 벡터 회전



점을 회전시키거나.. 기저를 반대 방향으로 회전시키거나!!



##### 2-2-3-2. 기저 회전

(기저 회전이 더 쉬울 수 있음...)



$R_x=\begin{bmatrix}1 & 0 & 0 & 0 \\ 0 & cos\theta & -sin\theta  & 0 \\ 0 & sin\theta  & cos\theta  & 0 \\ 0 & 0 & 0 & 1\end{bmatrix}$



##### 2-2-3-3. Pitch, Yaw, Roll

![](Asset\pitch_yaw_roll.png)



### 뷰 행렬

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



### 투영 행렬

#### 원근 투영 행렬(Perspective projection matrix)

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



#### 직교 투영 행렬(Orthographic projection matrix)

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





