# DirectX 11 3D Game Programming Tutorial

## ## Environment

Period:  `2019. 09. 29. ~`

IDE: Visual Studio 2019

Library: DirectXTK x86=>x64 (2019. 08. 21. ver.), Assimp x64 (2019. 10. 01. ver.)



## #01. Game window creation

```cpp
#Core
##CGameWindow(+★) - Window, DirectX
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
##CGameWindow (+=★ DepthStencilBuffer)
##CShader(+★)
##CObject3D (+=★ VertexBuffer, IndexBuffer)
##SharedHeader.h(+★)
#DirectXTK(+★)
#Shader
##Header.hlsli(+★)
##VertexShader.hlsl(+★)
##PixelShader.hlsl(+★)
```



## #03. Cameras and inputs

Constant buffer - World, View, Projection

```
#Core
##CGameWindow (+=★ Camera, WVP, Keyboard, Mouse)
##CShader
##CObject3D
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
##CGameWindow (+=★ CommonStates, SpriteBatch, SpriteFont)
##CShader
##CObject3D
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
##CGameWindow (+=★ CGameObject)
###CShader
###CObject3D
###CGameObject(+★)
##SharedHeader.h
##PrimitiveGenerator.h(+★)
#DirectXTK
#Shader
##Header.hlsli
##VertexShader.hlsl
##PixelShader.hlsl
```



## #06. Texture and blending

CTexture

```
#Core
##CGameWindow
###CShader
###CObject3D
###CTexture(+★)
###CGameObject
##SharedHeader.h
##PrimitiveGenerator.h
#DirectXTK
#Shader
##Header.hlsli
##VertexShader.hlsl
##PixelShader.hlsl
```



## #07. Geometry shader normal drawing

```
#Core
##CGameWindow
###CShader
###CObject3D
###CTexture
###CGameObject
##SharedHeader.h
##PrimitiveGenerator.h (+=★)
#DirectXTK
#Shader
##Header.hlsli
##VertexShader.hlsl
##PixelShader.hlsl
##GeometryShader.hlsl(+★)
```

Geometry Shader - Normal vector drawing

GS Syntax

Normal averaging★

```
#include "Header.hlsli"

[maxvertexcount(2)]
void main(point VS_OUTPUT input[1], inout LineStream<VS_OUTPUT> output)
{
	VS_OUTPUT element;

	element = input[0];
	element.Color = float4(1, 1, 0, 1);
	output.Append(element);

	element.Position += input[0].WVPNormal;
	element.Color = float4(1, 0, 1, 1);
	output.Append(element);

	output.RestartStrip();
}

point ~ input[1] // D3D11_PRIMITIVE_TOPOLOGY_POINTLIST★
line ~ input[2] // D3D11_PRIMITIVE_TOPOLOGY_LINESTRIP★★
triangle ~ input[3]
lineadj ~ input[4]
triangleadj ~ input[6]

inout LineStream<~> output
inout TriangleStream<~> output
```

 

## #08. Mini axes drawing

```
#Core
##CGameWindow (+=★)
###CShader
###CObject3D
###CTexture
###CGameObject
##SharedHeader.h
##PrimitiveGenerator.h
#DirectXTK
#Shader
##Header.hlsli
##VSBase.hlsl
##PSBase.hlsl
##GSNormal.hlsl
##PSNormal.hlsl (+=★)
```



## #09. Ambient and directional light

```
#Core
##CGameWindow (+=★)
###CShader
###CObject3D
###CTexture
###CGameObject (+=★SComponentRender::SMaterial)
##SharedHeader.h
##PrimitiveGenerator.h
#DirectXTK
#Shader
##Header.hlsli
##VSBase.hlsl
##PSBase.hlsl
##GSNormal.hlsl
##PSNormal.hlsl
```

Lighting에서 중요한 건 Normal 정보!

Vertex Normal => Normal Averaging 자체로도 괜찮지만

Normal mapping을 활용하면 픽셀 단위로 노멀 값을 지정 가능하다!!★

Specular(거울의) 

Specular highlight (거울의 밝은빛)

### Phong reflection model

- Illumination = Ambient + Diffuse + Specular
- $I = k_aI_a + k_dI_l(N \bull L)+k_sI_l(R \bull V)^n$



### Blinn-Phong shading model

* specular 테두리가 조금 더 부드럽다

- Halfway vector, Normal vector
- $I = k_aI_a + k_dI_l(N \bull L)+k_sI_l(N \bull H)^n$



## #10. Mesh and material

```
#Core
##CGameWindow
###CShader
###CObject3D (+= ★SMesh, SMaterial, SMeshBufers)
###CTexture
###CGameObject (-= SComponentRender::SMaterial)
##SharedHeader.h
##PrimitiveGenerator.h
#DirectXTK
#Shader
##Header.hlsli
##VSBase.hlsl
##PSBase.hlsl
##GSNormal.hlsl
##PSNormal.hlsl
```



## #11. Assimp static model loading

```
#Core
##CGameWindow
###CShader
###CObject3D (+= ★SModel)
###CTexture
###CGameObject
##SharedHeader.h
##PrimitiveGenerator.h
##AssimpLoader.h(+★)
#DirectXTK
#Shader
##Header.hlsli
##VSBase.hlsl
##PSBase.hlsl
##GSNormal.hlsl
##PSNormal.hlsl
```



## #12. Assimp animated model loading

Use multiple vertex buffer (one for mesh, the other for rigging)

Bone offset : Vertex (Local space -> Bone space)

aiNode - transformation matrix (node space -> parent node space)

Node $\supset$ Bone

LoadNodes() => LoadMeshesFromNodes()

```
#Core
##CGameWindow
###CShader
###CObject3D
###CTexture
###CGameObject
##SharedHeader.h
##PrimitiveGenerator.h
##AssimpLoader.h
#DirectXTK
#Shader
##Header.hlsli
##VSBase.hlsl
##VSAnimation.hlsl(+★)
##GSNormal.hlsl
##PSBase.hlsl
##PSNormal.hlsl
```



```cpp
static void SerializeNodes(const vector<SModelNode>& vNodes, uint32_t NodeIndex, uint32_t Depth, string& SerializedString)
{
	for (uint32_t i = 0; i < Depth; ++i)
	{
		SerializedString += "_ ";
	}

	auto& Node{ vNodes[NodeIndex] };
	SerializedString += "[" + to_string(Node.Index) + "]";
	SerializedString += "[" + Node.Name + "]";
	if (Node.ParentNodeIndex != -1) SerializedString += "[Parent: " + to_string(Node.ParentNodeIndex) + "]";
	if (Node.bIsBone) SerializedString += "[Bone: " + to_string(Node.BoneIndex) + "]";
	SerializedString += '\n';

	for (auto& iChild : Node.vChildNodeIndices)
	{
		SerializeNodes(vNodes, iChild, Depth + 1, SerializedString);
	}
}
```

```cpp
static string SerializeXMMATRIX(const XMMATRIX& Matrix)
{
	string Result{};

	for (int iRow = 0; iRow < 4; ++iRow)
	{
		Result += '\t';
		for (int iCol = 0; iCol < 4; ++iCol)
		{
			Result += "[" + to_string(Matrix.r[iRow].m128_f32[iCol]) + "]";
		}
		Result += '\n';
	}
	Result += '\n';

	return Result;
}
```

```cpp
string SerializedWeights{ BoneNode.Name + '\n' };
for (unsigned int iWeight = 0; iWeight < aiBone->mNumWeights; ++iWeight)
{
    SerializedWeights += "[Vertex: " + to_string(aiBone->mWeights[iWeight].mVertexId) + "]";
    SerializedWeights += "[" + to_string(aiBone->mWeights[iWeight].mWeight) + "]\n";
}
```



## #13. Sky and time

구름은 따로 vertex 만들어 하늘은 하늘색, 구름은 계속 움직이게, 하늘 색도 계속 변하게!

구름 일단 하나만 해서 테스트!

해랑 달도 따로 vertex?  -> 시간에 따라 원으로 회전하도록!!

```
#Core
##CGameWindow
###CShader
####CConstantBuffer(+★)
###CObject3D
###CTexture
###CGameObject
##SharedHeader.h
##PrimitiveGenerator.h (+= ★)
##AssimpLoader.h
#DirectXTK
#Shader
##Header.hlsli
##VSBase.hlsl
##VSAnimation.hlsl
##VSSky.hlsl(+★)
##GSNormal.hlsl
##PSBase.hlsl
##PSNormal.hlsl
##PSSky.hlsl(+★)
```



## #14. Picking

bounding sphere picking

(static model) triangle picking

```
#Core
##CGameWindow
###CShader
####CConstantBuffer
###CObject3D
###CObjectLine
###CTexture
###CGameObject [+= SComponentPhysics, SBoundingSphere]
##SharedHeader.h
##PrimitiveGenerator.h
##AssimpLoader.h
##(+★)Math.h
#DirectXTK
#Shader
##Header.hlsli
##VSBase.hlsl
##VSAnimation.hlsl
##VSSky.hlsl
##(+★)VSLine.hlsl
##GSNormal.hlsl
##PSBase.hlsl
##PSNormal.hlsl
##PSSky.hlsl
##(+★)PSLine.hlsl
```



## #15. 2D drawing (+ 설계 구조 정리)

```
#Core
##CGame
###CShader
####CConstantBuffer
###CObject3D
###(+★)CObject2D
###CObject3DLine
###CCamera
###CTexture
###CGameObject3D
###(+★)CGameObject2D
###(+★)CGameObject3DLine
##SharedHeader.h
##PrimitiveGenerator.h
##(+★)Serialization.h
##AssimpLoader.h
##Math.h
#DirectXTK
#Shader
##Header.hlsli
##(+★)Header2D.hlsli
##VSBase.hlsl
##(+★)VSBase2D.hlsl
##VSAnimation.hlsl
##VSSky.hlsl
##VSLine.hlsl
##GSNormal.hlsl
##PSBase.hlsl
##(+★)PSBase2D.hlsl
##PSVertexColor.hlsl
##PSSky.hlsl
##PSLine.hlsl
```



## #16. 3D gizmos

```
#Core
##CGame [+=★]
###CShader
####CConstantBuffer
###CObject3D
###CObject3DLine
###CObject2D
###CCamera
###CTexture
###CGameObject3D
###CGameObject3DLine
###CGameObject2D
##SharedHeader.h
##PrimitiveGenerator.h [+=★]
##Serialization.h
##AssimpLoader.h
##Math.h
#DirectXTK
#Shader
##Header.hlsli
##Header2D.hlsli
##VSBase.hlsl
##VSBase2D.hlsl
##VSAnimation.hlsl
##VSSky.hlsl
##VSGizmo.hlsl
##VSLine.hlsl
##GSNormal.hlsl
##PSBase.hlsl
##PSBase2D.hlsl
##PSVertexColor.hlsl
##PSSky.hlsl
##PSGizmo.hlsl
##PSLine.hlsl
```



## ## Height-map level editor





## # Height-map terrain & normal mapping



## # Frustum culling



## # Animation interpolation and GPU skinned animation

## # Reflection (water, mirror)

## # RTT(Render to texture)

## # Billboarding???

## # Collision - Collision mesh★