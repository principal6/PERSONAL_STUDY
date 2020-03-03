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



#### 치환법 substitution rule ★

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



## 역함수 inverse functions





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



### 로그함수 logarithmic functions

#### 지수함수의 역함수

$$
e^y = x
$$

$$
y = \ln x \\
$$



#### 도함수

$$
\dfrac{d}{dx}\ln x = \dfrac{1}{x}
$$



#### (?)역도함수

$$
\int \dfrac{1}{x}dx = \ln |x| + C
$$

