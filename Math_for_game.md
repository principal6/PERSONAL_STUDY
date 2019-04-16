# 수학

## 1. 벡터

### 1-1. Dot product 내적

#### 1-1-1. 내적 계산 #1 (multiplication)

벡터 $\vec{a}​$가 $(a_x,\ a_y,\ a_z)​$이고

벡터 $\vec{b}​$가 $(b_x,\ b_y,\ b_z)​$이면

두 벡터의 내적은 $\vec{a}\bull\vec{b}​$와 같이 나타내고

 $\vec{a}\bull\vec{b}=a_xb_x+a_yb_y+a_zb_z​$과 같다



#### 1-1-2. 내적 계산 #2 (cos)

$$
\vec{a}\bull\vec{b}=|a||b|\cos\theta
$$

두 벡터가 단위벡터 (**정규화된 벡터)**인 경우 내적은 곧 두 벡터의 사이각의 cos과 같다!



#### 1-1-3. 알아두면 좋은 내적 연산

* $\vec{a}\bull\vec{b}+\vec{a}\bull\vec{c}=\vec{a}\bull(\vec{b}+\vec{c})​$
  * $\vec{a}\bull\vec{b}=a_xb_x+a_yb_y+a_zb_z$ 이고
  * $\vec{a}\bull\vec{c}=a_xc_x+a_yc_y+a_zc_z$ 이므로
  * $\vec{a}\bull\vec{b}+\vec{a}\bull\vec{c}=a_xb_x+a_yb_y+a_zb_z+a_xc_x+a_yc_y+a_zc_z$ 이다.
  * 식을 정리하면
  * $\vec{a}\bull\vec{b}+\vec{a}\bull\vec{c}=a_x(b_x+c_x)+a_y(b_y+c_y)+a_z(b_z+c_z)​$ 이다.
  * 따라서 $a_x(b_x+c_x)+a_y(b_y+c_y)+a_z(b_z+c_z)=\vec{a}\bull(\vec{b}+\vec{c})$ 이다.



* $\vec{a}\bull\vec{a}+2\vec{a}\bull\vec{b}+\vec{b}\bull\vec{b}=(\vec{a}\bull\vec{b})(\vec{a}\bull\vec{b})$
  * 



### 1-2. Cross product 외적



## 평면의 방정식

평면의 법선 벡터와 평면 위의 한 점을 알면 평면의 방정식을 구할 수 있다!

![평면](C:\Users\JesusKim\Desktop\수학 공부\평면.png)
$$
평면\ 위의\ 한\ 점\ A(x_0,\ y_0,\ z_0)를\ 알고,\\
평면에\ 수직인\ 법선의\ 벡터\ \vec{h}(a,\ b,\ c)가\ 주어졌을\ 때,\\
평면\ 위의\ 임의의\ 점\ P(x,\ y,\ z)에\ 대해\ \vec{AP}\bull \vec{h}=0이다.\\
\  \\
이\ 때\ \ \vec{AP}=P-A\ 이므로\ (P-A)\bull{}\vec{h}=0이다.\\
\rightarrow (x-x_0,\ y-y_0,\ z-z_0)\bull (a,\ b,\ c)=0\\
\rightarrow a(x-x_0)+b(y-y_0)+c(z-z_0)=0\\
\rightarrow ax+by+cz+d=0\\
(단,\ d=-ax_0-by_0-cz_0)
$$

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

