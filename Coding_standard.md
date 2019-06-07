# Coding standard

## 1. Class organization

- Public -> protected -> private

(Since most readers will be using the public interface of the class, that should be declared first, followed by the class's private implementation.)



## 2. Naming conventions

Normally the first letter of every name is capitalized  (e.g. ... )

Type and variable names are nouns



### 2-1. Namespace

```cpp
namespace JWEngine
{
	// ~~
};
```



### 2-2. Function

Method names are verbs that describe the method's effect, or describe the return value of a method that has no effect.

Use **camel case** (or **lower case with underscore)** for function names.

[Verb]

- `Clear()`
- `Create()` 
- `Update()`
- `Draw()`
- `Destroy()`
- `Get()`

[Verb + noun]

- `CalculateDistance(const Vector& v1, const Vector& v2)`
- `ClearAll()`
- `CreateBuffer()`
- `SetName(const char* Name)`
- `GetName()`
- `Get*Ptr()` / `Get*Ref()` ★★

**On-** `OnMouseDown()` `OnKeyUp()`



All functions that return a **bool** should ask a true/false question, such as

**Is-**  `IsDone()` `IsVisible()`

**Has-** `HasFocus()` `HasSelection()` 

**Does-** `DoesFileExist()`

**Should-** `ShouldClearBuffer()`

**Will-** `WillUseMultiline(bool Value)`

```cpp
// what does true mean?
bool CheckTea(FTea Tea);

// name makes it clear true means tea is fresh
bool IsTeaFresh(FTea Tea);
```



### 2-3. Variable/Struct/Class

All variables should be declared one at a time, so that a comment on the meaning of the variable can be provided.

- Enum flag -> **EFLAG-**

```cpp
enum EFLAGRenderOption : uint8_t
{
	JWFlagRenderOption_UseLighting = 0b1,
	JWFlagRenderOption_UseAnimationInterpolation = 0b10,
	JWFlagRenderOption_DrawNormals = 0b100,
	JWFlagRenderOption_DrawTPose = 0b1000,
};

using JWFlagRenderOption = uint8_t;

int main()
{
	using namespace std;
	
	JWFlagRenderOption opt = JWFlagRenderOption_UseLighting | JWFlagRenderOption_DrawNormals;
    
    // Toggle
    opt = opt ^ JWFlagRenderOption_DrawTPose;

	if (opt & JWFlagRenderOption_UseLighting)
	{
		cout << "JWFlagRenderOption_UseLighting" << endl;
	}

	if (opt & ~JWFlagRenderOption_UseAnimationInterpolation)
	{
		cout << "[NOT] JWFlagRenderOption_UseAnimationInterpolation" << endl;
	}

	if (opt & JWFlagRenderOption_DrawNormals)
	{
		cout << "JWFlagRenderOption_DrawNormals" << endl;
	}

	return 0;
}
```

- Enum class -> **E-**

```cpp
// enum class's default size = int (4 bytes)

enum class ERasterizerState : uint8_t
{
	WireFrame,
	SolidNoCull,
	SolidBackCullCCW,
	SolidBackCullCW,
};

enum class EComponentType : uint8_t
{
	Invalid,
	
	Transform,
	Physics,
	Render,
};
```

- Struct -> **S-**
- Interface -> I-

```cpp
float TeaWeight;
int32 TeaCount;
bool bDoesTeaStink;
FName TeaName;
FString TeaFriendlyName;
UClass* TeaClass;
USoundCue* TeaSound;
UTexture* TeaTexture;
```



## 3. Comments

- Write self-documenting code:

  ```cpp
  // Bad:
  t = s + l - b;
  
  // Good:
  TotalLeaves = SmallLeaves + LargeLeaves - SmallAndLargeLeaves;
  ```

- Write useful comments:

  ```cpp
  // Bad:
  // increment Leaves
  ++Leaves;
  
  // Good:
  // we know there is another tea leaf
  ++Leaves;
  ```

- Do not comment bad code - rewrite it:

  ```cpp
  // Bad:
  // total number of leaves is sum of
  // small and large leaves less the
  // number of leaves that are both
  t = s + l - b;
  
  // Good:
  TotalLeaves = SmallLeaves + LargeLeaves - SmallAndLargeLeaves;
  ```

- Do not contradict the code:

  ```cpp
  // Bad:
  // never increment Leaves!
  ++Leaves;
  
  // Good:
  // we know there is another tea leaf
  ++Leaves;
  ```