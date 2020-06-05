# PRG

## version control
### SVN
 Subversion
 subversion.apache.org
### Perforce 퍼포스 (P4V)
 유료지만 좋은 듯... 

## compression
 반디집!

## script
 Lua // C++ (LLVM)

## dump
 HxD
 Excel => extract xml

## Visual Studio
### pdb (Program Database)
 https://docs.microsoft.com/ko-kr/visualstudio/debugger/debugger-tips-and-tricks?view=vs-2019#modules_window
 Stores debugging information about a program
 Created while compilation
 Contains symbols
 Default option is to name after each project
### pch (precompiled header)
 Usually `pch.h`
 Basically saying, "don't build the headers in this file, because they are already compiled"
 `pragma comment` in pch doesn't affect the files that includes the pch
### inl (inline ...)
 Usually to be used to contain definitions of inline functions or template definitions
### keyword
 `__super`
 `__noop`
 `nullptr`
 `noexcept`

### debugging
http://www.highprogrammer.com/alan/windev/visualstudio.html
#### project properties
>Debugging
>>Command Arguments
>>
>>Working Directory
#### output
>__LINE__
>__FILE__
`#define MY_TRACE(msg, ...) MyTrace(__LINE__, __FILE__, msg, __VA_ARGS__)`
#### 중단점 - 조건
#### thread
병렬 스택, 병렬 Watch
#### 진단 도구 - (스냅샷으로)메모리 증감 볼 수 있음

### extensions
Smart Command Line Arguments
Visual Assist (유료)

### 단축키
alt + * : 현재 IP 위치로
ctrl + shift + f: 모두 찾기★★
ctrl + g : 줄 이동★★
ctrl + shift + t: 파일로 이동★★
ctrl + shift + l: 줄 지우기
ctrl + j: 인텔리센스★★
ctrl + alt + j: 오브젝트 탐색기★
ctrl + r + w: 공백 보이기
ctrl + m + h: 선택 숨기기 ★
ctrl + k + k: 책갈피 설정/해제
ctrl + k + p/n: 책갈피 이동
ctrl + k + w: 책갈피 창
ctrl + k + s: 코드 감싸기



## C++ 팁
nullptr 검사가 비효율적일 수 있다... RAII를 잘 활용해보자

## Windows Command Prompt (cmd)
  `hostname`
  `ipconfig /all`

