# Calculus

## 미분법 differentiation

### 도함수 (derivative)

#### 정의

$$
\begin{align}
f'(x) & = \lim_{\Delta x \rightarrow 0} \dfrac{\Delta f}{\Delta x}
\\
& = \lim_{\Delta x \rightarrow 0} \dfrac{f(x+\Delta x) - f(x)}{\Delta x}
\end{align}
$$

구간 (interval)

개구간 (open interval)

폐구간 

미분가능 (differrentiable)



#### 표기법 (notations)

##### 1계 도함수

$$
f'(x)  = \dfrac{df}{dx} = \dfrac{d}{dx}f = \dfrac{d}{dx}f(x) = y' = \dfrac{dy}{dx} = \dfrac{d}{dx}y
$$

##### 2계 도함수

$$
y'' = f''(x) = \dfrac{d^2y}{dx^2}
$$

##### 3계 도함수

$$
y''' = f'''(x) = \dfrac{d^3y}{dx^3}
$$

##### n계 도함수

$$
y^{(n)} = f^{(n)}(x) = \dfrac{d^ny}{dx^n}
$$



#### 예제1

$$
f(x)=x^2
$$


$$
\begin{align}
& \dfrac{\Delta f}{\Delta x}
\\
& = \dfrac{(x+\Delta x)^2 - x^2}{\Delta x}
\\
& = \dfrac{x^2+2x\Delta x + \Delta x^2 - x^2}{\Delta x}
\\
& = \dfrac{2x\Delta x + \Delta x^2}{\Delta x}
\\
& = 2x + \Delta x
\\
\\
\dfrac{d}{dx}f(x) & = \lim_{\Delta x \rightarrow 0} \dfrac{\Delta f}{\Delta x} 
\\
& = \lim_{\Delta x \rightarrow 0}(2x + \Delta x)
\\
& = 2x
\\
\\
\therefore f'(x) & = 2x
\end{align}
$$



#### 예제2

$$
f(x)=\dfrac{1}{x}
$$


$$
\begin{align}
& \dfrac{\Delta f}{\Delta x}
\\
& = \dfrac{\dfrac{1}{x+\Delta x} - \dfrac{1}{x}}{\Delta x}
\\
& = \dfrac{1}{\Delta x} \left( \dfrac{1}{x+\Delta x} - \dfrac{1}{x} \right)
\\
& = \dfrac{1}{\Delta x} \left( \dfrac{x}{x(x+\Delta x)} - \dfrac{x+\Delta x}{x(x+\Delta x)} \right)
\\
& = \dfrac{1}{\Delta x} \cdot  \dfrac{x-(x+\Delta x)}{x(x+\Delta x)}
\\
& = \dfrac{1}{\Delta x} \cdot  \dfrac{-\Delta x}{x(x+\Delta x)}
\\
& = \dfrac{-1}{x(x+\Delta x)}
\\
\\
\dfrac{d}{dx}f(x) & = \lim_{\Delta x \rightarrow 0} \dfrac{\Delta f}{\Delta x} 
\\
& = \lim_{\Delta x \rightarrow 0} \dfrac{-1}{x(x+\Delta x)}
\\
& = \dfrac{-1}{x^2}
\\
\\
\therefore f'(x) & = \dfrac{-1}{x^2}
\end{align}
$$



### 다항식으로 확장

$$
\dfrac{d}{dx}(4x^3+5x^2) = \dfrac{d}{dx}4x^3 + \dfrac{d}{dx}5x^2
$$



### 곱의 법칙 (Product rule)

$$
\begin{align}
F(x) & = f(x)g(x)\\
\dfrac{d}{dx}F(x) & = f'(x)g(x)+f(x)g'(x)
\end{align}
$$



#### 증명

$$
\begin{align}
\dfrac{d}{dx}F(x) & = \lim_{h \rightarrow 0}\dfrac{F(x+h)-F(x)}{h} \\
& = \lim_{h \rightarrow 0}\dfrac{f(x+h)g(x+h) - f(x)g(x)}{h} \\
& = \lim_{h \rightarrow 0}\dfrac{f(x+h)g(x+h) - f(x)g(x) + f(x+h)g(x) - f(x+h)g(x)}{h} \\
& = \lim_{h \rightarrow 0}\dfrac{f(x+h)g(x) - f(x)g(x) + f(x+h)g(x+h) - f(x+h)g(x)}{h} \\
& = \lim_{h \rightarrow 0}\dfrac{g(x)[f(x+h) - f(x)] + f(x+h)[g(x+h) - g(x)]}{h} \\
& = \lim_{h \rightarrow 0}g(x)\dfrac{f(x+h) - f(x)}{h} + \lim_{h \rightarrow 0}f(x+h)\dfrac{g(x+h) - g(x)}{h} \\
& = \lim_{h \rightarrow 0}g(x) \lim_{h \rightarrow 0}\dfrac{f(x+h) - f(x)}{h} + \lim_{h \rightarrow 0}f(x+h) \lim_{h \rightarrow 0}\dfrac{g(x+h) - g(x)}{h} \\
& = f'(x)g(x) + f(x)g'(x)
\end{align}
$$



### 몫의 법칙 (Quotient rule)

$$
\begin{align}
F(x) & = \dfrac{f(x)}{g(x)} \\
\dfrac{d}{dx}F(x) & = \dfrac{f'(x)g(x) - f(x)g'(x)}{[g(x)]^2}
\end{align}
$$



#### 증명

$$
\begin{align}
\dfrac{d}{dx}F(x) & = \lim_{h \rightarrow 0}\dfrac{F(x+h)-F(x)}{h} \\
& = \lim_{h \rightarrow 0}\dfrac{\dfrac{f(x+h)}{g(x+h)} - \dfrac{f(x)}{g(x)}}{h} \\
& = \lim_{h \rightarrow 0}\dfrac{\dfrac{f(x+h)g(x) - f(x)g(x+h)}{g(x)g(x+h)}}{h} \\
& = \lim_{h \rightarrow 0}\dfrac{f(x+h)g(x) - f(x)g(x+h)}{hg(x)g(x+h)} \\
& = \lim_{h \rightarrow 0}\dfrac{f(x+h)g(x) - f(x)g(x+h) + f(x)g(x) - f(x)g(x)}{hg(x)g(x+h)} \\
& = \lim_{h \rightarrow 0}\dfrac{f(x+h)g(x) - f(x)g(x) - f(x)g(x+h) + f(x)g(x)}{hg(x)g(x+h)} \\
& = \lim_{h \rightarrow 0}\dfrac{g(x)[f(x+h) - f(x)] - f(x)[g(x+h) - g(x)]}{hg(x)g(x+h)} \\
& = \lim_{h \rightarrow 0}\dfrac{g(x)}{g(x)g(x+h)} \lim_{h \rightarrow 0}\dfrac{f(x+h) - f(x)}{h} - \lim_{h \rightarrow 0}\dfrac{f(x)}{g(x)g(x+h)} \lim_{h \rightarrow 0}\dfrac{g(x+h) - g(x)}{h} \\
& = \dfrac{g(x)}{[g(x)]^2}f'(x)-\dfrac{f(x)}{[g(x)]^2}g'(x) \\
& = \dfrac{f'(x)g(x) - f(x)g'(x)}{[g(x)]^2}
\end{align}
$$



### 연쇄 법칙 (Chain rule) ★

$$
\begin{align}
y & = (f \circ g)(x) \\ \\

u & = g(x) \\ 
y & = f(u) \\ \\
\dfrac{dy}{dx} & =\dfrac{dy}{du}\dfrac{du}{dx} =f'(g(x))g'(x) \\
\end{align}
$$



#### (약한) 증명

$$
\begin{align}
y & = (f \circ g)(x) \\ \\

u & = g(x) \\ 
y & = f(u) \\ \\
\end{align}
$$


$$
\begin{align}
\Delta u & = g(x + \Delta x) - g(x) \\ 
\Delta y & = f(u + \Delta u) - f(u) \\ \\
\dfrac{dy}{dx} & = \lim_{\Delta x \rightarrow 0} \dfrac{\Delta y}{\Delta x} \\
& = \lim_{\Delta x \rightarrow 0} \dfrac{\Delta y}{\Delta u} \dfrac{\Delta u}{\Delta x} \\
& = \lim_{\Delta x \rightarrow 0} \dfrac{\Delta y}{\Delta u} \lim_{\Delta x \rightarrow 0}\dfrac{\Delta u}{\Delta x} \\
& = \lim_{\Delta u \rightarrow 0} \dfrac{\Delta y}{\Delta u} \lim_{\Delta x \rightarrow 0}\dfrac{\Delta u}{\Delta x} \\
& = \dfrac{dy}{du}\dfrac{du}{dx}
\end{align}
$$


#### 예시 

$$
\begin{align}
F(x) & = \sin(x^2+3x) \\
\text{let } & \begin{cases}
g(x) = x^2+3x=u \\
f(u) = \sin{u} \\
\end{cases}
\\
F(x) & = (f \circ g)(x) \\ \\
\dfrac{d}{dx}F(x) & =\dfrac{df}{du}\dfrac{du}{dx} =f'(g(x))g'(x) \\
& = \cos{u}(2x+3) \\
& = (2x+3)\cos(x^2+3x)
\end{align}
$$



### 삼각함수의 도함수 (derivatives of trigonometric functions)

#### 삼각함수의 극한

$$
\lim_{x \rightarrow 0} \dfrac{\sin x}{x} = 1
$$


$$
\lim_{x \rightarrow 0} \dfrac{\cos x - 1}{x} = 0
$$


#### sin

$$
\begin{align}
& \dfrac{d}{dx}(\sin x) \\
& = \lim_{h \rightarrow 0} \dfrac{\sin(x+h) - \sin x}{h} \\
& = \lim_{h \rightarrow 0} \dfrac{\sin x \cos h + \cos x\sin h - \sin x}{h} \\
& = \lim_{h \rightarrow 0} \dfrac{\sin x(\cos h - 1) + \cos x\sin h}{h} \\
& = \lim_{h \rightarrow 0} \dfrac{\sin x(\cos h - 1)}{h} + \lim_{h \rightarrow 0} \dfrac{\cos x\sin h}{h} \\
& = \sin x \cdot \lim_{h \rightarrow 0} \dfrac{\cos h - 1}{h} + \cos x \cdot \lim_{h \rightarrow 0} \dfrac{\sin h}{h} \\
& = \sin x \cdot 0 + \cos x \cdot 1 \\
& = \cos x \\
\end{align}
$$



#### cos

$$
\begin{align}
& \dfrac{d}{dx}(\cos x) \\
& = \lim_{h \rightarrow 0} \dfrac{\cos(x+h) - \cos x}{h} \\
& = \lim_{h \rightarrow 0} \dfrac{\cos x \cos h - \sin x\sin h - \cos x}{h} \\
& = \lim_{h \rightarrow 0} \dfrac{\cos x(\cos h - 1) - \sin x\sin h}{h} \\
& = \lim_{h \rightarrow 0} \dfrac{\cos x(\cos h - 1)}{h} - \lim_{h \rightarrow 0} \dfrac{\sin x\sin h}{h} \\
& = \cos x \cdot \lim_{h \rightarrow 0} \dfrac{\cos h - 1}{h} - \sin x \cdot \lim_{h \rightarrow 0} \dfrac{\sin h}{h} \\
& = \cos x \cdot 0 - \sin x \cdot 1 \\
& = -\sin x \\
\end{align}
$$



#### tan

$$
\begin{align}
& \dfrac{d}{dx}(\tan x) \\
& = \dfrac{d}{dx}(\dfrac{\sin x}{\cos x} \\
& = \dfrac{\sin' x \cos x - \sin x \cos' x}{\cos^2 x} \\
& = \dfrac{\cos x \cos x + \sin x \sin x}{\cos^2 x} \\
& = \dfrac{\cos^2 + \sin^2 x}{\cos^2 x} \\
& = \dfrac{1}{\cos^2 x} \\
& = \sec^2 x
\end{align}
$$



#### sec

#### csc

#### cot



### 음함수 미분 (implicit differentiation)

y를 x에 대한 함수로 생각하고
$$
y' = \dfrac{dy}{dx}
$$
라는 사실을 이용해 식 전체를 x에 대해 미분한다.


$$
\begin{align}
x^2 - y & = 2 \\
\dfrac{d}{dx}x^2 - \dfrac{d}{dx}y & = \dfrac{d}{dx}2 \\
2x - \dfrac{dy}{dx} & = 0 \\
\dfrac{dy}{dx} & = 2x \\
\end{align}
$$

$$
\begin{align}
x^2+y^2 & = 4 \\
\dfrac{d}{dx}x^2 + \dfrac{d}{dx}y^2 & = \dfrac{d}{dx}4 \\
2x + 2y \cdot \dfrac{dy}{dx} & = 0 \\
2y\dfrac{dy}{dx} & = -2x \\
\dfrac{dy}{dx} & = -\dfrac{2x}{2y} \\
\therefore \dfrac{dy}{dx} & = -\dfrac{x}{y} \\
\end{align}
$$



### 역도함수 (antiderivative)

$$
\text{A function } F \text{ is called an } \bold{antiderivative} \text{ of } f \text{ on an interval } I \\
\text{if } F'(x) = f(x) \\ \text{ for all } x \text{ in } I
$$




$$
\begin{align}
& \text{If } F \text{ is an antiderivative of } f \text{ on an interval } I, \\
&\text{then the most general antiderivative of } f \text{ on } I \text{ is } \\
& \phantom{abcdefghijklmnop} F(x) + C \\
& \text{where } C \text{ is an arbitrary constant.}
\end{align}
$$






## 적분법 integration

### 정적분 definite integral

$$
\int_{a}^{b}f(x)dx=\lim_{n \rightarrow \infin}\sum_{i=1}^{n}f(x_i^*)\Delta x
$$

적분 기호 integral sign

적분 한계 limits of integration

하한 lower limit

상한 upper limit

피적분함수 integrand

적분법 integration

리만 합 (Riemann sum)



### 미적분학의 기본 정리 (Fundamental Theorem of Calculus, FTC)

#### FTC 1

$$
\text{If } f \text{ is continuous on [a, b], } \\
\text{then the function } g \text{ defined by } \\
g(x) = \int_{a}^{x}f(t)dt, \qquad a \le x \le b \\
\\
\text{is continuous on [a, b] and differentiable on (a, b), and} \\
g'(x)  = f(x)
$$



#### FTC 2

$$
\text{If } f \text{ is continuous on [a, b], then } \\
\int_{a}^{b}f(x)dx = F(b) - F(a) = F(x)\\
\text{where } F \text{ is any antiderivative of } f \ (F' = f)
$$



##### 표기법

$$
\begin{align}
F(b) - F(a) & = F(x) \vert ^b_a \\
& = F(x) \big\rbrack ^b_a \\
& = \big[F(x)\big]^b_a
\end{align}
$$



### 부정적분 indefinite integral

#### 부정적분 = 역도함수

$$
\int f(x)dx = F(x) \qquad \text{ means } \qquad F'(x) = f(x)
$$



#### 정적분과 부정적분

##### 부정적분은 함수(족), 정적분은 수

$$
\int_{a}^{b}f(x)dx = \int f(x)dx \Big\rbrack_a^b
$$



#### 치환법 substitution rule (->미분 연쇄법칙)★

$$
\text{If } u = g(x) \text{ is a differentiable function whose range is} \\
\text{an interval } I \text{ and } f \text{ is continuous on } I \text{, then} \\
\int f(g(x))g'(x)dx = \int f(u)du
$$



##### 암기 요령

$$
\begin{align}
u & = g(x) \\
\dfrac{du}{dx} & = g'(x) \\
\therefore du & = g'(x)dx
\end{align}
$$



##### 특징

분수의 경우 분모를 u로 두는 경우가 많다! du가 dx와 다른 값의 곱(결론적으로 분자가 됨)으로 나타나기 때문!



##### 증명

연쇄 법칙에 의해
$$
\dfrac{d}{dx}[F(g(x))] = f(g(x))g'(x)
$$
이므로
$$
\int f(g(x))g'(x)dx = F(g(x)) + C
$$
이다. 이때
$$
u = g(x)
$$
로 두면
$$
F(g(x)) + C = F(u) + C = \int f(u)du
$$

$$
\therefore \int f(g(x))g'(x)dx = \int f(u)du
$$



##### 예시1★

$$
\int{\dfrac{x}{\sqrt{1-x^2}}dx}
$$


$$
\begin{align}
u &= 1-x^2 \\
du &= -2xdx
\end{align}
$$
로 두면
$$
\begin{align}
& \int{\dfrac{x}{\sqrt{1-x^2}}dx} \\
&= -\dfrac{1}{2}\int{\dfrac{du}{\sqrt{u}}} \\
&= -\dfrac{1}{2}(2u^{1/2}) + C \\
&= -u^{1/2} + C \\
&= -\sqrt{1-x^2} + C \\
\end{align}
$$

$$
\therefore \int{\dfrac{x}{\sqrt{1-x^2}}dx} = -\sqrt{1-x^2} + C \\
$$


##### 예시2★

$$
\int \dfrac{dx}{(1+\sqrt{x})^4}
$$

이때
$$
\begin{align}
u &= 1 + \sqrt{x} \\
du &= \dfrac{dx}{2\sqrt{x}} \\
&= \dfrac{dx}{2(u-1)} \\
&= \dfrac{dx}{2u-2}
\end{align}
$$
따라서
$$
\begin{align}
&\int \dfrac{dx}{(1+\sqrt{x})^4} \\
&= \int \dfrac{2u-2}{u^4}du \\
&= 2\int \dfrac{u-1}{u^4}du \\
&= 2\left(\int \dfrac{u}{u^4}du - \int \dfrac{1}{u^4}du\right) \\
&= 2\left(\int u^{-3}du - \int u^{-4}du\right) \\
&= 2\left(-\dfrac{1}{2}u^{-2} + \dfrac{1}{3}u^{-3} + C\right) \\
&= -u^{-2} + \dfrac{2}{3}u^{-3} + C \\
&= -\dfrac{1}{u^2} + \dfrac{2}{3u^3} + C \\
&= -\dfrac{1}{(1 + \sqrt{x})^2}+\dfrac{2}{3(1 + \sqrt{x})^3}+C
\end{align}
$$

$$
\therefore \int \dfrac{dx}{(1+\sqrt{x})^4} = -\dfrac{1}{(1 + \sqrt{x})^2}+\dfrac{2}{3(1 + \sqrt{x})^3}+C
$$


## 역함수 inverse functions

$$
y=f(x) \\
f^{-1}(y)=x
$$


$$
\dfrac{d}{dx}\left[f^{-1}(x)\right] = \dfrac{1}{f'(x)}
$$


![](Asset\inverse_function.png)



## 지수함수  exponential functions

### 상수 e

$$
\lim_{h \rightarrow 0}\dfrac{e^{(0+h)} - e^0}{h}=1 \\
\lim_{h \rightarrow 0}\dfrac{e^h - 1}{h}=1
$$



### 자연지수함수 natural exponential function

$$
f(x)=e^x
$$



#### 도함수

$$
\dfrac{d}{dx}(e^x)=e^x
$$



#### 역도함수

$$
\int e^xdx = e^x+C
$$



#### 예시★

$$
\int (e^x+e^{-x})^2dx
$$

제곱을 풀면
$$
\begin{align}
&\int{(e^{2x} + 2 + e^{-2x})}dx \\
&= \int{e^{2x}}dx + 2\int dx + \int{e^{-2x}}dx \\
&= \dfrac{1}{2}e^{2x} + 2x - \dfrac{1}{2}e^{-2x} + C \\
&= \dfrac{1}{2}(e^{2x} - e^{-2x}) + 2x + C \\
\end{align}
$$


### 로그함수 logarithmic functions

#### 지수함수의 역함수

$$
e^y = x
$$

$$
y = \ln x \\
$$

#### 성질(?)

$$
\ln e = 1 \\
\ln 1 = 0
$$



#### 도함수

$$
\begin{align}
y &=\ln x \\
x &=e^y \\
\end{align}
$$

음함수적으로 미분하면
$$
\begin{align}
\dfrac{d}{dx}x &=\dfrac{d}{dx}e^y \\
1 &= e^y \dfrac{dy}{dx} \\
\dfrac{dy}{dx} &=\dfrac{1}{e^y} \\
&= \dfrac{1}{x}
\end{align}
$$
따라서
$$
\dfrac{d}{dx}(\ln x) = \dfrac{1}{x}
$$



##### 1/x 의 역도함수

$$
\int \dfrac{1}{x}dx = \ln |x| + C
$$





##### 참고!!

e는 x에 대한 함수가 아니라 상수이므로
$$
\dfrac{d}{dx}(\ln e) = 0
$$

$$
\ln e^x = x
$$



#### tanx의 역도함수★

$$
\begin{align}
&\int \tan x dx \\
&= \int \dfrac{\sin x}{\cos x}dx
\end{align}
$$

이때
$$
\begin{align}
u &= \cos x \\
du &= -\sin xdx
\end{align}
$$
로 두면
$$
\begin{align}
&\int \dfrac{\sin x}{\cos x}dx \\
&= -\int\dfrac{1}{u}du \\
& = -\ln|u| + C \\
& = -\ln|\cos x| + C \\
& = \ln|\cos x|^{-1} + C \\
& = \ln|\cos^{-1} x| + C \\
& = \ln|\sec x| + C \\
\end{align}
$$


### 역삼각함수

#### arcsin

$$
\text{domain } \ \left[-1, 1\right] \\
\text{range } \ \left[-\dfrac{\pi}{2}, \dfrac{\pi}{2}\right]
$$


$$
\begin{align}y &= \sin ^{-1}x \\x &= \sin y\end{align}
$$
음함수적으로 미분하면
$$
\begin{align}
\dfrac{d}{dx}x &= \dfrac{d}{dx}(\sin y)\\
1 &= \cos y \dfrac{dy}{dx} \\
\dfrac{dy}{dx}& = \dfrac{1}{\cos y} \\
\end{align}
$$
이때
$$
\begin{align}
\cos ^2y + \sin ^2y &= 1 \\
\cos ^2y &= 1 - \sin ^2y \\
\cos ^2y& = 1 - x^2 \\
\cos y& = \sqrt{1 - x^2}
\end{align}
$$
따라서
$$
\dfrac{d}{dx}(\sin ^{-1}x) = \dfrac{1}{\sqrt{1-x^2}}
$$


#### arccos

$$
\text{domain } \ \left[-1, 1\right] \\
\text{range } \ \left[0, \pi\right]
$$


$$
\begin{align}
y &= \cos ^{-1}x \\
x &= \cos y
\end{align}
$$
음함수적으로 미분하면
$$
\begin{align}
\dfrac{d}{dx}x &= \dfrac{d}{dx}(\cos y)\\
1 &= -\sin y \dfrac{dy}{dx} \\
\dfrac{dy}{dx}& = -\dfrac{1}{\sin y} \\
\end{align}
$$
이때
$$
\begin{align}
\cos ^2y + \sin ^2y &= 1 \\
\sin ^2y &= 1 - \cos ^2y \\
\sin ^2y& = 1 - x^2 \\
\sin y& = \sqrt{1 - x^2}
\end{align}
$$
따라서
$$
\dfrac{d}{dx}(\cos ^{-1}x)=-\dfrac{1}{\sqrt{1-x^2}}
$$


#### arctan

$$
\text{domain } \ \R \\
\text{range } \ \left[ -\dfrac{\pi}{2}, \dfrac{\pi}{2} \right]
$$


$$
\begin{align}
y &= \tan ^{-1}x \\
x &= \tan y
\end{align}
$$
음함수적으로 미분하면
$$
\begin{align}
\dfrac{d}{dx}x &= \dfrac{d}{dx}(\tan y)\\
1 &= \sec ^2 y \dfrac{dy}{dx} \\
\dfrac{dy}{dx}& = \dfrac{1}{\sec ^2 y} \\
\end{align}
$$
이때 ★
$$
\begin{align}
1 + \tan ^2 y &= \dfrac{\cos ^2 y + \sin ^2 y}{\cos ^2 y} \\
&= \dfrac{1}{\cos ^2 y} \\ \\
1 + \tan ^2 y &= \sec^2y \\
1+x^2 &= \sec^2 y
\end{align}
$$
따라서
$$
\dfrac{d}{dx}(\tan ^{-1}x)=\dfrac{1}{1+x^2}
$$


#### arcsec

$$
\begin{align}
y &= \sec^{-1} x \\
x &= \sec y
\end{align}
$$

음함수적으로 미분하면
$$
\begin{align}
1 &= \dfrac{d}{dx}(\sec y) \\
1 &= \sec y \tan y \dfrac{dy}{dx} \\
\dfrac{dy}{dx} &= \dfrac{1}{\sec y \tan y} \\
\end{align}
$$
이때
$$
\begin{align}
1 + \tan^2 y &= \sec^2 y \\
\tan^2 y &= \sec^2 y - 1 \\
\tan y &= \sqrt{\sec^2 y - 1} \\
\tan y &= \sqrt{x^2 - 1} \\
\end{align}
$$
따라서
$$
\dfrac{d}{dx}\sec^{-1}x = \dfrac{1}{x\sqrt{x^2-1}}
$$


#### arccsc

#### 

$$
\begin{align}
y &= \csc^{-1} x \\
x &= \csc y
\end{align}
$$

음함수적으로 미분하면
$$
\begin{align}
1 &= \dfrac{d}{dx}(\csc y) \\
1 &= -\csc y \cot y \dfrac{dy}{dx} \\
\dfrac{dy}{dx} &= -\dfrac{1}{\csc y \cot y} \\
\end{align}
$$
이때 ★
$$
\begin{align}
1 + \cot^2 y &= \dfrac{\sin^2 y + \cos^2 y}{\sin^2 y} \\
1 + \cot^2 y &= \dfrac{1}{\sin^2 y} \\
1 + \cot^2 y &= \csc^2y \\ \\
\cot^2 y &= \csc^2 y - 1 \\
\cot y &= \sqrt{\csc^2 y - 1} \\
\cot y &= \sqrt{x^2 - 1} \\
\end{align}
$$
따라서
$$
\dfrac{d}{dx}\csc^{-1}x = -\dfrac{1}{x\sqrt{x^2-1}}
$$


#### arccot

$$
\begin{align}
y &= \cot^{-1} x \\
x &= \cot y
\end{align}
$$

음함수적으로 미분하면
$$
\begin{align}
1 &= \dfrac{d}{dx}(\cot y) \\
1 &= -\csc^2 y \dfrac{dy}{dx} \\
\dfrac{dy}{dx} &= -\dfrac{1}{\csc^2 y} \\\end{align}
$$
이때 ★
$$
\begin{align}
1 + \cot^2 y &= \csc^2y \\
1 + x^2 &= \csc^2 y
\end{align}
$$
따라서
$$
\dfrac{d}{dx}\cot^{-1}x = -\dfrac{1}{1+x^2}
$$





## 적분법+

### 부분적분 (-> 곱의 미분 법칙)

#### 방법

$$
u = f(x), \ v = g(x) \\
uv = \int udv + \int vdu \\
\int udv = uv - \int vdu
$$



#### lnx의 역도함수

$$
\int{\ln x dx}
$$


$$
u = \ln x, \ du = \dfrac{dx}{x} \\
v = x, \ dv = dx
$$
로 두면
$$
\begin{align}
\int{\ln x dx} &= x \ln x - \int{dx} \\
&= x \ln x - x + C
\end{align}
$$


#### e^x sinx 의 역도함수

$$
\int{e^x \sin x dx}
$$


$$
u = e^x, \ du = e^xdx \\v = \sin x, \ dv = \cos xdx
$$
로 두면
$$
\begin{align}\int{e^x \sin x dx} = e^x \sin x - \int{e^x \cos x dx}\end{align}
$$
이고,

이때
$$
t = e^x, \ dt = e^x dx \\w = \cos x, \ dw = -\sin x dx
$$
로 두면 ★ (이 과정을 해야만 풀린다... uv를 그대로 두고 풀면 항등식이 나와 풀 수 없다! ★)
$$
\begin{align}\int{e^x \cos x dx} = e^x \cos x + \int{e^x \sin x dx}\end{align}
$$
이므로
$$
\begin{align}\int{e^x \sin x dx} &= e^x \sin x - \int{e^x \cos x dx} \\&= e^x \sin x - e^x \cos x - \int{e^x \sin x dx} \\2\int{e^x \sin x dx} &= e^x(\sin x - \cos x) \\\therefore \int{e^x \sin x dx} &= \dfrac{e^x(\sin x - \cos x)}{2}\end{align}
$$


#### sin(^2)x 의 역도함수

$$
\int \sin^2xdx
$$

먼저
$$
u=\sin x, \ du=\cos xdx \\
v = -\cos x, \ dv = \sin xdx
$$
로 두면
$$
\begin{align}
\int \sin^2xdx = \int udv &= uv - \int vdu \\
&= -\sin x \cos x + \int \cos^2 x dx
\end{align}
$$
로 또다른 삼각함수의 제곱에 대한 적분이 나오므로 무의미하다.

따라서
$$
u = \sin^2 x, \ du = 2\cos x dx \\
v = x, \ dv = dx
$$
로 다시 두면
$$
\begin{align}
\int \sin^2xdx = \int udv &= uv - \int vdu \\
&= x \sin^2 x - 2\int x\cos x dx
\end{align}
$$
이때
$$
\begin{align}
\int x\cos x dx
\end{align}
$$
에 대해
$$
t = \sin x, \ dt = \cos x \\
w = x, \ dw = dx
$$
로 두면
$$
\begin{align}
\int x\cos x dx &= x\sin x - \int \sin x dx \\
&= x\sin x + \cos x + C
\end{align}
$$
따라서
$$
\begin{align}
\int \sin^2xdx &= x \sin^2 x - 2\int x\cos x dx\\
\therefore \int \sin^2xdx &= x \sin^2 x - 2x\sin x + 2\cos x + C
\end{align}
$$
이다.



### 삼각적분

### 삼각치환

### 부분분수

### 이상적분

### 근사적분

