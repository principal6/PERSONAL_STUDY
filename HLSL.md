# HLSL 프로그래밍

## 전처리기

```cpp
#pragma pack_matrix(row_major) // 이걸 하면 DirectX 코드에서 XMMatrixTranspose()를 할 필요가 없다!!!
// = 매 행렬마다 다음을 쓰는 것과 같음!
row_major matrix MyMatrix;

#pragma pack_matrix(column_major)
```



#define ~

## Semantics

 - **System Value**
    - SV_Position (VS 출력, PS 입력) (과거 VPos, Position)
    - SV_Target (PS 출력) (과거 Color)
    - SV_IsFrontFace (과거 VFace)
    - SV_InstanceID

## 자료형

int
float
float2
float3
float4 (xyzw / rgba)
float4x4
Texture2D
Texture3D
Texture2DArray
TextureCUBE


@@문법
 - if/else
  - [branch] if
  - [flatten] if
 - switch
  - [flatten]
  - [branch]
  - [forcecase]
  - [call]
 - 반복문
   - for
   - [unroll] for
   - [unroll(n)] for
   - [loop] for
   - while

## 버퍼

### 상수 버퍼

```cpp
// HLSL 코드

cbuffer cbFlags
{
	bool HasTexture;
	bool UseLighting;
	float2 pad;
};

cbuffer cbLights
{
	float4 AmbientColor;
	float4 DirectionalColor;
	float4 DirectionalDirection;
};

cbuffer cbCamera
{
	float4 CameraPosition;
};
```

```cpp
// Cpp 코드

void JWDX::SetPSCBFlags(bool HasTexture, bool UseLighting) noexcept
{
	if (HasTexture)
	{
		m_PSCBFlagsData.HasTexture = TRUE;
	}
	else
	{
		m_PSCBFlagsData.HasTexture = FALSE;
	}

	if (UseLighting)
	{
		m_PSCBFlagsData.UseLighting = TRUE;
	}
	else
	{
		m_PSCBFlagsData.UseLighting = FALSE;
	}

	m_DeviceContext11->UpdateSubresource(m_PSCBFlags, 0, nullptr, &m_PSCBFlagsData, 0, 0);
	m_DeviceContext11->PSSetConstantBuffers(0, 1, &m_PSCBFlags);
}

void JWDX::SetPSCBLights(SPSCBLights& Data) noexcept
{
	m_PSCBLightsData = Data;
	
	m_DeviceContext11->UpdateSubresource(m_PSCBLights, 0, nullptr, &m_PSCBLightsData, 0, 0);
	m_DeviceContext11->PSSetConstantBuffers(1, 1, &m_PSCBLights);
}

void JWDX::SetPSCBCamera(XMFLOAT4 CameraPosition) noexcept
{
	m_PSCBCameraData.CameraPosition = CameraPosition;

	m_DeviceContext11->UpdateSubresource(m_PSCBCamera, 0, nullptr, &m_PSCBCameraData, 0, 0);
	m_DeviceContext11->PSSetConstantBuffers(2, 1, &m_PSCBCamera);
}
```



### 텍스처 버퍼

텍스처 버퍼(texture buffer, tbuffer)는 상수 버퍼(constant buffer, cbuffer)처럼 사용할 수 있지만, 내부적으로는 Texture Fetching을 활용한다. 즉, 여러 개의 작은 데이터가 업데이트되는 게 아니라 하나의 큰 텍스처로 자료가 한꺼번에 업데이트된다. 상수 버퍼보다 랜덤 액세스(random access)에 훨씬 효율적이다.

A texture buffer is a specialized buffer resource that is accessed like a texture. Texture access (as compared with buffer access) can have better performance for arbitrarily indexed data. You can bind up to 128 texture buffers per pipeline stage. (MSDN)

A constant buffer does not require a [view](https://msdn.microsoft.com/library/windows/desktop/bb205128) to be bound to the pipeline. A **texture buffer,** however, requires a view and must be bound to a texture slot (or must be bound with [**SetTextureBuffer**](https://msdn.microsoft.com/library/windows/desktop/bb173638) when using an effect). (MSDN)

**cbuffer limited to 4096*128-bit**
**tbuffer limited to 128 megabytes**

```
ID3D10Texture1D*                    g_pBoneTexture = NULL;
ID3D10ShaderResourceView*           g_pBoneTextureRV = NULL;
```



tbuffer

 => D3D11_BIND_SHADER_RESOURCE
 => XSSetShaderResources()

//Texture Fetching

// tbuffer를 쓰면 필요없다!
// Texture for bone matrices
Texture1D g_txTexBoneWorld;

//Texture buffer

// 그냥 상수 버퍼인 것처럼 바로 matrix 얻어올 수 있다!!!!★★
// TBuffer for bone matrices
tbuffer tbAnimMatrices
{
    matrix g_mTexBoneWorld[MAX_BONE_MATRICES];
};

## 정점셰이더

### register, packoffset

```cpp
cbuffer ~~ : register(b0) // Constant buffer
tbuffer ~~ : register(t0) // Texture & texture buffer
Texture2D<float4> ~~ : register(t1); // Texture & texture buffer
sampler ~~ : register(s0) // Sampler
Unordered Access View : register(u0) // Unordered Access View
    
    
```

```cpp
cbuffer cbWorld : register(b0)
{
	matrix	WVP;
	matrix	World;
};

cbuffer cbRiggedCPU : register(b1)
{
	matrix	Bone[MAX_BONE_COUNT];
};

cbuffer cbRiggedGPU : register(b2)
{
	uint	AnimationID;
	uint	CurrFrame;
	uint	Nextrame;
	float	Delta;
};
```



```cpp
cbuffer cbDirLight : register( b0 )
{
	float3 AmbientDown	: packoffset( c0 );
	// float pad; //(packoffset을 썼으므로 필요없다!)
	// packoffset을 쓰지 않으면 셰이더는 float4를 한 단위로 묶는다.
    float pad			: packoffset( c0.w );
	float3 AmbientRange	: packoffset( c1 ); 
	float3 DirToLight	: packoffset( c2 );
	float3 DirLightColor: packoffset( c3 );
}
```



### 전체화면 사각형 그리기 (Screen quad)

```cpp
// 인풋 레이아웃, 정점 버퍼 관련 값은 전부 0과 nullptr로 설정
pd3dImmediateContext->IASetInputLayout( nullptr );
pd3dImmediateContext->IASetVertexBuffers(0, 0, nullptr, nullptr, nullptr);
// @important
// PrimitiveTopology가 D3D11_PRIMITIVE_TOPOLOGY_TRIANGLELIST이면 안 된다!
// 반드시 D3D_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP여야 한다!!
pd3dImmediateContext->IASetPrimitiveTopology( D3D_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP );

// 사각형을 그릴 땐 총 4개의 정점이 필요 (인덱스 버퍼가 없어도 된다!)
pd3dImmediateContext->Draw(4, 0);
```

```cpp
static const float2 QuadArray[4] =
{
    // 정점 셰이더에서 x, y 좌표는 픽셀 셰이더에서는 픽셀 좌표로 변경되어 있다!
	float2(-1.0, +1.0), // 왼쪽 위
	float2(+1.0, +1.0), // 오른쪽 위
	float2(-1.0, -1.0), // 왼쪽 아래
	float2(+1.0, -1.0), // 오른쪽 아래
};

// SV_VertexID를 사용하면
// 디바이스 콘텍스트 Draw(4, 0)에서 그린 4개의 정점의 ID가 0, 1, 2, 3 순서대로 들어온다!
float4 main(uint VertexID : SV_VertexID) : SV_POSITION
{
	return float4(QuadArray[VertexID].xy, 0.0, 1.0);
}
```



## 픽셀셰이더 (Pixel shader = Fragment shader)

**x 범위: -1 ~ +1**
**y 범위: +1 ~ -1 (위쪽이 +1, 아래쪽이 -1)**

 - **시스템 값(SV_)**
 - SV_POSITION은 반드시 float4여야 한다! (x,y 만 쓸 거면 w값은 1로 할 것!)
 - SV_TARGET은 float4일수도, int4, uint4일수도 ...

### 샘플링으로 텍셀 읽기

```cpp
Texture2D<float4> CurrentTexture;
SamplerState CurrentSamplerState;

float4 main(VS_OUTPUT input) : SV_TARGET
{
	float4 final_color = CurrentTexture.Sample(CurrentSamplerState, input.TexCoord);
	return final_color;
}
```



### 샘플링 없이 텍셀 읽기

```cpp
// 텍스처 생성
D3D11_TEXTURE2D_DESC texture_descrption{};
texture_descrption.Width = static_cast<UINT>(m_WindowWidth);
texture_descrption.Height = static_cast<UINT>(m_WindowHeight);
texture_descrption.MipLevels = 1;
texture_descrption.ArraySize = 1;
texture_descrption.Format = DXGI_FORMAT_B8G8R8A8_UNORM; // @important: RGBA 순서가 아니라 BGRA 순서임에 주의!!!
texture_descrption.SampleDesc.Count = 1;
texture_descrption.Usage = D3D11_USAGE_DYNAMIC;
texture_descrption.BindFlags = D3D11_BIND_SHADER_RESOURCE;
texture_descrption.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
texture_descrption.MiscFlags = 0;
m_pDevice->CreateTexture2D(&texture_descrption, nullptr, &m_RawTexture2D);

D3D11_SHADER_RESOURCE_VIEW_DESC srv_description{};
srv_description.Format = texture_descrption.Format;
srv_description.ViewDimension = D3D11_SRV_DIMENSION_TEXTURE2D;
srv_description.Texture2D.MostDetailedMip = 0;
srv_description.Texture2D.MipLevels = 1;
m_pDevice->CreateShaderResourceView(m_RawTexture2D, &srv_description, &m_RawTexture2DSRV);

// 텍스처에 픽셀 대입
int width = static_cast<int>(m_WindowWidth);
int height = static_cast<int>(m_WindowHeight);
int size = width * height;
int array_size = size * 4; // Each 4 entry represents R, G, B, A

unsigned char* color = new unsigned char[array_size];
memset(color, 0, sizeof(unsigned char) * array_size);
int texel_id{};
for (int y = 0; y < height; ++y)
{
	for (int x = 0; x < width; ++x)
	{
		texel_id = (x * 4) + (y * width * 4);

		color[texel_id] = 255; // B
		color[texel_id + 1] = 0; // G
		color[texel_id + 2] = 0; // R
		color[texel_id + 3] = 255; // A
	}
}

D3D11_MAPPED_SUBRESOURCE mapped_subresource{};
if (SUCCEEDED(m_pDX->GetDeviceContext()->Map(m_RawTexture2D, 0, D3D11_MAP_WRITE_DISCARD, 0, &mapped_subresource)))
{
	memcpy(mapped_subresource.pData, color, sizeof(unsigned char) * array_size);
	m_pDX->GetDeviceContext()->Unmap(m_RawTexture2D, 0);
}

delete[] color;
```

```cpp
// Load한 결과 자료형이 uint4임을 명시
Texture2D<uint4> TextureWihtoutSampling;

uint4 main(VS_OUTPUT input) : SV_TARGET
{
	// Load()는 (u)int3를 입력 받는다.
    // 그 중 앞 int 두 개는 텍스처 좌표를,
    // 나머지 int는 mipmap 레벨을 의미한다!
	//uint4 final_color = TextureWihtoutSampling.Load(uint3(input.Position.xy, 0));
	
	// 좀 더 간단한 방법!!
	uint4 final_color = TextureWihtoutSampling[input.Position.xy];
	//uint4 final_color = TextureWihtoutSampling[uint2(50, 100)];
	return final_color;
}
```



## 내장 함수 (Intrinsic functions)

 - 행렬 계산: mul(벡터, 행렬)
 - 텍스처 샘플링: Sample, SampleGrad, SampleCmp, SampleLevel, SampleBias
   - Sample(샘플러 이름, uv좌표);
 - 샘플링 없이 텍셀 읽으려면? Load() 활용 (예전 tex2Dlod 같음..)
- 전체화면 사각형(스크린 쿼드, screen quad) 만들기

```cpp
pd3dImmediateContext->IASetInputLayout( nullptr );
pd3dImmediateContext->IASetVertexBuffers(0, 0, nullptr, nullptr, nullptr);
pd3dImmediateContext->IASetPrimitiveTopology( D3D_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP );

pd3dImmediateContext->VSSetShader(g_pGBufferVisVertexShader, nullptr, 0);
pd3dImmediateContext->GSSetShader(nullptr, nullptr, 0);
pd3dImmediateContext->PSSetShader(g_pGBufferVisPixelShader, nullptr, 0);

pd3dImmediateContext->Draw(4, 0);
```



### G-Buffer 사용하기

#### G-Buffer 렌더링 전에 할 일

```cpp
// Clear the depth stencil
pd3dImmediateContext->ClearDepthStencilView( m_DepthStencilDSV, D3D11_CLEAR_DEPTH|D3D11_CLEAR_STENCIL, 1.0, 0 );

// You only need to do this if your scene doesn't cover the whole visible area
float ClearColor[4] = { 0.0f, 0.0f, 0.0f, 0.0f };
pd3dImmediateContext->ClearRenderTargetView( m_ColorSpecIntensityRTV, ClearColor );
pd3dImmediateContext->ClearRenderTargetView( m_NormalRTV, ClearColor );
pd3dImmediateContext->ClearRenderTargetView( m_SpecPowerRTV, ClearColor );

// Bind all the render targets togther
ID3D11RenderTargetView* rt[3] = { m_ColorSpecIntensityRTV, m_NormalRTV, m_SpecPowerRTV };
pd3dImmediateContext->OMSetRenderTargets( 3, rt , m_DepthStencilDSV );
pd3dImmediateContext->OMSetDepthStencilState(m_DepthStencilState, 1);
```

#### G-Buffer 렌더 타겟에 맞게 PS의 SV_TARGET은 세 개, 순서도 똑같이!

```cpp
Texture2D<float> DepthTexture         : register( t0 );
Texture2D<float4> ColorSpecIntTexture : register( t1 );
Texture2D<float3> NormalTexture       : register( t2 );
Texture2D<float4> SpecPowTexture      : register( t3 );
SamplerState PointSampler             : register( s0 );

struct PS_GBUFFER_OUT
{
	float4 ColorSpecInt : SV_TARGET0;
	float4 Normal : SV_TARGET1;
	float4 SpecPow : SV_TARGET2;
};

struct SURFACE_DATA
{
	float LinearDepth;
	float3 Color;
	float3 Normal;
	float SpecPow;
	float SpecIntensity;
};

SURFACE_DATA UnpackGBuffer(float2 UV)
{
	SURFACE_DATA Out;

	float depth = DepthTexture.Sample( PointSampler, UV.xy ).x;
	Out.LinearDepth = ConvertZToLinearDepth(depth);
	float4 baseColorSpecInt = ColorSpecIntTexture.Sample( PointSampler, UV.xy );
	Out.Color = baseColorSpecInt.xyz;
	Out.SpecIntensity = baseColorSpecInt.w;
	Out.Normal = NormalTexture.Sample( PointSampler, UV.xy ).xyz;
	Out.Normal = normalize(Out.Normal * 2.0 - 1.0);
	Out.SpecPow = SpecPowTexture.Sample( PointSampler, UV.xy ).x;

	return Out;
}

PS_GBUFFER_OUT PackGBuffer(float3 BaseColor, float3 Normal, float SpecIntensity, float SpecPower)
{
	PS_GBUFFER_OUT Out;

	// Normalize the specular power
	float SpecPowerNorm = max(0.0001, (SpecPower - g_SpecPowerRange.x) / g_SpecPowerRange.y);

	// Pack all the data into the GBuffer structure
	Out.ColorSpecInt = float4(BaseColor.rgb, SpecIntensity);
	Out.Normal = float4(Normal * 0.5 + 0.5, 0.0);
	Out.SpecPow = float4(SpecPowerNorm, 0.0, 0.0, 0.0);

	return Out;
}

PS_GBUFFER_OUT RenderScenePS( VS_OUTPUT In )
{ 
    // Lookup mesh texture and modulate it with diffuse
    float3 DiffuseColor = DiffuseTexture.Sample( LinearSampler, In.UV );
	DiffuseColor *= DiffuseColor;

	return PackGBuffer(DiffuseColor, normalize(In.Normal), specIntensity, specExp);
}

```



#### G-Buffer 화면에 출력하기

```cpp
ID3D11ShaderResourceView* arrViews[4] = { g_GBuffer.GetDepthView(), g_GBuffer.GetColorView(), g_GBuffer.GetNormalView() ,g_GBuffer.GetSpecPowerView() };
// GetDepthView(), GetColorView(), GetNormalView(), GetSpecPowerView() 함수들은 각각 버퍼에 해당하는 셰이더 리소스 뷰(ID3D11ShaderResourceView*)를 리턴한다.

// PS 리소스 바인딩: 총 4개의 셰이더 리소스 뷰를 PS에 바인딩한다.
pd3dImmediateContext->PSSetShaderResources(0, 4, arrViews);

/* PS 샘플러 설정: 샘플러 묘사는 다음과 같다
D3D11_SAMPLER_DESC samDesc{};
samDesc.Filter = D3D11_FILTER_MIN_MAG_MIP_POINT
samDesc.AddressU = samDesc.AddressV = samDesc.AddressW = D3D11_TEXTURE_ADDRESS_WRAP;
samDesc.MaxAnisotropy = 1;
samDesc.ComparisonFunc = D3D11_COMPARISON_ALWAYS;
samDesc.MaxLOD = D3D11_FLOAT32_MAX;
*/
pd3dImmediateContext->PSSetSamplers( 0, 1, &g_pSampPoint );

pd3dImmediateContext->IASetInputLayout( nullptr );
pd3dImmediateContext->IASetVertexBuffers(0, 0, nullptr, nullptr, nullptr);
pd3dImmediateContext->IASetPrimitiveTopology( D3D_PRIMITIVE_TOPOLOGY_TRIANGLESTRIP );

pd3dImmediateContext->VSSetShader(g_pGBufferVisVertexShader, nullptr, 0);
pd3dImmediateContext->GSSetShader(nullptr, nullptr, 0);
pd3dImmediateContext->PSSetShader(g_pGBufferVisPixelShader, nullptr, 0);

pd3dImmediateContext->Draw(4, 0);
```



## 테셀레이션

★SubD11 (DirectX SDK) 참조해봐



```cpp
// Vertex shader

struct VertexInputType
{
    float3 position : POSITION;
    float4 color : COLOR;
};

struct HullInputType
{
    float3 position : POSITION;
    float4 color : COLOR;
};

HullInputType ColorVertexShader(VertexInputType input)
{
    HullInputType output;
In the vertex shader we pass the vertices and color data through to the hull shader. Since the vertices will be increasing with the tessellation we now do the transforming and such in the domain shader. The vertex shader's purpose is now just for vertex animation and passing data into the hull shader.

    // Pass the vertex position into the hull shader.
    output.position = input.position;
    
    // Pass the input color into the hull shader.
    output.color = input.color;
    
    return output;
}
```



```cpp
// Hull shader

cbuffer TessellationBuffer
{
    float tessellationAmount;
    float3 padding;
};
struct HullInputType
{
    float3 position : POSITION;
    float4 color : COLOR;
};
struct ConstantOutputType
{
    float edges[3] : SV_TessFactor;
    float inside : SV_InsideTessFactor;
};
struct HullOutputType
{
    float3 position : POSITION;
    float4 color : COLOR;
};

ConstantOutputType ColorPatchConstantFunction(InputPatch<HullInputType, 3> inputPatch, uint patchId : SV_PrimitiveID)
{    
    ConstantOutputType output;

    // Set the tessellation factors for the three edges of the triangle.
    output.edges[0] = tessellationAmount;
    output.edges[1] = tessellationAmount;
    output.edges[2] = tessellationAmount;

    // Set the tessellation factor for tessallating inside the triangle.
    output.inside = tessellationAmount;

    return output;
}

[domain("tri")]
[partitioning("integer")]
[outputtopology("triangle_cw")]
[outputcontrolpoints(3)]
[patchconstantfunc("ColorPatchConstantFunction")]
HullOutputType ColorHullShader(InputPatch<HullInputType, 3> patch, uint pointId : SV_OutputControlPointID, uint patchId : SV_PrimitiveID)
{
    HullOutputType output;

    // Set the position for this control point as the output position.
    output.position = patch[pointId].position;

    // Set the input color as the output color.
    output.color = patch[pointId].color;

    return output;
}
```



```cpp
// Domain shader

cbuffer MatrixBuffer
{
    matrix worldMatrix;
    matrix viewMatrix;
    matrix projectionMatrix;
};

struct ConstantOutputType
{
    float edges[3] : SV_TessFactor;
    float inside : SV_InsideTessFactor;
};

struct HullOutputType
{
    float3 position : POSITION;
    float4 color : COLOR;
};

struct PixelInputType
{
    float4 position : SV_POSITION;
    float4 color : COLOR;
};

[domain("tri")]

PixelInputType ColorDomainShader(ConstantOutputType input, float3 uvwCoord : SV_DomainLocation, const OutputPatch<HullOutputType, 3> patch)
{
    float3 vertexPosition;
    PixelInputType output;
 
    // Determine the position of the new vertex.
    vertexPosition = uvwCoord.x * patch[0].position + uvwCoord.y * patch[1].position + uvwCoord.z * patch[2].position;
    
    // Calculate the position of the new vertex against the world, view, and projection matrices.
    output.position = mul(float4(vertexPosition, 1.0f), worldMatrix);
    output.position = mul(output.position, viewMatrix);
    output.position = mul(output.position, projectionMatrix);

    // Send the input color into the pixel shader.
    output.color = patch[0].color;

    return output;
}
```



```cpp
// cpp 코드
// Setup the description of the dynamic tessellation constant buffer that is in the hull shader.
	tessellationBufferDesc.Usage = D3D11_USAGE_DYNAMIC;
	tessellationBufferDesc.ByteWidth = sizeof(TessellationBufferType);
	tessellationBufferDesc.BindFlags = D3D11_BIND_CONSTANT_BUFFER;
	tessellationBufferDesc.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
	tessellationBufferDesc.MiscFlags = 0;
	tessellationBufferDesc.StructureByteStride = 0;

	// Create the constant buffer pointer so we can access the hull shader constant buffer from within this class.
	result = device->CreateBuffer(&tessellationBufferDesc, NULL, &m_tessellationBuffer);
	if(FAILED(result))
	{
		return false;
	}



// Set the type of primitive that should be rendered from this vertex buffer. ★★★
DC->IASetPrimitiveTopology(D3D11_PRIMITIVE_TOPOLOGY_3_CONTROL_POINT_PATCHLIST);
```

