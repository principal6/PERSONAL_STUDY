# 수학

## 1. 벡터

### 1-1. Dot product 내적

#### 1-1-1. 내적 계산 #1 (원소의 곱)

벡터 $\vec{a}$가 $(a_x,\ a_y,\ a_z)$이고

벡터 $\vec{b}$가 $(b_x,\ b_y,\ b_z)$이면

두 벡터의 내적은 $\vec{a}\bull\vec{b}$와 같이 나타내고 그 계산은 다음과 같다.
$$
\vec{a}\bull\vec{b}=a_xb_x+a_yb_y+a_zb_z
$$
즉, 내적의 결과는 **벡터**가 아니라 **스칼라** 값이다!!



#### 1-1-2. 내적 계산 #2 (삼각함수)

$$
\vec{a}\bull\vec{b}=|a||b|\cos\theta
$$

두 벡터가 단위벡터 (**정규화된 벡터)**인 경우 내적은 곧 두 벡터의 사이각의 cos과 같다!

다시 한 번, 내적의 결과는 **벡터**가 아니라 **스칼라** 값이다!



#### 1-1-3. 내적 계산 #3 (결론)

$$
\vec{a}\bull\vec{b}=a_xb_x+a_yb_y+a_zb_z=|a||b|\cos\theta
$$



#### 1-1-4. 내적 계산 증명

* 피타고라스의 정리 삼각함수 버전: $\sin^2\theta+\cos^2\theta=1$

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

​	$a_bb_x+a_yb_y=|\vec{a}||\vec{b}|cos\theta$



#### 1-1-5. 알아두면 좋은 내적 연산

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

### 1-2. Cross product 외적



## 평면의 방정식

평면의 법선 벡터와 평면 위의 한 점을 알면 평면의 방정식을 구할 수 있다!

![math_plane](Asset\math_plane.png)



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