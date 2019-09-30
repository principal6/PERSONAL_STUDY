# Coding standard

## 1. Class organization

- public methods -> public members -> protected methods -> protected members -> private methods -> private members

(Since most readers will be using the public interface of the class, that should be declared first, followed by the class's private implementation.)



## 2. Naming conventions

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

Avoid using prepositions `int NumberOfUsers` => `int UserCount`

- bool variable names -> `b-`
- Enum class -> `E-`

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

- Enum class flag -> `EFlags-`

```cpp
#define ENUM_CLASS_FLAG(enum_type)\
static enum_type operator|(enum_type a, enum_type b)\
{\
	return static_cast<enum_type>(static_cast<int>(a) | static_cast<int>(b));\
}\
static enum_type& operator|=(enum_type& a, enum_type b)\
{\
	a = static_cast<enum_type>(static_cast<int>(a) | static_cast<int>(b));\
	return a;\
}\
static enum_type operator&(enum_type a, enum_type b)\
{\
	return static_cast<enum_type>(static_cast<int>(a) & static_cast<int>(b));\
}\
static enum_type& operator&=(enum_type& a, enum_type b)\
{\
	a = static_cast<enum_type>(static_cast<int>(a) & static_cast<int>(b));\
	return a;\
}\
static enum_type operator^(enum_type a, enum_type b)\
{\
	return static_cast<enum_type>(static_cast<int>(a) ^ static_cast<int>(b)); \
}\
static enum_type& operator^=(enum_type& a, enum_type b)\
{\
	a = static_cast<enum_type>(static_cast<int>(a) ^ static_cast<int>(b)); \
	return a; \
}\
static enum_type operator~(enum_type a)\
{\
	return static_cast<enum_type>(~static_cast<int>(a)); \
}

enum class EFlagsPosition
{
	None	= 0x00,
	Top		= 0x01,
	Bottom	= 0x02,
	Left	= 0x04,
	Right	= 0x08,
};
ENUM_CLASS_FLAG(EFlagsPosition)

int main()
{
	EFlagsPosition eFlagsPosition{ EFlagsPosition::Top | EFlagsPosition::Bottom };
	eFlagsPosition |= EFlagsPosition::Left;

	return 0;
}
```

- Struct -> `S-`

- Interface -> `I-`

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

### 2-4. Macro

Upper-case only & use underscore(_)



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

## 4. C++

### auto

Avoid using `auto` except for lamda, range-based for and template

### forward declaration

Prefer forward declaration to including a header

### variable

Declare a variable right before using it, whenever possible.

Use intermediate variables to avoid making expressions long. (Especially for `if` statements)

Always prefer `const` variables to literals

### function

Avoid doing multiple things in one function. Instead, divide it into multiple sub-functions

Avoid getting multiple parameters in a function. Instead, bind them into a `struct`.

### loop

Avoid calling the same function in a loop. Get it out of the loop.





## 5. File name

Avoid using prefix in file names?