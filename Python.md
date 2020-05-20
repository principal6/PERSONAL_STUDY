# python은 인터프리터 언어?

## 특징
- 세미콜론을 안 쓴다!
- 주석은 # 뒤에 혹은 ''' 사이에
- 여러 줄 문자열은 """ 사이에
- 거듭제곱 연산자 **가 있다!!
- 몫 연산자 //도 있다! (사실 정수형 나눗셈이라 보면 된다..)
- 들여쓰기로 코드 블록을 구분한다
- 명시적 자료형을 쓰지 않는다! (변수명 = 값)
```py
name = "김장원"
age = 30
print(name)
print(age)
print("이름은 " + name + "이고, 나이는 " + age + " 세 입니다.")
```

# 자료형
## 형변환
```py
age = 30
print("나이: " + str(age))
print(6/3) # 2.0 이 된다!

int()
str()
set()
# ...
```

## type() 자료형을 얻어온다!!

## 다중 선언, 대입
```py
a, b = 3, 5
a, b = b, a + b #5, 8이 될 것! 중간 결과가 반영되지 않는다!
```

## 연산자
```py
**
//
not and or
& |
```

## 문자/문자열
### 인덱스는 역시 0번부터 시작
```py
text = "abcdefg"
print(text[2])
print(text[2:4]) # 수학적, [2, 4)
print(text[:4]) # == [0, 4)
print(text[4:]) # == [4, 7)
print(text[-3:]) # == [7 - 3, 7) == [4, 7] == efg
```
### lower()
### upper()
### replace()
### isupper()
### islower()
### index("cmp")  앞에서부터 얻어오기 (없으면 오류!!!)
### index("cmp", offset)
### find()  못 찾으면 -1
### count()
### zfill()
```py
val = "123"
print(val.zfill(5))
```

## 리스트
### 다양한 자료형이 함께 쓰일 수 있다!!
```py
myList = ["a", "b", "c"]
```
### index()
### append()
### insert()
### pop()
### count()
### sort()
### reverse() 순서 뒤집기
### clear()
### extend() 리스트 합치기

## 사전 {키:값}
```py
dic = {13:"금요일", 30:"나이"}
```

## 튜플 (내용 변경이나 추가 불가!! but 빠름)
```py
tup = ("하나", "둘", "셋")
```

## 집합 (set, 중복 무시!)
```py
mySet = {1, 2, 3, 1, 2}
```
### 교집합 & == intersection()
### 합집합 | == union()
### 차집합 - == diference()
### add()
### remove()

# 함수
## print()
+로 문자열 합치기
,로 가변 인수도 가능 => 형변환 안 해도 되므로 더 편함!!!
### end=
```py
print("줄바꿈 없애기", end=" ")
print("가능합니다")
```
### sep=
```py
print("a", "b", "c", sep=" .. ", end="!!")
```
### 이스케이프 문자 \n \' \" \\ \r \b
### 플레이스 홀더도 가능 %d, %s, %c ...
```py
print("wow: %d" % 20)
print("first: %s second: %s" % ("일번", "이번"))
```
### 플레이스 홀더 v2 => {}
```py
print("먼저 {} 다음 {}".format("하나", "둘"))
print("먼저 {1} 다음 {0}".format("하나", "둘"))
print("먼저 {first} 다음 {second}".format(first="하나", second="둘"))
```
### 플레이스 홀더 v3
```py
First = "처음"
Next = "다음"
print(f"First= {First} Next= {Next}")
```
## input()
```py
val = input("이름을 알려주세요: ")
```
## len()
### 수학 함수
#### abs()
#### pow()
#### max() min()
#### round() 올림

## 파일
```py
localText = open("local.txt", "w") # 기본 인코딩으로 열린다 (윈도우즈니까 cp949)
localText.write("Yeah!")
localText.close()

with open("local.txt", "w") as localText: # with문을 벗어나면 자동 close()!!
    localText.write("Yeah!")
```

# 패키지, 모듈 사용
```py
from math import *
```
## math
### floor() ceil() sqrt()

## random
```py
from random import randrange
count = 10
while count > 0:
    print(randrange(1, 5))
    count -= 1
```
## sys
### argv
```py
import sys
print(f"argv[0] = {sys.argv[0]}")
```
### stdout stderr
```py
import sys
# 모드에는 "r" "w" "a" 가 있습니다 (a는 append!!)
sys.stderr = open("log.txt", "w", encoding="utf8") # 모드가 "w"이므로 파일이 없으면 생성된다!!
print("정상입니다", file=sys.stdout)
print("첫 에러 입니다..", file=sys.stderr)
print("또 에러 입니다!!!", file=sys.stderr)
```
## pickle (seralize, deserialize)
### pickle.dump()
### pickle.load()
## time

# 조건문
```py
val = 1
if val == 1:
    print("val은 1 이군요.")
elif val == 2:
    print("val이 2 군요?")
elif 3 <= val <= 6
    print("val은 3 이상 6 이하네요.")
else:
    print("val 값이 예상 밖이네요...")
```

# 반복문
```py
# 기본 for문
for elem in [1, 2, 3, 4]:
    print(f"각각 : {elem}")

# 한 줄 for문
myList = [2, 4, 6, 8, 10]
myList = [i * 10 for i in myList]
print(myList)

# 기본 while문
cmp = 5
while cmp > 0:
    print(f"cmp는 {cmp} 입니다.")
    cmp -= 1

# 무한 반복 while문
while True:
    print("무한 반복입니다")

continue
break
```

# 사용자 정의 함수
## 기본
```py
def myFunc():
    print("새 함수예요!")
    return 13

print(myFunc())
```
## 다중 리턴
```py
def makeHalf(value):
    halfValue = value // 2
    return halfValue, value - halfValue

org = 11
a, b = makeHalf(org)
print(f"{org}을 반으로 나누면 {a}, {b} 입니다")
```
## 가변인자
```py
def nameThings(*things):
    for thing in things:
        print(thing, end=" ")

nameThings("하나", "둘", "셋")
```
## 변수의 scope!
```py
def whatIs():
    global gVal
    print(gVal)

gVal = 11
whatIs()
```

# 클래스
```py
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
        self.reserved = 0
        print("클래스 Person이 생성되었습니다.")

    def getAge(self):
        return self.age

    def setAge(self, age):
        self.age = age
        print(f"나이가 {self.age}로 바뀌었습니다.")

class Student(Person):
    def __init__(self, name, age, schoolName):
        Person.__init__(self, name, age)
        self.schoolName = schoolName
        print("클래스 Student가 생성되었습니다.")

    def displaySchool(self):
        print(self.schoolName)

me = Person("김장원", 29)
print(me.getAge())
me.setAge(30)
print(me.getAge())
print(me.reserved)

you = Student("김학생", 14, "가나다중학교")
you.displaySchool()
```
## 상속
## 다중 상속 (, )
## 메소드 오버라이딩 (자식 클래스에서 같은 이름 쓰면 됨)
## pass 키워드
## super() 키워드

# 예외 처리
```py
class MyException(Exception):
    pass

class AnotherException(Exception):
    def __init__(self, msg)
        self.msg = msg

    def __str__(self):
        return self.msg

try:
    # ...
    raise ValueError
except ValueError:
    print("Value Error 군요!")
except ZeroDivisionError as e:
    print(e)
except Exception as e:
    print("무슨 예외일까요?", end=" ")
    print(e)
```

# 패키지, 모듈
폴더 이름이 패키지 이름
__init__.py
moduleName.py 모듈
otherModule.py

```py
import packageName.moduleName
from packageName import moduleName
from packageName.moduleName import functionName
```
## __init__.py
```py
__all__ = ["moduleNameA", "moduleNameB"]
```

## 모듈 직접 실행
```py
if __name__ == "__main__":
    print("모듈을 직접 실행했습니다")
else:
    print("모듈을 외부에서 실행했습니다")
```

# 기타
## dir() 변수와 함수..

# GUI 모듈 tkinter
```py
import tkinter
from tkinter import messagebox

myWindow = tkinter.Tk()
myWindow.title = "HI"
myWindow.geometry("640x480")

def onClick():
    messagebox.showinfo(title="오", message="버튼을 눌렀네요")

btn = tkinter.Button(myWindow, text="버튼이죠", command=onClick)
btn.pack()

myWindow.mainloop()
```

## 바인딩
```py
#왼쪽 마우스 버튼 바인딩
frame.bind("<Button-1>", click) 
"<Double-Button-1>"
"<Key>"
"<Return>"
focus_set()
```

# pygame 모듈