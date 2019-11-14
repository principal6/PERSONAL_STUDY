# Computer Graphics

## 수학

### 기저 함수 basis function

### 편미분

함수 $f(x, y)$ 에 대해

매개변수 $x$ 로만 미분하는 것을 편미분이라고 하며

편도함수(partial derivate)는 $\dfrac{\partial f}{\partial x}$ 와 같다.

이 편도함수 $\dfrac{\partial f}{\partial x}$ 를 다시 $y$ 에 대해 미분하면

이계 편도함수 (second-order partial derivative) $\dfrac{\partial^2 f}{\partial x \partial y}$ 가 된다.

### solid angle 입체각 (단위: steradian == sr, 기호 $\Omega$)

 => $\Omega=\dfrac{A}{r^2}$

​      ($A$는 구 위의 면적, $r$은 구의 반지름)

 => 즉, $A=r^2$ 일 때 $\Omega=1 \ \mathrm{sr}$ 이다.

​      예를 들어 $A=x$ 이면 $\Omega=\dfrac{x}{r^2}$ 이다.

 => 구의 전체 면적은 $4 \pi r^2$ 이므로 구 전체 면적에 대한 입체각은

​       $\Omega_{max}=\dfrac{4 \pi r^2}{r^2}=4 \pi \ \mathrm{sr}$ 이다.

### dirac delta function



## 과학

### work 일 (단위: $J$)

$J=Nm$

  $J$ : joule 줄

 $N$ : Newton 뉴턴

 $m$ : meter 미터

### energy 에너지

와트 ($W=\dfrac{J}{s}$)

## Radiometry 복사 측정학

출처:  https://www.physics-in-a-nutshell.com/article/20/what-is-radiometry 

 http://www.pbr-book.org/3ed-2018/Color_and_Radiometry/Radiometry.html 

### electromagnetic wave 전자기파

진공 중 전자기파의 속도 $c$ 는 상수로,

$c=3.0 \times 10^8 m/s$ 이다.

이때 $c=v\lambda$ 이다.

  => $v$ : 진동수

​       $\lambda$ : 파장

### photon 광자

광자의 에너지 $E$ 는 진동수 $v$에 대해 **플랑크(Planck) 상수** $h$ 만큼 비례한다.

$E=hv=\dfrac{hc}{\lambda}$



### radiation

Radiation refers to energy that is transported by means of photons/electromagnetic waves



### radiant energy

전자기파의 에너지  energy of electromagnetic waves 

$Q_e=\dfrac{hc}{\lambda}$

$h$ 플랑크 상수

$c$ 빛의 속력 상수

$\lambda$ 파장

 => 사실 우리는 이 파장 중에 가시광선 파장 (약 380nm ~ 770 nm)만 신경쓰면 된다



### Spectral Power Distribution (SPD)



### ★ radiant flux (= radiant power, 복사 출력 = 복사속, 단위: $W$ 표기: $\Phi_e$)

#### 단위 시간 당 방출되는 전자기파 에너지의 양

![flux](Asset\radiant_flux.png)

$\displaystyle \Phi_e = \lim_{\Delta t \rightarrow 0}\dfrac{\Delta Q}{\Delta t} = \dfrac{\partial Q_e }{\partial t}$ (렌더링 관점에서...★)



  => 어떤 광원이 1시간 동안 총 $200,000W$의 에너지를 방출했고, 단위 시간 당 방출되는 에너지의 양이 일정했다면 (즉, 상수였다면) 이때 광원의 복사 출력은 다음과 같다.

​       $\Phi_e=\dfrac{200,000J}{3,600s} \approx 55.6 W$



만약 $\Phi_e$ 가 시간에 대한 함수로 주어지면

반대로

$\displaystyle Q_e=\int_{t_0}^{t_1}{\Phi_e \mathrm{d} t}$  이다.



### irradiance (복사 조도, 표기: $E_e$)

#### ★단위 면적($\mathrm{m^2}$) 당 표면이 받는 복사 출력의 양

  => 면적이 달라져도 irradiance는 그대로다!★



$E_e=\dfrac{\Phi_e}{\Omega r^2}$

![irradiance](Asset\irradiance.png)

점광원일 때 (입체각이 $\Omega = 4 \pi$ 일 때) 복사 조도는

$E_e=\dfrac{\Phi_e}{4\pi r^2}$ 와 같다.

  => 반지름이 $r$ 인 구의 표면적은 $4 \pi r^2$ 이다.

  => 즉, 입체각이 $\Omega = 4 \pi\mathrm{sr}$ 일 때, 구의 면적이 $A = 4 \pi r^2\mathrm{m^2}$ 이므로

​       단위 면적 $\mathrm{1 m^2}$ 당 복사 출력을 구하기 위해서는 $\dfrac{1}{4 \pi r^2}$  을 곱해야 한다!

​       (단위 면적일 때 입체각은 $\Omega=\dfrac{1}{r^2}\mathrm{sr}$ 이다!)

  **=> 거리가 멀어지면 빛은 거리의 제곱에 반비례하여 감쇠(attenuation)하는데, 그 이유가 여기 있다!**

복사 조도가 주어졌을 때 복사 출력은

$\displaystyle \Phi_e = \int_A E_e(\bold{x})dA$ 와 같다.





### radiant intensity (복사 강도, 표기: $I_e$)

#### 단위 입체각 당 복사 출력

복사 출력 $\Phi_e$ 가 주어졌을 때, 단위 입체각 당 복사 출력은

 $I_e=\dfrac{\Phi_e}{4 \pi}$ 와 같다.



![radiant_intensity](Asset\radiant_intensity.png)

빛의 복사 강도를 단위 입체각이 아니라 하나의 광선에 대해서 구하면

$I_e=\dfrac{\partial \Phi_e}{\partial \Omega}$ 와 같다.

  => $\Omega$ : 입체각

![radiant_intensity_partial](Asset\radiant_intensity_partial.png)



★복사 강도가 주어졌을 때 복사 출력은

$\displaystyle \Phi_e=\int_\Omega I_e d\Omega$ 이다.



### ★★ radiance (복사 휘도, 표기: $L_e$) ★★

(빛의 방향에 수직인) 단위 면적 당 표면에서 단위 입체각으로 방사되는 복사 출력의 양

  => 거리가 멀어져도 (즉, 면적이 달라지고 입체각이 달라져도) radiance는 달라지지 않는다!★

$L_e = \dfrac{d^2 \Phi_e}{ d\Omega dA_{\perp}}$

  => $\Omega$ : 입체각

  => $A_{\perp}$ : (단위 구로) 투영되었고, 광선에 수직인 면적

​       이때 $A_{\perp}=A\cos\theta$  이다.

![sphere_area_projection](Asset\sphere_area_projection.png)

  => 따라서 $L_e = \dfrac{d^2 \Phi_e}{ d\Omega dA\cos\theta}$ 이다.



이때 $L_ed\Omega dA\cos\theta = d\Phi_e$ 이다

  => $\displaystyle \Phi_e=\int_{A}\int_{\Omega}L_e(\bold{x}, \Theta)dA\cos\theta d\Omega$  

  => $\displaystyle d\Phi_e = dA\int_{\Omega}L_e(\bold{x}, \Theta)\cos\theta d\Omega$  



 $\displaystyle \Phi_e=\int_{A}\int_{\Omega}L_e(\bold{x}, \Theta)dA\cos\theta d\Omega$  

(L_e는 )







## 공통 용어

### attenuation 감쇠

거리가 멀수록 빛의 양이 줄어든다..! 거리의 제곱에 반비례해서

### index of refraction (IOR) 굴절율? 굴절지수?

matt = mat = matte 무광



## Photometry 측광학

### luminous flux (광속 光束, 단위: lumen == lm, 표기 $\phi_v$) 

#### 단위 시간 당 광원에서 방출되는 빛의 양. 즉, 방향에 관계 없이★ 방출되는 빛의 총량!

**광속은 '빛의 묶음'이다. 속도가 아니라 속수무책 할 때 '속'!**

 =>  $\phi_v\ \ =\ I_v \ \ \times \ \Omega$ 

​       $[lm] = [cd] \times [sr]$ 



### luminous intensity (광도, 단위: candela == cd, 표기: $I_v$)

#### 특정 방향으로 단위 입체각($\mathrm{sr}$) 당 방출되는 광속($\phi$)의 양. (즉, 모든 방향을 고려하는 게 아니고 딱 한 방향(직선)만 고려하는 것이다 ★★)

​      $I_v=\dfrac{\phi_v}{\Omega}$

​      **( 촛불 하나의 광도 = 1 candela )**

​      ( 촛불은 점 광원의 대표적인 예 )



촛불과 같은 **점 광원**은 빛을 **전방향**(구체)으로 방출하므로 방출되는 빛의 **입체각**은 $\Omega = 4\pi \ \mathrm{sr}$ 이다. 

따라서 점 광원의 **광도**는 $I_v = \dfrac{\phi_v}{4 \pi}$  이고,

점 광원의 **광속**은 $\phi_v=I_v \times 4 \pi$ 이다.

  ( 따라서 촛불 하나의 **광속**은 $\phi_v=4 \pi \quad \approx (12.57\ \mathrm{lm})$ 이다. )



### illuminance 조도 (단위: lux, 표기: $E_v$)

#### 단위 면적($\mathrm{m^2}$) 당 표면에 입사되는 광속(lm)의 양

  => $E_v \quad =\  \dfrac{\phi_v}{A}$

​        $\mathrm{[lux]\  =\dfrac{[lm]}{[m^2]}}$



#### 램버트 코사인 법칙 (Lambert's cosine law)

기울기에 따라 조도의 양이 달라지는 것을 계산한다.

기울기 $\theta$에 대해 조도 $E_v$ 는 $cos\theta$ 에 비례한다.



#### 점광원의 조도

점광원의 광도는  $I_v=\dfrac{\phi_v}{4 \pi}$ 이고, 광속은 $\phi_v= 4 \pi I_v$ 이다.

이때 조도 $E_v=\dfrac{\phi_v}{A}$ 인데,

구의 전체 면적은 $4 \pi r^2$ 이므로

$E_v=\dfrac{4 \pi I_v}{4 \pi r^2}$ 이다.

즉, $E_v=\dfrac{I_v}{r^2}$ 이다.

$I_v$를 다시 바꿔 쓰면

$E_v=\dfrac{\phi_v}{4 \pi r^2}$ 이다.

램버트 코사인 법칙에 따라 조도 $E_v$는 기울기 $\theta$ 에 대해 $cos\theta$ 에 비례하므로

점광원의 조도는 $E_v=\dfrac{\phi_v \cos\theta}{4 \pi r^2}$ 이다.



### luminance 휘도 (표기: $L_v$)

####   단위 면적($\mathrm{m^2}$) 당 물체 표면에서 주어진 방향으로 방사되는 광도($\mathrm{cd}$)의 양

  => 단위 면적 ($\mathrm{m^2}$) 당 (방사되는) 광도($\mathrm{cd}$)의 양.



### scattering 산란: 전자기파가 기존과 다른 방향으로 움직임

#### transmission 투과

 cf) transmittance 투과율

#### absorption 흡수

#### reflectance 반사 == diffuse reflection + specular refelction

 => albedo는 [0, 1]의 값을 가지며, 0일 경우 모든 입사광을 흡수, 1일 경우 모든 입사광을 반사한다는 뜻이다. (단위 면적 당 광속이 반사되는 양?)

### light (source) 광원

#### punctual light 점 광원

#### area light 영역 광원



**(texture) splatting 여러 레이어의 텍스쳐를 결합!**

participating medium 참여 매질



(light) emission (빛의) 방출

optical depth 광학적 깊이



**LUT (Look-Up Texture)**

Image Based Lighting ★



### Spherical Harmonics (SH)

출처:  https://computergraphics.stackexchange.com/questions/4164/what-are-spherical-harmonics-light-probes/4166

 https://en.wikipedia.org/wiki/Table_of_spherical_harmonics#Real_spherical_harmonics 

Fourier transform의 구(Sphere) 버전

polar functions $f(\theta,\phi)$



## Light propagation 빛의 전파

특정 참여 매질에 대한 빛의 전파는 산란(scattering), 흡수(absoprtion), 방출(emission)으로 설명된다.

각각의 계수는 $\beta_\mathrm{Sc}$, $\beta_\mathrm{Ab}$, $\beta_\mathrm{Em}$ 로 나타낸다.

광 소멸(light extinction) 계수는

$\beta_\mathrm{Ex}=\beta_\mathrm{Sc}+\beta_\mathrm{Ab}$ 과 같다. (흡수와 산란으로 인한 에너지 손실을 의미한다.)

### 광학적 깊이 (optical depth)

광학적 깊이 $\tau$ 는

두 지점 $\bold{P_0}$, $\bold{P_1}$ 사이의 광 소멸 계수 $\beta_\mathrm{Ex}$를 거리에 대해 적분한 것과 같다.

$\displaystyle \tau(\bold{P_0,P_1})=\int_A^B{\beta(\bold{P})ds}$

이때, $\bold{P}=\bold{P_0}+\bold{r}s$ 이고,

$\displaystyle \bold{r}=\dfrac{\bold{P_1-P_0}}{\|\bold{P_1-P_0}\|}$ , $s$는 $\bold{P_0}$과 $\bold{P}$ 사이의 거리이다.

광학적 깊이가 $\tau$인 매질을 지나는 빛은 그 세기가 $e^{-\tau}$ 의 곱만큼 줄어든다.



## PBR (Physically Based Rendering, 물리 기반 렌더링)

참고:  https://learnopengl.com/PBR/Theory

PBR 기술은 모두 미세면 이론(Microfacet theory)에 기반을 둔다.

### Microfacet theory (미세면 이론)

미세면 이론에서는 모든 표면(surface)이 아주 가까이서 살펴보면 작은 거울(완전 평평하고, 빛을 반사만 시킨다)로 이루어져 있다고 여긴다.

표면이 거칠면(rough) 이 작은 면들이 들쑥날쑥하게 배치되어 있는 것이고, 표면이 부드러우면(soft) 평평하게 배치되어 있는 것이다.



금속은 refracted lights를 전부 다 흡수해버린다!



가시광선은 보통 파장(wavelength)이 400 ~ 700 nm이다!

spectral power distribution (SPD)

index of refraction (IOR)

 => 매질을 지나는 빛의 속도 & 매질이 흡수하는 빛의 양



### rendering equation ★

$L$ radiance

$L_i$ 

$L_e$ 

$L_o$ outgoing light

$\displaystyle L_o(\bold{x},\ \omega_o, \lambda, t) = L_e(\bold{x},\ \omega_o, \lambda, t) + \int_{\Omega}{f_r(\bold{x}, \omega_i, \omega_o, \lambda, t) L_i(\bold{x}, \omega_i, \lambda, t) (\omega_i \cdot n) d\omega_i}$

   $\bold{x}$ : 공간 내 위치

   $\bold{n}$ : $\bold{x}$의 표면 법선

   $\lambda$ : 파장(wavelength)

​    $t$ : 시간

   $\Omega$ : 단위 반구(hemisphere)

   $\omega_i$ : 입사되는 빛의 방향

   $\omega_o$ : 반사?되는 빛의 방향

   $f_r(\bold{x}, \omega_i, \omega_o, \lambda, t)$ : BRDF



파장과 시간을 무시?

$L_o(\bold{x},\ \omega_o) = L_e(\bold{x},\ \omega_o) + L_r(\bold{x},\ \omega_o)$

  => $L_e(\bold{x}, \omega_i)$ 방출된 빛의 양

​       $L_r(\bold{x}, \omega_i)$ 반사된 빛의 양

$\displaystyle L_r(\bold{x},\ \omega_o) = \int_{\Omega}{f_r(\bold{x}, \omega_i, \omega_o) L_i(\bold{x}, \omega_i) (\omega_i \cdot n) d\omega_i}$

  => 이때 $\theta_i$ 을 입사각이라 두면 $\omega_i \cdot n = \cos\theta_i$ 이다.





### BRDF (Bidirectional Reflectance Distrubution Function)

 http://graphicrants.blogspot.com/2013/08/specular-brdf-reference.html 

BDRF 종류에는 여러 개가 있다...



$f(l,v) = k_d f_{diff} + k_s f_{spec}$ 

  => $k_d + k_s = 1$ (각각 재질의 diffuse 색상과 specular 색상이다. 두 색상이 다를 수 있음!)

  => 금속일 경우 $k_d=0$ 이어야 한다! (금속은 specular만!)

diffuse는 그냥 Lambert 사용해도 될 거 같다... 다른 모델들이랑 겉보기에 크게 차이가 없어서!



$f_{diff}(l,v)=\dfrac{\rho_d}{\pi}$

 => 빛이 반사되는 방향에 상관 없이 상수..!

 => $\rho_d$ 는 diffuse albedo (r, g, b) 

 => 에너지 보존법칙을 지키기 위해 $\pi$ 로 나눠야 한다.





$f_{spec}(l, v) = \dfrac{F(l, h)G(l, v, h)D(h)}{4(n \cdot l)(n \cdot v)}$



#### $F(l,h)$, Fresnel reflectance function

 https://docs.unrealengine.com/en-US/Engine/Rendering/Materials/PhysicallyBased/index.html 

$F(l,h)$ = fresnel reflectance (반사된 입사광 양 : 굴절된 입사광 양) 

=> 미세면은 모두 거울이므로 굴절을 무시한다!

=> 즉, 미세면에 충돌한 빛 중 몇 퍼센트의 빛이 반사되는가? 를 말해준다.

=> 입사각이 90도에 가까워질 때에만 급격하게 변화하고, 0~50도까지는 상수에 가까울 정도로 변화가 거의 없다..!

![Fresnel_Reflectance](Asset/Fresnel_Reflectance_Naty Hoffman.png)

=> 0도에서 50도까지는 0도일 때 값 $F(0^\circ)$ 을 상수로 사용하자!

=> $F_0=F(0^\circ)$

=> 이게 바로 재질의 specular color(정반사 색상?)이다.

금속의 경우 이 값이 대체로 높고, 비금속(dielectric)의 경우 (그레이 스케일로) 굉장히 낮다...

![PBS_65](Asset/SIGGRAPH2015_PBS_Physics and Math of Shading_Naty_Hoffman_65.png)

![PBS_66](Asset/SIGGRAPH2015_PBS_Physics and Math of Shading_Naty_Hoffman_66.png)

비금속의 경우 다이아몬드가 흔하지는 않으므로... 대부분 4%정도의 $F_0$ 값을 갖는다고 생각할 수 있으므로 단순화할 수 있다.

50도 이후에 변화가 있는 부분은 이를 approximate할 함수를 정의해야 한다

=> $F_{Schlick}$ 를 사용하면 0~90도 전체를 함수화할 수 있다.

##### Schlick Fresnel approximation...

 $F_{Schlick}$은 $F_0$을 매개변수로 받는 함수로,

 => $F_{Schlick}(F_0, l, n)=F_0+(1-F_0)(1-l \cdot n)^5$

​     ($l \cdot n = 0,\ \mathrm{where}\ \ n \cdot l<0$)

 와 같이 정의된다.

미세면 이론에서는 n이 미세면의 법선인 m이고, 이 중에 눈에 들어오는 빛은 m = h일 때이므로

 $F_{Schlick}(F_0, l, h)=F_0+(1-F_0)(1-l \cdot h)^5$

​     ($l \cdot h = 0,\ \mathrm{where}\ \ n \cdot h<0$)

 $F_{Schlick}(F_0, l, h) = \begin{cases} F_0+(1-F_0)(1-l \cdot h)^5 \\ F_0+(1-F_0) \end{cases}$

와 같이 정의할 수 있다.

(l과 h가 같다면, 즉 입사각이 0도라면 $l \cdot h=0$ 이므로 $F_0$임을 확인할 수 있다!)



#### $D(h)$, Normal distribution function (NDF)

$D(h)$, Normal distribution function은

총 미세면 중 얼만큼의 미세면이 눈을 향하고 있는가?를 알려준다.

Phong NDF, Blinn-Phong NDF, Beckmann NDF, Trowbridge-Reitz NDF(== GGX NDF) 등등

##### Beckmann NDF

$\Lambda(a) \approx \begin{cases}{} \dfrac{1-1.259a+0.396a^2}{3.535a+2.181a^2}, & (a < 1.6) \\ 0, & (a \ge 1.6) \end{cases}$



##### GGX (Trowbridge-Reitz) NDF ★

$D(h)=\begin{cases} \dfrac{\alpha^2}{\pi(1+(n \cdot h)^2(\alpha^2 -  1))^2} & \text{where } n \cdot h>0 \\ 0 & \text{else} \end{cases}$

  => $n$ 은 macrofacet의 법선..?

​       $\alpha$ 는 표면의 거침(roughness)을 나타내는 매개변수로,

​       $\alpha = r^2$로 두고 $r$을 0에서 1사이의 선형 값으로 지정하는 것이 좋다



GGX NDF는 shape-invariant이므로 람다 함수가 단순하다

 => $\Lambda(a) = \dfrac{-1+\sqrt{1+\frac{1}{a^2}}}{2}$

 이때, $a=\dfrac{n \cdot s}{\alpha\sqrt{1-(n \cdot s)^2}}$ 이다. (s는 l 또는 v이다.)

 

#### $G(l, v, h)$ Geometry function

shadowing masking function이라고도 불린다

전체 미세면 중 가리거나 그늘지지 않은 미세면(즉, 눈에 빛을 반사시키는) 미세면의 비율이다.

물리적으로는 미세면의 법선이 halfway vector여도 가려지거나(masked) 그늘지면(shadowed) 빛이 눈까지 오지 못할 수도 있고, 올 수도 있다...!!

여러 함수가 있지만 Smith G 함수가 제일 수학적으로/물리적으로 괜찮은 듯? (by Eric Heitz)

##### Smith masking function ★

$G_2(l, v, n) = G_{1}(n,l)G_{1}(n,v)$

 => $G_1$은 단방향에 대한 가시성(visibility)이다.

​       $G_2$는 양방향에 대한 가시성!

 => $G_1(s) = \dfrac{n \cdot s}{(n \cdot s)(1-\alpha) + \alpha}$ (s는 l 또는 v이다.)

###### 근사치

 => $G_1(s) \approx \dfrac{2(n \cdot s)}{(n \cdot s)(2-\alpha) + \alpha}$ (s는 l 또는 v이다.)

 => $G(l,v,n) \approx \dfrac{2(n \cdot l)}{(n \cdot l)(2-\alpha) + \alpha} \times \dfrac{2(n \cdot v)}{(n \cdot v)(2-\alpha) + \alpha}$

 => $\dfrac{G(l, v, n)}{4|n \cdot l||n \cdot v|} \approx \dfrac{0.5}{lerp(2|n \cdot l||n \cdot v|, |n \cdot l| + |n \cdot v|, \alpha)}$



Specular roughness보다 Diffuse roughness가 훨씬 덜 정교하고, 변화가 덜하다

