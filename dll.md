# DLL (Dynamic-Link Library, 동적 연결 라이브러리)
https://docs.microsoft.com/ko-kr/cpp/build/dlls-in-visual-cpp?view=vs-2019

## DLL 만들기 튜토리얼
https://docs.microsoft.com/ko-kr/cpp/build/walkthrough-creating-and-using-a-dynamic-link-library-cpp?view=vs-2019

## 기초
DllMain()이 필요하다.
이름을 통해 변수, 함수, 리소스를 내보낸다(export)
정적 라이브러리(link time에 연동)와 달리 DLL은 load-time이나 run-time에 연동될 수 있다!

```cpp
BOOL APIENTRY DllMain(HMODULE hModule, DWORD  reasonForCall, LPVOID reserved)
{
    switch (reasonForCall)
    {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}
```

## 헤더 파일 정의
```cpp
// header 파일
#ifdef MY_DLL_EXPORT
#define MY_DLL_API extern "C" __declspec(dllexport)
#else
#define MY_DLL_API extern "C" __declspec(dllimport)
#endif

MY_DLL_API int foo();
```

## 변수 / 상수 정의
```cpp
// header 파일 (선언)
MY_DLL_API const int kMyNumber;
MY_DLL_API const int gOtherNumber;

// cpp 파일 (정의)
MY_DLL_API const int kMyNumber = 1991;
MY_DLL_API const int gOtherNumber;
```

## .Net용
https://docs.microsoft.com/ko-kr/cpp/build/calling-dll-functions-from-visual-basic-applications?view=vs-2019
