# DirectX 11 3D Game Programming Tutorial

## ## Environment

Period:  `2019. 09. 29. ~`

IDE: Visual Studio 2019

Library: DirectXTK (2019. 08. 21. ver.)



## #01. Game window creation

```cpp
#Core
##CGameWindow - Window, DirectX
```

```cpp
// CGameWindow
public:
	void CreateWin32(WNDPROC WndProc, LPCTSTR WindowName, bool bWindowed);

	void BeginRendering(const FLOAT* ClearColor);
	void EndRendering();

private:
	void CreateWin32Window(WNDPROC WndProc, LPCTSTR WindowName);
	void InitializeDirectX(bool bWindowed);

private:
	void CreateSwapChain(bool bWindowed);
	void CreateSetRenderTargetView();
	void SetViewports();

private:
	HWND		m_hWnd{};
	HINSTANCE	m_hInstance{};
	XMFLOAT2	m_WindowSize{};

private:
	ComPtr<IDXGISwapChain>			m_SwapChain{};
	ComPtr<ID3D11Device>			m_Device{};
	ComPtr<ID3D11DeviceContext>		m_DeviceContext{};
	ComPtr<ID3D11RenderTargetView>	m_RenderTargetView{};
```



## #02. Drawing a rectangle

SVertex3D, STriangle

Vertex buffer and index buffer (+ Shader, Depth-stencil buffer)

```cpp
#Core
##CGameWindow - Window, DirectX(+= DepthStencilBuffer)
##CShader - HLSL Shader
##CObject3D -> 3D rendering object (+= VertexBuffer, IndexBuffer)
##SharedHeader.h
#DirectXTK
#Shader
##Header.hlsli
##VertexShader.hlsl
##PixelShader.hlsl
```



## #03. Cameras and inputs

Constant buffer - World, View, Projection

```
#Core
##CGameWindow - Window, DirectX(+= Camera, WVP, Keyboard, Mouse)
##CShader - HLSL Shader
##CObject3D -> 3D rendering object
##SharedHeader.h
#DirectXTK
#Shader
##Header.hlsli
##VertexShader.hlsl
##PixelShader.hlsl
```



## #04. Drawing text

MakeSpriteFont

DepthStencilState

```
#Core
##CGameWindow - Window, DirectX(+= CommonStates, SpriteBatch, SpriteFont)
##CShader - HLSL Shader
##CObject3D -> 3D rendering object
##SharedHeader.h
#DirectXTK
#Shader
##Header.hlsli
##VertexShader.hlsl
##PixelShader.hlsl
```



## #05. 3D primitive generation

PrimitiveGenerator.h

CGameObject - SComponentTransform(Translation, rotation, scaling), SComponentRender(SObject3DData)

```
#Core
##CGameWindow - Window, DirectX(+= CGameObject)
###CShader - HLSL Shader
###CObject3D - 3D rendering object
###CGameObject 
##SharedHeader.h
##PrimitiveGenerator.h
#DirectXTK
#Shader
##Header.hlsli
##VertexShader.hlsl
##PixelShader.hlsl
```



## // # Dynamic vertex buffer...?



## #06. Texture and blending

CTexture

```
#Core
##CGameWindow
###CShader
###CObject3D
###CTexture(+)
###CGameObject
##SharedHeader.h
##PrimitiveGenerator.h
#DirectXTK
#Shader
##Header.hlsli
##VertexShader.hlsl
##PixelShader.hlsl
```



## #07. SkySphere and time flow

멋진 하늘은 나중에...?

## #08. HLSL - Ambient light

## #09. HLSL - Directional light

### 2D Drawing???

### Assimp static model loading

### Assimp dynamic model loading

### GPU skinned animation -> multiple vertex buffer (for rigging)

### Picking and bounding volume(sphere)

### Height-map terrain & normal mapping

### Frustum culling

### Reflection (water, mirror)

### RTT(Render to texture)

### Billboarding???