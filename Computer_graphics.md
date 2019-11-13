## 용어

Luminance 휘도: 특정 방향(각도)에서 단위 면적 당 빛의 양

 -> 명암..?

scattering (빛) 산란 (광자의 방향이 바뀜!)

(texture) splatting 여러 레이어의 텍스쳐를 결합!

participating medium 참여 매질

absorption 흡수

(light) emission (빛의) 방출

optical depth 광학적 깊이

transmittance 투과율

**radiance 복사 휘도** (single ray에 대한 빛의 강도)

**LUT (Look-Up Texture)**



## light propagation 빛의 전파

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



### BRDF (Bidirectional Reflectance Distrubution Function)

BDRF 종류에는 여러 개가 있지만...

Microfacet theory 에서 사용하는 BRDF는?

물리적으로는 미세면의 법선이 halfway vector여도 가려지거나(masked) 그늘지면(shadowed) 빛이 눈까지 오지 못할 수도 있고, 올 수도 있다... 미세면 이론에서는 이 경우 눈까지 오는 빛이 아예 없다고 가정한다!



$f(l,v)=f_{diff}+f_{spec}$

diffuse는 그냥 Lambert 사용해도 될 거 같다... 다른 모델들이랑 겉보기에 크게 차이가 없어서!

 => $f_{diff}(l,v)=\dfrac{k_d}{\pi}$

​      ($k_d$ 는 albedo 색상값이다.) 



$f_{spec}(l, v) = \dfrac{F(l, h)G(l, v, h)D(h)}{4(n \cdot l)(n \cdot v)}$



#### $F(l,h)$, Fresnel reflectance function

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

 $F_{Schlick}$은 $F_0$을 매개변수로 받는 함수로,

 => $F_{Schlick}(F_0, l, n)=F_0+(1-F_0)(1-l \cdot n)^5$

​     ($l \cdot n = 0,\ \mathrm{where}\ \ n \cdot l<0$)

 와 같이 정의된다.

미세면 이론에서는 n이 미세면의 법선인 m이고, 이 중에 눈에 들어오는 빛은 m = h일 때이므로

 $F_{Schlick}(F_0, l, h)=F_0+(1-F_0)(1-l \cdot h)^5$

​     ($l \cdot h = 0,\ \mathrm{where}\ \ n \cdot h<0$)

와 같이 정의할 수 있다.

(l과 h가 같다면, 즉 입사각이 0도라면 $l \cdot h=0$ 이므로 $F_0$임을 확인할 수 있다!)

#### $D(h)$, Normal distribution function (NDF)

$D(h)$, Normal distribution function은

총 미세면 중 얼만큼의 미세면이 눈을 향하고 있는가?를 알려준다.

Phong NDF, Blinn-Phong NDF, Beckmann NDF, Trowbridge-Reitz NDF(== GGX NDF)

##### Beckmann NDF

$\Lambda(a) \approx \left\{ \begin{array}{} \dfrac{1-1.259a+0.396a^2}{3.535a+2.181a^2}, \quad (a < 1.6) \\ 0, \quad \quad \quad \quad \quad \quad \quad \quad \quad \quad (a \ge 1.6) \end{array} \right.$



##### GGX NDF

$D(m)=\dfrac{\chi^+(n \cdot m)\alpha_g^2}{\pi(1+(n \cdot m)^2(\alpha_g^2 -  1))^2}$

이때 $\chi^+(x)=\left\{ \begin{array}{} 1, \quad \mathrm{where}\ \ x>0 \\ 0, \quad \mathrm{where} \ \  x \le 0 \end{array} \right.$

이때 $\alpha_g$는 표면의 거침(roughness)을 나타내는 매개변수로

$\alpha_g = r^2$ 으로 두고, r을 0에서 1사이의 선형 값으로 지정하면 된다.



GGX NDF는 shape-invariant이므로 람다 함수가 단순하다

 => $\Lambda(a) = \dfrac{-1+\sqrt{1+\frac{1}{a^2}}}{2}$

 이때, $a=\dfrac{n \cdot s}{\alpha\sqrt{1-(n \cdot s)^2}}$ 이다. (s는 l 또는 v이다.)

 

#### $G(l, v, h)$ Geometry function

shadowing masking function이라고도 불린다

전체 미세면 중 가리거나 그늘지지 않은 미세면(즉, 눈에 빛을 반사시키는) 미세면의 비율이다.

여러 함수가 있지만 아래 거가 제일 수학적으로/물리적으로 괜찮은 듯? (Eric Heitz)

$G_s(l, v, h) = G_{s1}(l,h)G_{s1}(v,h)$

Smith G1

GGX NDF의 G_1은 다음과 같다

$G_1(s) \approx \dfrac{2(n \cdot s)}{(n \cdot s)(2-\alpha) + \alpha}$ (s는 l 또는 v이다.)



Smith G2

 -> Lamda($\Lambda$) function을 알아야 도출 가능..?

GGX NDF의 $G_2$는 다음과 같다

$\dfrac{G_2(l, v)}{4|n \cdot l||n \cdot v|} \approx \dfrac{0.5}{lerp(2|n \cdot l||n \cdot v|, |n \cdot l| + |n \cdot v|, \alpha)}$



Specular roughness보다 Diffuse roughness가 훨씬 덜 정교하고, 변화가 덜하다

