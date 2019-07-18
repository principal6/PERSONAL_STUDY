# Physics for game

<https://www.toptal.com/game/video-game-physics-part-i-an-introduction-to-rigid-body-dynamics>

## 뉴턴 운동 법칙 (Newton's laws of motion)

### 제1법칙: 관성의 법칙 (운동량 유지..)

물체의 질량 중심은 외부 힘이 작용하지 않는 한 일정한 속도로 움직인다.

### 제2법칙: 가속도의 법칙 $F=ma$

$F=ma$

($F$ = force, $m$ = mass, $a$ = acceleration)

 => $a=\dfrac{1}{m}F$

### 제3법칙: 작용과 반작용의 법칙



## 속도와 가속도

속도  $\vec{v}=\dfrac{\Delta x}{\Delta t} \begin{bmatrix}\dfrac{m}{s}\end{bmatrix}$

가속도 $\vec{a}=\dfrac{\Delta x}{\Delta t^2} \begin{bmatrix}\dfrac{m}{s^2}\end{bmatrix}$

속도의 변화 = 가속도의 적분 =>  $\vec{v}\prime=\vec{v}+\vec{a}t$

위치의 변화 = 속도의 적분 = 가속도의 적분의 적분 =>  $\vec{p}\prime=\vec{p}+\vec{a}t + \dfrac{1}{2}\vec{a}t^2$



## 운동량(momentum 모멘텀)

### Types of momentum

#### 1) Linear momentum 선형 모멘텀

**(Linear) momentum** $\vec{p}=m\vec{v}\ [kg\cdot m/s]$ ★

kinetic energy $k=\dfrac{1}{2}m\vec{v}^2$ (unit = $J$)



displacement $\Delta x = x_1 - x_0$

velocity  $\vec{v}=\dfrac{\Delta x}{\Delta t} \begin{bmatrix}\dfrac{m}{s}\end{bmatrix}$

acceleration $a=\dfrac{\Delta \vec{v}}{\Delta t}$

impulse $F\Delta t\ [N\cdot s]=\Delta p$



$F=ma$

=> $F=m\dfrac{\Delta \vec{v}}{\Delta t}$

=> $F\Delta t = m \Delta \vec{v}$

Impulse = $F\Delta t$



#### 2) Angular momentum (= rotational momentum)

**Angular momentum** $\vec{L}=I\vec{\omega}$

$I$ = moment of inertia 관성 모멘트 (rotational inertia)

$I=\sum{mr^2}$

$\vec{\omega}$ = angular velocity 각속도

속도

torque $\tau$ = torque 토크, 돌림힘

$\tau=I\alpha$

$\tau=rF\sin{\theta}$ 

- $r =$ 회전축에서 힘점까지의 직선 거리
- $\theta =$ $r$ 의 방향과 힘의 방향 사이의 각도
- $F\sin{\theta}=F_\perp$



angular displacement $\Delta \theta=\theta_1 - \theta_0$

angular velocity $\vec{\omega}=\dfrac{\Delta \theta}{\Delta t}\begin{bmatrix}\dfrac{rad}{sec}\end{bmatrix}$

angular acceleration $\vec{\alpha}=\dfrac{\Delta \vec{\omega}}{\Delta t}$

velocity  $\vec{v}=r\vec{\omega}$ ($r$ 은 회전축으로부터의 거리. 즉 회전 원의 radius)

angular impulse = $\tau \times \Delta t$

## 관성 모멘트 Moment of inertia

$\displaystyle I=\sum_{i=1}^{n}m_ir_i^2=\int r^2dm$



### 질량, 면적, 부피 관계★

 $\dfrac{dm}{M}=\dfrac{dA}{A}=\dfrac{dV}{V}$ 

#### 질량 - 면적

$dm=\dfrac{M}{A}dA$

#### 질량 - 부피

$dm=\dfrac{M}{V}dV$

이때, 밀도 $\rho=\dfrac{M}{V}$이므로

$dm=\rho dV$ (단, 밀도 $\rho$는 상수이다.)



### 2차원 고리(ring)

![](Asset\intertia_ring.png)

위 그림에서 $\dfrac{1}{24}=\dfrac{m_i}{M}=\dfrac{l_i}{L}$ 이다.

$\displaystyle I=\sum_{i}^{n}m_ir_i^2$ 인데

$r_i = R$ 로 상수이므로

$\displaystyle I=R^2\sum_{i}^{n}m_i$

이때 $\displaystyle \sum_{i}^{n}m_i=M$ 이므로

$I=MR^2$



### 2차원 원판(disk)

반지름이 $R$인 원판에서

회전축에서 떨어진 거리가 $l$이고 두께가 $dl$인 고리의 면적 $dA$는

$dA=\pi (l+dl)^2 - \pi l^2 $

​       $= \pi(l^2 + 2l \cdot dl + dl^2 - l^2)$

​       $= \pi(2l \cdot dl + dl^2)$

​       $= 2\pi l \cdot dl$

와 같다.

이때 $A=\pi R^2$ 이고 $\dfrac{dm}{M}=\dfrac{dA}{A}$ 이므로

$dm=M\dfrac{2 \pi l \cdot dl}{\pi R^2}$

$dm=M\dfrac{2l \cdot dl}{R^2}$

$\displaystyle I = \int l^2dm = \int l^2 M\dfrac{2l \cdot dl}{R^2}$

$\displaystyle I=\dfrac{M}{R^2}\int l^2 2l \cdot dl$

$\displaystyle I=\dfrac{M}{R^2}\int 2l^3 \cdot dl$

$I=\dfrac{M}{R^2}\left[ \dfrac{1}{2}l^4 \right]_0^R$

$I=\dfrac{M}{R^2}\left( \dfrac{1}{2}R^4 - 0 \right)$

$I=\dfrac{1}{2}\dfrac{M}{R^2}R^4$

$I=\dfrac{1}{2}MR^2$



### 2차원 막대(rod)



### 3차원 원기둥(cylinder)

![](Asset\inertia_cylinder.png)

$\displaystyle I = \int r^2dm$

이때 $dm=\rho dV$ 이므로

$\displaystyle I=\int r^2\rho dV$

원기둥의 부피 $V = \pi R^2 L$ 이고

축과의 거리가 $r$, 두께가 $dr$ 인 원기둥의 부피 $dV$ 는

$dV=\pi (r+dr)^2L - \pi r^2L$

$dV=\pi (r^2+2rdr+dr^2)L - \pi r^2L$

$dV=\pi L (r^2+2rdr+dr^2-r^2)$

$dV=\pi L (2rdr+dr^2)$

$dV=2 \pi L rdr$

와 같다.



$\displaystyle I=\int r^2\rho 2 \pi L rdr$

$\displaystyle I=2 \pi \rho L \int r^3 dr$

$\displaystyle I=2 \pi \rho L \left[\dfrac{1}{4}r^4 \right]_0^R$

$\displaystyle I=2 \pi \rho L \dfrac{R^4}{4}$

$\displaystyle I=\dfrac{1}{2} \pi \rho L R^4$

이때 $\rho=\dfrac{M}{V}$ 이고, $V = \pi R^2 L$ 이므로

$\displaystyle I=\dfrac{1}{2} \pi \dfrac{M}{\pi R^2 L} L R^4$

$\displaystyle I=\dfrac{1}{2}MR^2$



### 3차원 육면체(box)

### 3차원 원뿔(cone)

### 3차원 구(sphere)



## 관성 텐서 -> 관성 모멘트

From inertia tensor to scalar moment of inertia

임의의 축 $\hat{n}$에 대한 관성 모멘트 $I_n$은

$I_n = \hat{n} I\hat{n}^T$ 와 같다.



## Density 물체의 밀도

$\rho = \dfrac{m}{V}$  ($m$ 은 질량, $V$ 는 부피)



## Rigid body 강체

현실에는 **완벽한 강체(rigid body)**는 존재하지 않는다. 어떤 물체든 힘이 가해지면 변형이 일어나기 때문!

### 강체의 회전

축을 따로 고정하지 않은 강체는 **질량 중심(center of mass)**을 기본 축으로 회전한다.

![](Asset\motion_linear_angular.png)

물체에 가해진 힘이 질량 중심과 동일선상에 있을 때에는 회전 운동은 생기지 않고, 선형 운동만 생긴다.

힘이 질량 중심을 지나지 않는 경우에는 회전 운동과 선형 운동이 모두 발생한다.



### 선충격량 (linear impulse)

$\vec{F}=m\vec{a}$ 에서

선충격량은 $\vec{g}=m\vec{v}$ 이다.

 -> $\vec{v}=\dfrac{1}{m}\vec{g}$

 -> $\vec{v}\prime=\vec{v}+\dfrac{1}{m}\vec{g}$



### 각충격량 (angular impulse) = 충격 토크 ★★

힘이 발생시키는 토크는

$\vec{\tau} = r \times \vec{F}$ 이므로

선충격량이 발생시키는 각충격량은 다음과 같다.

$\vec{u}=r\times\vec{g}$

이때 $\vec{\tau}=I\vec{\alpha}$ 이고

이때 $\vec{u}=I\vec{\omega}$ 이므로 $\vec{\omega}=I^{-1}\vec{u}$ 이다.



## 충돌 Collision

### 충돌 검출 Collision detection

coarse collision detection / fine collision detection



### 충돌 처리

충돌 전후 운동량(momentum)은 보존된다.

$m_a\vec{v_a}+m_b\vec{v_b}=m_a\vec{v\prime_a}+m_b\vec{v\prime_b}$

$m_a\vec{v_a}-m_a\vec{v\prime_a}=m_b\vec{v\prime_b}-m_b\vec{v_b}$

$-m_a(\vec{v\prime_a}-\vec{v_a})=m_b(\vec{v\prime_b}-\vec{v_b})$

$-m_a\Delta\vec{v_a} = m_b\Delta\vec{v_b}$



만약 $m_a$가 무한대라면? $\vec{v_a}=\vec{0}$, $\vec{v\prime_a}=\vec{0}$

$m_b\vec{v_b}=m_b\vec{v\prime_b}$ => $\vec{v_b}=\vec{v\prime_b}$ ????







$s_c=-(\vec{v_a}-\vec{v_b})\bull(\hat{d_{ba}})$

$s\prime_c=-rs_c$

$=-(r_a\vec{v_a}-r_b\vec{v_b})\bull(\hat{d_{ba}})$

$=(-r_a\vec{v_a}+r_b\vec{v_b})\bull(\hat{d_{ba}})$

$=   (\vec{v\prime_a}-\vec{v\prime_b})\bull(\hat{d_{ba}})$



### 접근 속도 closing speed (b to a?)

$s_c=\vec{v_b}\bull\hat{d_{ba}}-\vec{v_a}\bull\hat{d_{ba}}$  (단, $\vec{d_{ba}}=\vec{p_a}-\vec{p_b}$)

$s_c=-(\vec{v_a}-\vec{v_b})\bull(\hat{d_{ba}})$

$s_s=-c_rs_c$ (closing speed, coefficient of restitution) $c_r$이 1이면 **완전 탄성 충돌**

분리속도 $s_s=(\vec{v_a}-\vec{v_b})\bull(\hat{d_{ba}})$



**※ 접근 속도가 가장 빠른 충돌부터 해결하는 것이 효율적!!**

