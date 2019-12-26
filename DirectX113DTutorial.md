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

clock-wise winding이 앞면! CullCounterClockwise가 기본값이겠군..

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

```
/Sharp
/FontStyle:Bold

MakeSpriteFont "돋움체" dotumche_10_korean.spritefont /FontSize:10 /CharacterRegion:0x0-0xFF /CharacterRegion:0xAC00-0xD7AF /FastPack
MakeSpriteFont "D2Coding" d2coding_10_korean.spritefont /FontSize:10 /CharacterRegion:0x0-0xFF /CharacterRegion:0xAC00-0xD7AF /FastPack

0x0000-0x00FF
유니코드 한글 총 11172자 0xAC00 [가] ~ 0xD7A3 [힣]


```

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



## ##. Height-map terrain editor

### ImGui 기본

```cpp
#include "imgui.h"
#include "imgui_impl_win32.h"
#include "imgui_impl_dx11.h"
```

```cpp
IMGUI_CHECKVERSION();
ImGui::CreateContext();
ImGui::StyleColorsDark();
ImGui_ImplWin32_Init(Game.GethWnd());
ImGui_ImplDX11_Init(Game.GetDevicePtr(), Game.GetDeviceContextPtr());

ImGuiIO& igIO{ ImGui::GetIO() };
igIO.Fonts->AddFontDefault();
ImFont* igFont{ igIO.Fonts->AddFontFromFileTTF("Asset/D2Coding.ttf", 16.0f, nullptr, igIO.Fonts->GetGlyphRangesKorean()) };
```

```cpp
ImGui_ImplDX11_NewFrame();
ImGui_ImplWin32_NewFrame();
ImGui::NewFrame();

ImGui::PushFont(igFont);

{
    static float f{};
    static int counter{};

    if (ImGui::Begin("Hello, world!"))
    {
        ImGui::Text("This is some useful text.");
        ImGui::SliderFloat("float", &f, 0.0f, 1.0f);
        if (ImGui::Button("Button")) counter++;
        ImGui::SameLine();
        ImGui::Text("counter = %d", counter);
	}

    ImGui::End();
}

ImGui::PopFont();

ImGui::Render();
ImGui_ImplDX11_RenderDrawData(ImGui::GetDrawData());
```

```cpp
ImGui_ImplDX11_Shutdown();
ImGui_ImplWin32_Shutdown();
ImGui::DestroyContext();
```

```cpp
LRESULT WINAPI WndProc(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
    if (ImGui_ImplWin32_WndProcHandler(hWnd, msg, wParam, lParam))
        return true;

    switch (msg)
    {
    case WM_SYSCOMMAND:
        if ((wParam & 0xfff0) == SC_KEYMENU) // Disable ALT application menu
            return 0;
        break;
    case WM_DESTROY:
        ::PostQuitMessage(0);
        return 0;
    }
    return ::DefWindowProc(hWnd, msg, wParam, lParam);
}
```

### Auto-generate MipMaps ★

```cpp
wstring wFileName{ m_TextureFileName.begin(), m_TextureFileName.end() };
ComPtr<ID3D11Texture2D> NonMipMappedTexture{};
CreateWICTextureFromFile(m_PtrDevice, wFileName.c_str(), (ID3D11Resource**)NonMipMappedTexture.GetAddressOf(), nullptr);

D3D11_TEXTURE2D_DESC Texture2DDesc{};
NonMipMappedTexture->GetDesc(&Texture2DDesc);
Texture2DDesc.BindFlags = D3D11_BIND_SHADER_RESOURCE | D3D11_BIND_RENDER_TARGET; // D3D11_RESOURCE_MISC_GENERATE_MIPS와 반드시 같이 쓰여야 한다!★
Texture2DDesc.CPUAccessFlags = 0;
Texture2DDesc.MipLevels = 0; // MipLevels가 0이어야 MipLevels를 계산해 준다! (MipLevels가 1이면 가장 큰 텍스쳐 하나만 쓴다는 뜻이므로)
Texture2DDesc.MiscFlags = D3D11_RESOURCE_MISC_GENERATE_MIPS;
Texture2DDesc.Usage = D3D11_USAGE_DEFAULT;

assert(SUCCEEDED(m_PtrDevice->CreateTexture2D(&Texture2DDesc, nullptr, m_Texture2D.GetAddressOf())));

m_PtrDeviceContext->ResolveSubresource(m_Texture2D.Get(), 0, NonMipMappedTexture.Get(), 0, Texture2DDesc.Format); // MipMap이 없는 텍스쳐를 MipMap이 있는 텍스쳐로 복사해야 하므로 CopyResource()를 사용할 수 없다. (0번 텍스쳐 == 가장 큰 텍스쳐가 복사된다.)

m_PtrDevice->CreateShaderResourceView(m_Texture2D.Get(), nullptr, m_ShaderResourceView.GetAddressOf());

m_PtrDeviceContext->GenerateMips(m_ShaderResourceView.Get()); // 0번 텍스쳐를 기반으로 크기를 절반씩 줄이면서 텍스쳐를 생성해 준다.
```



## ##. Height-map terrain tessellation

```c
// Flat Bezier triangle
[domain("tri")]
DS_OUTPUT main(HS_CONSTANT_DATA_OUTPUT TessFactors, float3 Domain : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 3> Patch)
{
	DS_OUTPUT Output;

	float4 b300 = Patch[0].WorldPosition;
	float4 b030 = Patch[1].WorldPosition;
	float4 b003 = Patch[2].WorldPosition;

	float4 b210 = (b300 * 2.0f + b030) / 3.0f;
	float4 b201 = (b300 * 2.0f + b003) / 3.0f;

	float4 b120 = (b300 + b030 * 2.0f) / 3.0f;
	float4 b102 = (b300 + b003 * 2.0f) / 3.0f;

	float4 b111 = (b300 + b030 + b003) / 3.0f;

	float4 b021 = (b030 * 2.0f + b003) / 3.0f;
	float4 b012 = (b030 + b003 * 2.0f) / 3.0f;

    float u = Domain.x;
	float v = Domain.y;
	float w = Domain.z;
	float4 Bezier = pow(u, 3) * b300 +
		3 * pow(u, 2) * v * b210 +
		3 * pow(u, 2) * w * b201 +
		3 * u * pow(v, 2) * b120 +
		3 * u * pow(w, 2) * b102 +
		6 * u * v * w * b111 +
		pow(v, 3) * b030 +
		3 * pow(v, 2) * w * b021 +
		3 * v * pow(w, 2) * b012 +
		pow(w, 3) * b003;

	//Output.WorldPosition = Patch[0].WorldPosition * Domain.x + Patch[1].WorldPosition * Domain.y + Patch[2].WorldPosition * Domain.z;
	Output.WorldPosition = Bezier;

	Output.Position = Output.WorldPosition;
	Output.Position = mul(float4(Output.Position.xyz, 1.0f), VP);

	Output.Color = Patch[0].Color * Domain.x + Patch[1].Color * Domain.y + Patch[2].Color * Domain.z;
	Output.UV = Patch[0].UV * Domain.x + Patch[1].UV * Domain.y + Patch[2].UV * Domain.z;
	
	Output.WorldNormal = Patch[0].WorldNormal * Domain.x + Patch[1].WorldNormal * Domain.y + Patch[2].WorldNormal * Domain.z;
	Output.WVPNormal = Patch[0].WVPNormal * Domain.x + Patch[1].WVPNormal * Domain.y + Patch[2].WVPNormal * Domain.z;

	return Output;
}
```



```c
// PN Triangle
[domain("tri")]
DS_OUTPUT main(HS_CONSTANT_DATA_OUTPUT TessFactors, float3 Domain : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 3> Patch)
{
	DS_OUTPUT Output;

	float4 P1 = Patch[0].WorldPosition;
	float4 P2 = Patch[1].WorldPosition;
	float4 P3 = Patch[2].WorldPosition;

	float4 N1 = normalize(Patch[0].WorldNormal);
	float4 N2 = normalize(Patch[1].WorldNormal);
	float4 N3 = normalize(Patch[2].WorldNormal);

	float4 w12 = dot((P2 - P1), N1);
	float4 w21 = dot((P1 - P2), N2);

	float4 w23 = dot((P3 - P2), N2);
	float4 w32 = dot((P2 - P3), N3);
	
	float4 w31 = dot((P1 - P3), N3);
	float4 w13 = dot((P3 - P1), N1);

	float4 b300 = P1;
	float4 b030 = P2;
	float4 b003 = P3;

	float4 b210 = (2 * P1 + P2 - w12 * N1) / 3;
	float4 b120 = (2 * P2 + P1 - w21 * N2) / 3;

	float4 b021 = (2 * P2 + P3 - w23 * N2) / 3;
	float4 b012 = (2 * P3 + P2 - w32 * N3) / 3;

	float4 b102 = (2 * P3 + P1 - w31 * N3) / 3;
	float4 b201 = (2 * P1 + P3 - w13 * N1) / 3;

	float4 E = (b210 + b120 + b021 + b012 + b102 + b201) / 6;
	float4 V = (b300 + b030 + b003) / 3;

	float4 b111 = E + (E - V) / 2;

	float u = Domain.x;
	float v = Domain.y;
	float w = Domain.z;
	float4 Bezier = pow(u, 3) * b300 +
		3 * pow(u, 2) * v * b210 +
		3 * pow(u, 2) * w * b201 +
		3 * u * pow(v, 2) * b120 +
		3 * u * pow(w, 2) * b102 +
		6 * u * v * w * b111 +
		pow(v, 3) * b030 +
		3 * pow(v, 2) * w * b021 +
		3 * v * pow(w, 2) * b012 +
		pow(w, 3) * b003;

	Output.WorldPosition = Bezier;

	Output.Position = Output.WorldPosition;
	Output.Position = mul(float4(Output.Position.xyz, 1.0f), VP);

	Output.Color = Patch[0].Color * Domain.x + Patch[1].Color * Domain.y + Patch[2].Color * Domain.z;
	Output.UV = Patch[0].UV * Domain.x + Patch[1].UV * Domain.y + Patch[2].UV * Domain.z;
	
	Output.WorldNormal = Patch[0].WorldNormal * Domain.x + Patch[1].WorldNormal * Domain.y + Patch[2].WorldNormal * Domain.z;
	Output.WVPNormal = Patch[0].WVPNormal * Domain.x + Patch[1].WVPNormal * Domain.y + Patch[2].WVPNormal * Domain.z;

	return Output;
}
```

```c
float4 GetBezier(float4 P1, float4 P2, float4 P3, float4 N1, float4 N2, float4 N3, float3 uvw)
{
	float4 w12 = dot((P2 - P1), N1);
	float4 w21 = dot((P1 - P2), N2);

	float4 w23 = dot((P3 - P2), N2);
	float4 w32 = dot((P2 - P3), N3);

	float4 w31 = dot((P1 - P3), N3);
	float4 w13 = dot((P3 - P1), N1);

	float4 b300 = P1;
	float4 b030 = P2;
	float4 b003 = P3;

	float4 b210 = (2 * P1 + P2 - w12 * N1) / 3;
	float4 b120 = (2 * P2 + P1 - w21 * N2) / 3;

	float4 b021 = (2 * P2 + P3 - w23 * N2) / 3;
	float4 b012 = (2 * P3 + P2 - w32 * N3) / 3;

	float4 b102 = (2 * P3 + P1 - w31 * N3) / 3;
	float4 b201 = (2 * P1 + P3 - w13 * N1) / 3;

	float4 E = (b210 + b120 + b021 + b012 + b102 + b201) / 6;
	float4 V = (b300 + b030 + b003) / 3;

	float4 b111 = E + (E - V) / 2;

	float u = uvw.x;
	float v = uvw.y;
	float w = uvw.z;
	float4 Bezier = pow(u, 3) * b300 +
		3 * pow(u, 2) * v * b210 +
		3 * pow(u, 2) * w * b201 +
		3 * u * pow(v, 2) * b120 +
		3 * u * pow(w, 2) * b102 +
		6 * u * v * w * b111 +
		pow(v, 3) * b030 +
		3 * pow(v, 2) * w * b021 +
		3 * v * pow(w, 2) * b012 +
		pow(w, 3) * b003;

	return Bezier;
}
```

### Tessellation 설명 (quad)

```cpp
// quad tessellation을 이용하면 제어점 1개만으로도 (다수의)사각형을 그릴 수 있다!!
DeviceContext->IASetPrimitiveTopology(
	D3D11_PRIMITIVE_TOPOLOGY_1_CONTROL_POINT_PATCHLIST);
DeviceContext->Draw(1, 0);
```



```c
// Tessellator가 얼마나 분할해야하는지 알려줌. Domain Shader에도 넘겨지는 정보
struct HS_CONSTANT_DATA_OUTPUT
{
	float EdgeTessFactor[4]	: SV_TessFactor;
	float InsideTessFactor[2] : SV_InsideTessFactor;
};

// Hull Shader가 Domain Shader에 각 Patch 당 넘기는 정보
struct HS_OUTPUT
{
	float HemisphereDirection : DIRECTION;
};

// VS_OUTPUT과 같은 역할! 테셀레이션이 된 정점이라고 생각하면 된다.
struct DS_OUTPUT
{
	float4 Position  : SV_POSITION;
};
```



```c
#include "Quad.hlsli"

// ## 패치 테셀레이션 인수를 계산하기 위한 함수. 
// ## 인수에 그냥 상수를 대입하는 경우엔 쓸모없어 보일 수 있지만...
// ## 카메라와의 거리에 따라 LOD를 조절하거나 필요없을 경우 Cull을 하는 등
// ## 동적으로 테셀레이션 계수를 계산하려면 이 함수가 필요하다.
// line일 경우 SV_TessFactor 2개 SV_InsideTessFactor 0개
// tri일 경우 SV_TessFactor 3개 SV_InsideTessFactor 1개
// quad일 경우 SV_TessFactor 4개 SV_InsideTessFactor 2개
HS_CONSTANT_DATA_OUTPUT CalcHSPatchConstants(uint PatchID : SV_PrimitiveID)
{
	static const float KTessFactor = 16.0;
	
	HS_CONSTANT_DATA_OUTPUT Output;

	Output.EdgeTessFactor[0] = Output.EdgeTessFactor[1] =
    	Output.EdgeTessFactor[2] = Output.EdgeTessFactor[3] =
    	Output.InsideTessFactor[0] = Output.InsideTessFactor[1] = KTessFactor;
	
	return Output;
}

// ## Domain Shader에 넘길 각 Patch의 정보는 이 함수에서 대입한다.
// ## 설정이 많지만 뜯어보면 별 거 아니다..
// [domain()] 영역. "tri": 삼각형 테셀레이션, "quad": 사각형 테셀레이션
// [maxtessfactor()] 최대 테셀레이션 인수 제한. 하드웨어 최대는 64.0이다. 이건 생략 가능!
// [outputcontrolpoints()]
//		총 1~32개의 제어점을 출력할 수 있다
//		이 main 함수가 총 실행될 횟수와도 동일하다!★
// [outputtopology()] 사각형도 결국 삼각형의 조합이므로...
//		"point": 점, "line": 선,
//		"triangle_cw": 시계방향 삼각형, "triangle_ccw": 반시계 방향 삼각형
// [partitioning()]
//		"fractional_odd": 홀수 소수, "fractional even": 짝수 소수,
//		"integer": 정수, "pow2": 2의 거듭제곱
// [patchconstantfunc("CalcHSPatchConstants")] 패치 상수 함수의 이름
[domain("quad")] 
[maxtessfactor(64.0)]
[outputcontrolpoints(1)]
[outputtopology("triangle_cw")]
[partitioning("integer")]
[patchconstantfunc("CalcHSPatchConstants")]
HS_OUTPUT main(uint ControlPointID : SV_OutputControlPointID, uint PatchID : SV_PrimitiveID)
{
	HS_OUTPUT Output;

    // PatchID == 0 ? -1.0 : +1.0
	Output.HemisphereDirection = ((float)PatchID) * 2.0 - 1.0;

	return Output;
}
```



```c
#include "Quad.hlsli"

cbuffer cbSpace : register(b0)
{
	float4x4 WVP;
}

// domain이 "tri"일 경우 SV_DomainLocation은 float3 (Barycentric coordinates: uvw)
// domain이 "quad"일 경우 SV_DomainLocation은 float2
// domain이 "isoline"일 경우도 SV_DomainLocation은 float2
// OutputPatch는 HS에서 넘겨받은 것이므로 const다! 이 patch들을 이용해 DS_OUTPUT을 구성한다.
[domain("quad")]
DS_OUTPUT main(HS_CONSTANT_DATA_OUTPUT Input, float2 Domain : SV_DomainLocation, const OutputPatch<HS_OUTPUT, 1> ControlPoints)
{
	DS_OUTPUT Output;

	float2 ClipSpaceDomain = Domain * 2.0 - 1.0;
	float2 ClipSpaceDomainAbsolute = abs(ClipSpaceDomain);
	float MaxLength = max(ClipSpaceDomainAbsolute.x, ClipSpaceDomainAbsolute.y);

	float3 LocalSpacePosition = float3
		(
			ClipSpaceDomain.x * ControlPoints[0].HemisphereDirection, 
			ClipSpaceDomain.y, 
			(MaxLength - 1.0) * ControlPoints[0].HemisphereDirection
		);
	Output.Position = float4(normalize(LocalSpacePosition), 1);
	Output.Position = mul(Output.Position, WVP);
}
```



## ##. Core structure modified

```
#Core
##CGame
###CShader
####CConstantBuffer
###CObject3D ★ (Model == vector<Mesh> + ★vector<CMaterial>, AddMaterial(), GetMaterial())
###CObject3DLine ★ (Lines)
###CObject2D ★ (Object2DData + ★CMaterial)
###CCamera
###CMaterial★★★ (TextureDiffuse, TextureNormal, ...)
####CTexture★
###CGameObject3D (ComponentRender == CObject3D ( !Texture))
###CGameObject3DLine
###CGameObject2D (ComponentRender == CObject2D ( !Texture))
##SharedHeader.h
##PrimitiveGenerator.h
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

## ##. Particle

Collision particle - 불똥, 비 (collision detection 필요)

non-Collision particle - 구름, 연기, 불, 폭발 (위치, 방향, 크기 정보만 필요)

```
struct SParticleData
{
    XMVECTOR Position
    float Angle
    float ScalarX
    float ScalarY
    ---
    bool IsPhysical
    float LifeTime
    float AgingFactor
    float 
    XMVECTOR Acceleration
    XMVECTOR Velocity
}
```

point vertices & GSParticle



## ##. Scene save & load

Object3D list, Terrain, Sky, Light 저장하기

## ##. GPU skinning & animation interpolation

## ##. Editor to Game Engine

## ##. Edge detection

Full-screen quad => Render to texture (RTT)

```c
Draw(6, 0)
VS => SV_VertexID
// Excellent, but not ideal for GPU debugging
```

Sobel kernel

```c
static float3x3 KSobelKernelX =
{
	-1,  0, +1,
	-2,  0, +2,
	-1,  0, +1
};

static float3x3 KSobelKernelY =
{
	+1, +2, +1,
	 0,  0,  0,
	-1, -2, -1
};
```

## ##. Physically Based Rendering (PBR) with Image Based Lighting (IBL)

## ##. Deferred shading ★

https://www.hiagodesena.com/blog/physically-based-deferred-renderer

https://learnopengl.com/Advanced-Lighting/Deferred-Shading

https://aras-p.info/texts/CompactNormalStorage.html

**“A bit more Deferred” - CryEngine 3**

Light representation => Screen-space/World-space billboard + Gizmo selection

Billboard == 1 control point + tessellation + screen-space/world-space quad generation in DS



-- GBuffers **for PBR** --

```
R8G8B8A8_UNORM

GBuffer #0: Depth 24 Stencil 8 (Depth Stencil View를 만들 때 사용한 버퍼를 그대로 활용!)

GBuffer #1: BaseColor 24 Roughness 8

GBuffer #2: Normal 32 (11 11 10)

GBuffer #3: Metalness 8 AmbientOcclusion 8
```



1. Set GBuffers as render targets

2. Draw all the [opaque] objects (with directional light + IBL★)

3. Set back buffer as render target and set GBuffers(== GBuffer textures) as shader resources

4. Draw light volumes for each light source and perform screen-space shading by sampling GBuffer textures in the pixel shader using point clamp sampler

5. Draw [transparent] objects

   

Stencil buffer를 사용해서 최적화?



```c
struct GBufferOutput
{
	float4 BaseColor_Rough	: SV_Target0;
	float4 Normal 			: SV_Target1;
	float4 MetalAO			: SV_Target2;
};
```

```c
#include "Deferred.hlsli"
#include "BRDF.hlsli"

SamplerState PointClampSampler : register(s0);

Texture2D GBuffer_DepthStencil : register(t0);
Texture2D GBuffer_BaseColor_Rough : register(t1);
Texture2D GBuffer_Normal : register(t2);
Texture2D GBuffer_Metal_AO : register(t3);

cbuffer cbGBufferUnpacking : register(b0)
{
	float4 PerspectiveValues;
	float4x4 InverseViewMatrix;
}

float4 main(VS_OUTPUT Input) : SV_TARGET
{
	float ProjectionSpaceDepth = GBuffer_DepthStencil.SampleLevel(PointClampSampler, Input.TexCoord.xy, 0).x;
	float ViewSpaceDepth = PerspectiveValues.z / (ProjectionSpaceDepth + PerspectiveValues.w);
	float4 WorldPosition = mul(float4(Input.TexCoord.xy * PerspectiveValues.xy * ViewSpaceDepth, ViewSpaceDepth, 1.0), InverseViewMatrix);

	float4 BaseColor_Rough = GBuffer_BaseColor_Rough.SampleLevel(PointClampSampler, Input.TexCoord.xy, 0);
	float3 WorldNormal = (GBuffer_Normal.SampleLevel(PointClampSampler, Input.TexCoord.xy, 0).xyz) * 2.0 - 1.0;
	float4 Metal_AO = GBuffer_MetalAO.SampleLevel(PointClampSampler, Input.TexCoord.xy, 0);

	float4 OutputColor = float4(BaseColor_Rough.xyz, 1);
	return OutputColor;
}
```

### Normal encoding/decoding: R16G16_SNORM vs. R10G10B10A2_UNORM

```c
// For R16G16_SNORM format
float3 UnpackNormal(float2 PackedNormal)
{
	float3 UnpackedNormal = float3(0, 0, 0);
	UnpackedNormal.z = length(PackedNormal.xy) * 2.0 - 1.0;
	UnpackedNormal.xy = normalize(PackedNormal.xy) * sqrt(1.0 - UnpackedNormal.z * UnpackedNormal.z);
	return normalize(UnpackedNormal);
}

// For R16G16_SNORM format
float2 PackNormal(float3 WorldNormal)
{
	return float2(normalize(WorldNormal.xy) * (WorldNormal.z * 0.5 + 0.5));
}
```

Lighting models: directional light(BRDF + ambient IBL), point light, spot light, capsule light?

```cpp
// This class will contain all the data needed for a point light and will draw 2 control points to convert them into a sphere in Domain Shader in order to use it with GBuffers for deferred shading!
// CPointLight: position, color, range
// DSPointLight
class CPointLight; 

// CSpotLight: position, color, orientation, range, theta, alpha
class CSpotLight;

// CCapsuleLight: position, color, orientation, length, radius
class CCapsuleLight;

// rectangle... circle...
class CAreaLight;
    
CShader m_VSScreenQuad; // For Directional light & ambient IBL
CShader m_VSLight;
CShader m_HSPointLight; // No need for directional light
CShader m_DSPointLight; // No need for directional light
CShader m_PSDirectionalLight;
CShader m_PSPointLight;
```



## ##. Screen-Space Ambient Occlusion

## ##. Shadow mapping

https://gamedev.stackexchange.com/questions/27284/deferred-rendering-shadow-maps

### Cascaded Shadow Mapping

★★ 0. LOD 1부터는 매 프레임 업데이트 할 필요 없다!! ★★ (성능 개선)



## ##. Instance (frustum) culling

1) CPU: Instance batch 별로 batch bounding sphere 검사 -> test fail 시 no Draw call

​    (instance를 추가하거나 옮길 때마다 batch bounding sphere 검사 필요..? 너무 비싸지 않나  아니면 직접 반지름을 지정하게 할까..?)

​    (batch 내 instance 간 간격이 넓을수록 비효율적이다! 최대한 cluster로 뭉쳐...)

2) GPU: Vertex Shader에서 Instance world position + instance bounding sphere 검사 -> test fail 시 Output.Position.w = 0; => 아니다 검사는 CPU에서 해야 ★instance당 한 번만 하지★ VS에서는 vertex마다 해야하니까...!! world matrix 값을 바꿔서 GPU에 업데이트하면 되잖아!!





## ##. Bloom★

## ##. light shaft = godray (using tessellation and shadow mapping, not ray marching)

## ##. Instance animation





## ##. Global fog

Distance fog, height fog => Save into scene

## ##. View frustum culling on CPU!



## 

## ##. Anti-aliasing

 http://diaryofagraphicsprogrammer.blogspot.com/2008/03/light-pre-pass-renderer.html 

 https://github.com/dtrebilco/lightindexed-deferredrender 

 https://stackoverflow.com/questions/40275577/how-to-sample-a-srv-when-enable-msaa-x4directx11 ★

 http://ozlael.egloos.com/3420127 

 https://mynameismjp.wordpress.com/2010/08/16/deferred-msaa/ 

 http://zzinga.egloos.com/3409362 

### FXAA(Fast approXimate Anti-Aliasing)

## # Reflection (water, mirror)

## # Collision - Collision mesh★



## # (Tessellation) Patch edit system - for editor

## # Scene animation edit system!! - e. g. camera animation

Set key frames and interpolate between the key frames!!!