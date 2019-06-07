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

## 관성 모멘트

$\displaystyle I=\sum_{i=1}^{n}m_ir_i^2$

## 중력과 토크

★참고★ 토크 $\tau = rF$

중력가속도 $g = 9.8 m/s^2$ 

중력 힘 $G = mg$

중력 토크 $T = rG=I\alpha$

중력 각가속도 $\alpha = I^{-1}T$



## Density 물체의 밀도

$\rho = \dfrac{m}{V}$  ($m$ 은 질량, $V$ 는 부피)



## Rigid body 강체

현실에는 **완벽한 강체(rigid body)**는 존재하지 않는다. 어떤 물체든 힘이 가해지면 변형이 일어나기 때문!

### 강체의 회전

축을 따로 고정하지 않은 강체는 **질량 중심(center of mass)**을 기본 축으로 회전한다.

![](Asset\motion_linear_angular.png)

물체에 가해진 힘이 질량 중심과 동일선상에 있을 때에는 회전 운동은 생기지 않고, 선형 운동만 생긴다.

힘이 질량 중심을 지나지 않는 경우에는 회전 운동과 선형 운동이 모두 발생한다.



## 충돌 검출 Collsion detection

Broad-phase: bounding sphere??