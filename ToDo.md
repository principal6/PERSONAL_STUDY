# 아이디어
## 인디 게임 개발자들 - 프로그래머, 아티스트, 기획자 등등이 자유롭게 모여서 이야기나누고 팀 이룰 수 있는 커뮤니티/앱이 있으면 진짜 진짜 좋겠다!

## 게임 - 로봇 디스토피아
로봇 세상 -> 처치하면 최근 10 frame visual memory 볼 수 있음 (이거 저장하려면 해상도가 낮아야할 듯.. 단순화해서 저장!?)
주인공도 로봇이고 처음에 저해상도 메모리로 시작하면 재밌을 듯..!!
그래서 직접 눈으로 본 장소는 view frustum을 통해 미니맵으로 제작되게!!

## 게임 아이디어
 - 생존, 건설, 샌드박스형 (AI 개개인이 중요, 농사, 목축 등 중요) + 적 개념 있으면 더 좋지... 신 놀이
   (신의 권능...)
 - 자동화 필요 (배속도 필수 x1, x2, x3, x4, x8 등등) => 시간은 어느 길이로 짤까??
 - 낮밤, 계절, 날씨 필요
 - 자유도! 넓은 지도...
 - 랜덤 생성 (매번 할 때마다 새로운 느낌이 들게 해야 한다!!)
 - 초반 시작이 너무 어렵지 않게... 그럼 게임 다시 안 하게 된다...
   (난이도 조절 가능하게...)
 - 저장 불러오기 잘 되게 하자
 - 자체 도전과제 + 보상 으로 성취감 획득

## 자료구조, 알고리즘 C++로 책 만들기!★★★


# 공부할 것
캐릭터가 큰 오브젝트에 가려지지 않게 하려면 -> Ray와 오브젝트 충돌 검사 or 카메라 이동
거울 렌더링...
HUD Heads-Up Display
particle... (연기, 불, 비, 폭발!!★ ...)
compute shader
frustum culling (tess)
occlusion culling
distance culling
checkerboarding
direc-delta function
error function(erf)
Quasi Monte Carlo (QMC)
frustum culling on CPU
light emission + bloom
Signed distance field (SDF)
Text rendering using signed distance field!!★
Signed distance field modeling -> 기본적으로 조각에 가까움!★
RTX
SDF -> Sphere-tracing
 => 문제는 texture read가 너무 많아.. (texture cache를 사용해도;)
Voxel cone tracing 
 => 얘도 마찬가지... 특히 확대 시 깨지니 문제
implicit geometry + ray tracing은 어때???
Ray tracing? Ray marching? Path tracing?

# 만들고 싶은 프로그램
https://www.desmos.com/calculator/nygwcuq0pp

## ByteCounter
selection
count of chars
count of bytes

## SplineViewer
2차원, 3차원 control point와 curved surface 표현하는 프로그램 만들자!!★★

## SimpleEditor
글씨체는 Consolas!!

### 이게 먼저다... reflection을 위해
범용 tokenizer, pareser, syntaxtree 만들자!!!
 => c언어, python, visual basic? 등등...

### reflection이 있다면 아래가 가능..
struct 이용한 (de)serialization
 => pack 없이!? == implicit padding 지원해야 함
 => offsetof 필요
struct
{
	uint16_t a;
	uint32_t b;
	uint32_t c;
};
 => BITMAP 열어보자!!!★


Inspired by [Simone Giertz]
Let's build some small, useless programs!!!

## Vector calculator (with visualization)
 - standard vector & located vector
=> 수학 기본 (특히 벡터, 행렬) 시각화 프로그램 만들자!!!
   (일단 벡터부터, 행렬은 특히 회전 행렬!)

## 그래프
### 필요 기능
그래핑 + 계산기!!
#component!!! => 점(벡터), 매개변수(t) => 이거면 베지에 곡선도 표현 가능!
#복소평면!! (매개변수?)
 => y = z^2
(굵은) (화살표) (곡)선
3차원 그리드?
#투영?/정사영 모드
#오른손좌표계
매개변수가 포함된?  함수 (parametric functions)
조각마다 정의된? 함수 (piecewise functions)
명령어: '+' '-' '*' '/' '^' 'int' 'sqrt' 'nthroot' 'sum' 'pi' 'theta' 'e' 'ln'
spheroid -> eccentricity까지 계산해주는 거 만들자~

2차원 그래프 (데카르트 평면)
y=x^2 => 곡선 (굵기2~3, 색깔)
축 => 직선 (검정, 굵기1)
그리드 => 직선 (회색, 굵기1 + 알파)
x^(2)+y^(2)<1 => 점선 + 도형

3차원 그래프
y=x^2 => 곡면!! + 곡선


## BytePad (just bytes, cuz it's cool!!)
 - ImGui로 만들자!!!! (빠르고 좋잖아)
 - New
 - Open
 - Save
 - Line index, Byte offset
 -- Side Panel
  - File length (byte)
  - Number(Int/Float) view
  - Character(ASCII/UTF8) view
 - Number converter
 - Character converter

## NameChanger ??
## IPChatter (just sending & recieveing messages if you know IP address)
 - My IP
 - Connect
 - Chat
 - sending byte data? + public key encryption

## ScreenShooter (w/ timer)

## 바탕화면에서 ?? 키우기 게임

### REALLY REALLY SIMPLE GRAPHICS COMPILER LANGUAGE!!!!★★
 - 기본 에디터 제공
 - 윈도우 생성 - 항상 창모드, 해상도 고정?(800x600)
 - 마우스 입력
 - 키보드 입력 (빠른 입력 / 느린 입력-WM_CHAR)
 - 글자 그리기 (BMFont)
 - 기본 함수 (타이머, 랜덤)
 - 사용자 정의 함수
 - 사용자 정의 자료형 (struct, enum ...)
 - 점 찍기 (particle)
 - 선 그리기
 - 삼각형 그리기 (+투명도)
 - png 그리기?
 - 음악 파일 재생 (여러 채널 동시에)
 - (네트워크) - 중급 기능...
 - (셰이더?????) - 고급 기능...
=> 사람들이 자신만의 프로그램을 쉽게 만들 수 있게!!

### 모든 프로그래머의 생산성 높이기 ###
(언어별로) 자신이 썼던 알고리즘/코드를 모아두고 관리할 수 있는 프로그램 만들자!!
=> 무엇이 프로그래머의 생산성을 떨어뜨리나?? 고민해보자
  = 함수/변수 작명!!!★ (기록 모아두자)


==========
 게임 요소

 게임 외 요소
 커뮤니티 (사람들과의 소통!!! - 채팅 시스템, 그룹, 길드 등.. 게임 내 뉴스?)




# NEW LANGUAGE
=== 언어명: won ?? ===

preprocessor - 파일 합치기, 매크로 변환

compiler - 구문 분석, 오류 찾기, assert?
 (Source Language -> Target Language)
 TL을 C로 할까? Assembly로 할까? => CPP로 하자!!!! cl.exe로 optimize 켜서 컴파일하자
 symbol table 작성
 front end = analysis
 back end = synthesis

JAVA는 just-in-time compiler 활용해서 조금이나마 빠르게 실행;

!!!반드시 반드시!!! reflection 기능 있어야.... serialization & deserialization이 편해진다 ㅠㅠ

===========
윈도우 만들기
그래픽 프로그래밍 쉽게...

클래스와 상속
 => runtime type check?

include 없게! import/use/link/...
멤버 접근은 .으로 통일
포인터 필수 <- 메모리 누수 어떻게 할까

$$$ 기본 인코딩을 utf-8로 하자!!!!

$$$ function
 함수 리턴값 여러 개 가능하게 하자 (error 코드 관리! exception 불필요)
 threaded 제약어를 넣을까? (global 변수에 쓰기 작업하면 오류!)

$$$ unnamed function
 함수 내에서 함수 선언하면 inline화... 하지만 두 번 이상 호출하면? 그냥 scope만 줄어든 free function?
 아니 inline은 명시할 때만 그렇게 할까

$$$ lifecycle과 scope 정하는 게 중요..!!

$$$ pointer
 owning
 function pointer ..?

$$$ namespace
 
=====
bool => true / false
int8
int16
int = int32 ★
int64
uint8
uint16
uint = uint32
uint64
float = float32
double = float64
pointer... => null
char(==uint8)
string   => utf8 사용하자 (단, 한 글자가 1byte가 아닐 수 있음에 유의!!!)
struct
class
enum
bitflag ★
$$$ type conversion rule...
===
this ???
===
getbit(0) // index
범위기반 반복문에서 index 알아낼 수 있게 해주자!!!!★
to_string 어떻게 할까.... to_int32나 to_float 등은...?
=== operator
a+b
a-b
a*b
a/b
a%b
++a
--b

