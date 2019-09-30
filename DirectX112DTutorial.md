# DirectX 11 Tutorial

## #00. 윈도우(Window) 생성하기

### 이 강좌에서는 `C++ / C#` 언어를 사용합니다.

`C++`에서 `DirectX 11`을 이용해 게임을 만드는 것이 우리 강좌의 목표다.

그러려면 우선 가장 먼저 해야할 일은 바로 `윈도우(Window)`를 만드는 일이다. `윈도우즈(Windows) 운영체제` 내에서 모든 작업은 이 윈도우(Window)를 기반으로 이루어지고, 우리가 만들 게임도 예외는 아니기 때문이다.

윈도우는 `윈도우즈 운영체제`에서 제공하는 `Win32 API`를 통해 생성할 수 있으며, 이를 위해서는 `<windows.h>` 헤더 파일을 포함해야 한다.

모든 윈도우 기반 프로그램은 반드시 두 개의 함수를 지닌다. 윈도우의 메인 함수인 `WinMain()` 함수와 메시지를 처리하는 함수인 `WndProc()` 함수이다.

`WinMain()` 프로그램의 시작점이고

`WndProc()` 은 윈도우에 전달되는 메시지를 어떻게 처리할지 정할 수 있는 함수이다.

우리가 윈도우를 클릭하거나 크기를 조정하거나 초소화를 하든 최대화를 하든 키보드로 입력을 하든 모든 이벤트는 윈도우즈에선 메시지(message) 큐로 처리된다.



우선, 빈 C++ 프로젝트를 만들고, `main.cpp` 라는 `cpp` 파일을 생성하자. 그후 다음과 같이 윈도우즈 프로그래밍의 메인 함수인 `WinMain()` 함수를 작성해 보자.

```cpp
#include <windows.h>

// WndProc 함수의 원형
LRESULT CALLBACK WndProc(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);

// 이 길고 복잡한 WinMain() 함수의 원형(Prototype)은 <WinBase.h> 헤더 파일 내에 정의되어 있다.
// 따라서 함수의 원형을 외울 필요 없이 WinBase.h 파일에서 WinMain을 검색하여 복사 붙여넣기만 하면 된다.
int WINAPI WinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPTSTR lpCmdLine, _In_ int nShowCmd)
{
	return 0;
}

// 이 함수는 사용자 정의 함수지만
// <WinUser.h> 헤더 내 DefWindowProc() 함수의 정의와 모든 게 동일하므로 참고하자.
LRESULT CALLBACK WndProc(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam)
{
    switch (Msg)
	{
	case WM_DESTROY:
		PostQuitMessage(0);
		return 0;
	}
	return DefWindowProc(hWnd, Msg, wParam, lParam);
}
```

먼저 진입점인 `WinMain()` 함수를 살펴보자. 이 함수는 여러 가지 매개변수를 받아오기만 할뿐, 실제로 내부에서 하는 일은 프로그램을 정상적으로 종료(`return 0;`)하는 일 말고는 아무것도 없다. 우리가 아직 아무 코드도 쓰지 않았기 때문이다.

이 메인 함수 내에서 우리는 윈도우를 생성하는 함수인 `CreateWindowEx()`를 호출하여 윈도우를 생성할 것이다.

우선 메인 함수 내에 `CreateWindowEx();`라고 쓰고 해당 함수의 이름을 클릭한 후 `F12` 키를 눌러 함수가 정의되어 있는 파일인`<WinUser.h>`로 이동해 보자.

```cpp
// <WinUser.h> 파일 내부
// ...
#ifdef UNICODE
#define CreateWindowEx  CreateWindowExW
#else
#define CreateWindowEx  CreateWindowExA
#endif // !UNICODE
// ...
```

위에서 알 수 있듯, `CreateWindowEx`는 사용자가 유니코드(UNICODE) 문자를 사용할지 혹은 아스키(ASCII) 문자를 사용할지 지정한 프로젝트 설정에 따라 `CreateWindowExW` 혹은 `CreateWindowExA`로 바뀌는 매크로이다.

윈도우즈의 함수에는 기본적으로 유니코드 사용 유무에 따라 비 유니코드 시 `~A`, 유니코드 시 `~W`라는 접미사가 붙는데, 유니코드 / 비 유니코드 간 전환을 용이하게 하기 위해 대부분 `~A/~W` 가 들어가지 않은 이름의 매크로가 존재한다. 우리는 호환성을 위해 `CreateWindowExA()`나 `CreateWindowExW()`와 같은 명시적인 함수 이름 대신 `CreateWindowEx`와 같은 매크로를 사용할 것이다. (※ 이 강좌에서 우리는 ASCII 문자를 사용한다고 가정하고 앞으로 모든 함수의 정의는 `~A()` 함수를 살펴볼 것이다.)

자, 이제 `CreateWindowExA()` 함수를 다음과 같이 작성해 보자.

```cpp
// TEXT() 매크로는 UNICODE/ASCII 설정에 따라 문자열을 const char* / const wchar_t* 자료형으로 바꿔 준다.
HWND hWnd{ CreateWindowEx(0, TEXT("DirectX11GameWindow"), TEXT("Game"), WS_OVERLAPPEDWINDOW,
	CW_USEDEFAULT, CW_USEDEFAULT, 800, 600,
	nullptr, nullptr, hInstance, nullptr)};
```

이 함수의 원형은 다음과 같은데

```cpp
HWND WINAPI CreateWindowExA(
    _In_ DWORD dwExStyle,
    _In_opt_ LPCSTR lpClassName,
    _In_opt_ LPCSTR lpWindowName,
    _In_ DWORD dwStyle,
    _In_ int X,
    _In_ int Y,
    _In_ int nWidth,
    _In_ int nHeight,
    _In_opt_ HWND hWndParent,
    _In_opt_ HMENU hMenu,
    _In_opt_ HINSTANCE hInstance,
    _In_opt_ LPVOID lpParam);
```

여기서 우리가 사용한 인수에 대해 잠깐 설명하자면 다음과 같다.

- `lpClassName` (윈도우) 클래스의 이름
  - `LP` 는 `long pointer` 즉, 포인터를 의미하고,
  - `CSTR`는 `const string` 를 의미하므로
  - `LPCSTR`은 곧 `const char*`과 동일하다.

- `lpWindowName` 윈도우 타이틀로 사용될 문자열
- `dwStyle` 윈도우의 스타일로, 여기에 대입할 수 있는 유효한 값은 모두 매크로로 정의되어 있다.
  - Window Style의 약자로, `WS_` 로 시작하는 매크로를 보면 된다.
  - 우리는 기본적인 스타일인 `WS_OVERLAPPEDWINDOW`를 사용할 것이다.
- `X` 윈도우의 가로 위치
- `Y` 윈도우의 세로 위치
- `nWidth` 윈도우의 가로 크기
  - `n`은 `number`를 뜻한다.
- `nHeight` 윈도우의 세로 크기
- `hInstance` 인스턴스에 대한 핸들

함수의 리턴 자료형은 `HWND`로, 윈도우에 대한 핸들`handle`을 담아두는 자료형이다.

윈도우즈에서는 모든 윈도우를 핸들이라는 것으로 관리하는데, 이는 마치 사람의 주민등록번호처럼 모든 윈도우에 주어진 고유의 번호와 같다. 우리가 여기서 생성할 윈도우도 당연히 고유의 핸들을 지니고, 그 고유 핸들 값을 `CreateWindowEx()` 함수가 리턴해주는 것이다. 앞으로 우리가 만든 윈도우를 잃어버리지 않고 계속 관리하려면 바로 이 핸들 값을 잘 저장해 두는 것이 중요하다.



여기까지 잘 따라왔다면 얼른 디버깅을 통해 멋진 윈도우가 생성되는 모습을 보고 싶겠지만, 안타깝게도 그건 불가능하다. 사실 `CreateWindowEx()`를 호출하기 전에 해야할 일이 더 남아있기 때문이다. 바로, `RegisterClassEx()`를 호출하는 것이다.

```cpp
ATOM WINAPI RegisterClassExA(_In_ CONST WNDCLASSEXA *);
```

다행히 이 함수는 인수를 딱 하나만 받는다. 바로 `WNDCLASSEXA`라는 구조체에 대한 주소이다. 이 함수를 호출하려면 먼저 `WNDCLASSEXA`라는 구조체를 선언할 필요가 있다.

```cpp
WNDCLASSEX window_class{};
window_class.cbSize = sizeof(WNDCLASSEX);
window_class.style = CS_HREDRAW | CS_VREDRAW;
window_class.lpfnWndProc = WndProc;
window_class.hInstance = hInstance;
window_class.hIcon = LoadIcon(nullptr, IDI_APPLICATION);
window_class.hIconSm = LoadIcon(nullptr, IDI_APPLICATION);
window_class.hCursor = LoadCursor(nullptr, IDC_ARROW);
window_class.hbrBackground = (HBRUSH)GetStockObject(GRAY_BRUSH);
window_class.lpszClassName = TEXT("DirectX11GameWindow");
window_class.lpszMenuName = nullptr;
```

- `cbSize` 구조체의 바이트 크기 (`sizeof(자료형)`를 이용하여 구한다. )
  - `cb`는 `count of bytes` 즉, 바이트 개수를 의미한다.
- `style` 윈도우 클래스의 스타일
  - 윈도우 Class Style이므로 접두사 `CS_` 가 붙은 매크로를 대입한다.
  - `CS_HREDRAW` 윈도우의 가로(horizontal) 크기가 변경되면 윈도우를 갱신한다.
  - `CS_VREDRAW` 윈도우의 세로(vertical) 크기가 변경되면 윈도우를 갱신한다.
- `lpfnWndProc` 윈도우 프로시저(Procedure) 함수에 대한 포인터
  - 위에서 작성한 함수의 이름 `WndProc`를 써 주면 된다.
  - `fn`은 `function` 즉, 함수를 말한다.
- `hInstance` 인스턴스에 대한 핸들
- `hIcon` 아이콘에 대한 핸들
  - `LoadIcon()` 함수를 쓴다. 표준 아이콘(`IDI_` 매크로)을 사용할 경우 첫 번째 인수는 `nullptr`을 대입한다.
  - `IDI (ID of Icon)`
  - `IDI_APPLICATION`
- `hIconSm` 작은 아이콘에 대한 핸들
  - `Sm`은 `small`
- `hCursor` 커서에 대한 핸들
  - `LoadCursor()` 함수를 사용한다. 표준 커서(`IDC_` 매크로)를 사용할 경우 첫 번째 인수는 `nullptr`이다.
  - `IDC (ID of Cursor)`
  - `IDC_ARROW`
- `hbrBackground` 배경색상에 대한 핸들
  - `GetStockObject()`를 호출해 기존에 존재하는(stock) 오브젝트를 가져와 `HBRUSH` 자료형으로 형변환한다.
    - 회색 붓(brush)으로 칠한 윈도우 배경을 사용할 것이므로 `회색 브러시 오브젝트`를 가리키는 매크로인 `GRAY_BRUSH`를 대입한다.
  - `br`는 `brush`
- `lpszClassName` 윈도우 클래스의 이름
  - `sz`는 `zero-terminated string`을 의미
- `lpszMenuName` 메뉴의 이름

이제 다음과 같이 윈도우 클래스를 등록할 수 있다.

```cpp
RegisterClassExA(&window_class);
```

아직 할 일이 두 개 남아있지만, 다행히 이 두 가지 일은 어렵지 않다.

```cpp
ShowWindow(hWnd, nShowCmd);
UpdateWindow(hWnd);
```

```cpp
BOOL WINAPI ShowWindow(_In_ HWND hWnd, _In_ int nCmdShow);
```

먼저 `ShowWindow()`는 이름 그래도, 우리가 생성한 윈도우를 보여주기 위해 (혹은 보여주지 않기 위해) 사용한다. 어떻게 보여줄지는 두 번째 인수인 `nCmdShow`에 의해 결정된다. 우리는 `WinMain()`함수가 넘겨받은 동일한 이름의 변수 `nCmdShow`의 값을 그대로 넘겨준다.

- `nCmdShow` 윈도우를 표시할 방법 (매크로)
  - `Cmd (command)` 
  - `show window`의 줄임말로 `SW_`가 붙은 매크로를 사용한다.

마지막으로 `UpdateWindow()`는 그려져야 할 윈도우가 있을 때, 그리라는 메시지인 `WM_PAINT`를 해당 윈도우로 보내주는 함수이다.

이제 윈도우 프로시저에서는 무슨 일을 하고 있나 살펴보자.

```cpp
LRESULT CALLBACK WndProc(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam)
{
	switch (Msg)
	{
	case WM_DESTROY:
		PostQuitMessage(0);
		return 0;
	}
	return DefWindowProc(hWnd, Msg, wParam, lParam);
}
```







클래스의 이름은 CDirectX이므로, 프로젝트 폴더 내에 Helper라는 이름의 폴더를 새로 만들고

그 안에 CDirectX.h와 CDirectX.cpp 파일을 생성하자.

CDirectX.h 파일을 열고 우선 windows.h 헤더 파일을 포함하자.

```cpp
#pragma once
#include <windows.h>
```

그리고 그 아래에 다음과 같이 클래스의 틀을 만들어 보자.

```cpp
class CDirectX final
{
public:
    CDirectX() {};
    ~CDirectX() {};
    
private:
    
};
```



### /Helper/CDirectX.h

```cpp
#pragma once

#include <windows.h>
#include <cassert>

class CDirectX
{
public:
	CDirectX() {};
	~CDirectX() {};

	void CreateMainWindow(HINSTANCE hInstance, int nShowCmd, int Width, int Height, WNDPROC WndProc, LPCTSTR Title);

private:
	HWND		m_hWnd{};
	HINSTANCE	m_hInstance{};
	int			m_WindowWidth{};
	int			m_WindowHeight{};
};
```



## #01. DirectX 11 초기화(Initialization)