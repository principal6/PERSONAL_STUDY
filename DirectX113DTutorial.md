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



## #17. Height-map terrain





## # Bounding volume



## # Animation interpolation and GPU skinning

## # Reflection (water, mirror)

## # RTT(Render to texture)

## # Billboarding???

## # Collision - Collision mesh★

## # ambient occlusion

## # shadow mapping