# Operating System

알아야할 것

C언어, Assembly어(기계어와 일대일 대응됨!)

## 어셈블리어

Instruction Pointer(IP): 다음 실행할 명령어 위치가 저장됨?

cli == clear interrups

sti == enable interrupts

## OS가 하는 일

메모리 관리

시스템 리소스 관리

보안 - 접근 정책

프로세스와 스레드 스케쥴링

유저 프로그램 실행

유저 인터페이스 제공



## 커널 (kernel == 알맹이)

하드웨어 - 인터럽트 (하드웨어가 발생하는 이벤트) 처리, 이벤트 핸들러(== interrupt handler)

소프트웨어 (system call)

파일, 프로세스, 소켓, 디렉토리 등 abstraction 정의



## 셸 (shell == 껍데기)

유저의 명령어를 받음

디렉토리 내용 보기, 파일 옮기기 등

기능

- 자동 완성(auto completion): tab키로 보통..
- 문자 삽입(character insertion): 화살표 좌우키로 커서 이동
- 기록(history): 화살표 위아래키
- 스크롤(scrolling)
- 스크립트(scripting)

GUI (Graphical User Interface)

## Emulator 구하기

**Bochs**, Microsoft Virtual PC

Bochs Debugger



## 과정

BIOS -> Boot Loader -> Kernel

### BIOS (Basic Input Output System)

ROM 장치에 적재된 프로그램.. (읽기만 가능하다!)

Boot Disk의 **Boot Sector (Sector == 512 bytes)**에 있는 프로그램을 Load하고 그 첫 바이트로 jump한다.

## Boot Loader

OS를 로드한다 (결국 Kernel을 로드하고, Entry Point를 찾아 실행한다!)

단, Boot Loader는 flat binary program이어야 한다 (즉, entry point가 맨 앞 바이트다!) 이건 BIOS때문

따라서 Boot Loader의 앞부분(== Boot Code == Stage 1)은 C로 작성할 수 없다... Assembly로 해야만 한다!!! 그니까 그냥 다 Assembly로 하자.

 Interrupt Vector Table (IVT) 

BIOS will execute **Interrupt (INT) 0x19** to attempt to find a bootable device. (부트로더가 로드될 주소는 **0x7C00**)

부트로더의 511번째 바이트 값이 0xAA이고, 512번째 바이트 값이 0x55면 부팅 가능하다는 뜻!! == Boot Signature

### PAS (Physical Address Space)

Physical Memory (RAM), ROM, 각종 하드웨어 장치 등 모두 다 포함! 즉, 주소가 항상 메모리만 가리키는 게 아니다!!!

