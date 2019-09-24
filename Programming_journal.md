# 개발 일지

## 2019-09-23

### NeonInvader && DirectX11Tutorial

- Draw()관련 설정은 CEntityPool이 아니라 CEntity에서 해야 순서 마음대로 조정 가능!! -> 아예 CObject2D로 내리자!
- CTexture가 CEntity에 종속되면 불필요한 중복 생성 발생함! -> CTexturePool에서 관리 -`AddSharedTexture(), GetSharedTexture()`
- CObject2D, CEntity
  - CEntity말고 CObject2D가 CTexture* 를 멤버로 갖고 있으면 좋을 듯! (게임 엔터티만 텍스처가 필요한 게 아니므로...) `SetTexure()` 포함
  - `CreateRectangle(), SetRectangleUVRange()`도 CEntity가 아니라 CObject2D에 들어가야 할 듯! (위와 같은 이유)
  - 그럼 결론적으론... CEntity가 CObject2D의 child class인 편이 나을 듯.
- CObject2D - `CreateStatic(), CreateDynamic()`보다 `Create(bool IsDynamic)` 이 낫다! (안 그러면 `CreateStaticRectangle(), CreateDynamicRectangle()`처럼 파생되는 모든 함수들을 두 개로 나누어야 한다... 끔찍)

## 2019-09-24

### 한글 char 코드 분석

```cpp
int h{ '가' }; // '가' == -20319
int l{ ((h << 16) >> 16) >> 8 };
int r{ (h << 24) >> 24 };

char ko[3]{ (char)l, (char)r, '\0' };
```

```cpp
int ints[2354]{};
for (int i = 0; i < (int)text.length(); ++i)
{
    char& c{ text[i] };

    unsigned int r{ (unsigned int)c };
    if (i % 2 == 0)
    {
        ints[i / 2] = c << 8;
    }
    else
    {
        r = (r << 24) >> 24;
        ints[i / 2] |= r;
    }
}
```

### NeonInvader && DirectX11Tutorial

- SetAnimation(): Fx의 경우 강제로 처음부터 애니메이션을 시작해야할 일이 있으므로 bool ForcedSet = false 매개변수를 추가하자.
- CreateRectangle() 기본 옵션은 가운데 정렬된 직사각형이지만, offset이 필요한 경우도 있으므로 오버로딩 실시