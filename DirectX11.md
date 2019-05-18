# DirectX 11 게임 프로그래밍

## 0. 배경지식 & 윈도우 창 만들기

### 0-1. DirectX11 헤더 파일

```cpp
#include <d3d11.h>

// 셰이더를 컴파일하기 위해 포함한다.
#include <d3dcompiler.h>

// DirectXTK 라이브러리를 사용하기 위해 Pre-compiled header를 포함한다.
#include "DirectXTK/pch.h"

// DirectXTK 내부 SimpleMath 헤더에서
// <DirectXMath.h>, <DirectXPackedVector.h> 등을 포함한다.
// #include <DirectXMath.h>
// @<xnamath.h>는 deprecated.
// @namespace= DirectX
// @접두사 XM-
// 	e.g. XMMatrixIdentity(), XM_PI, ...
// #include <DirectXPackedVector.h>
// @namespace= DirectX::PackedVector

#pragma comment(lib, "d3d11.lib")
#pragma comment(lib, "d3dcompiler.lib")
#pragma comment(lib, "DirectXTK.lib")
```



### 0-2. 리소스와 뷰

#### 0-2-1. 리소스 (Resource)

`ID3D11Resource` = DirectX11에서 사용되는 모든 **리소스(Resource, 자원)**의 베이스 자료형.

리소스는 크게 **버퍼(Buffer)**이거나 **텍스처(Texture)**일 수 있다.

##### 0-2-1-1. 버퍼 (Buffer)

- 자료형: `ID3D11Buffer`

- 종류

  - **정점 버퍼(Vertex buffer)**
  - **색인 버퍼(Index buffer)**
  - 셰이더 **상수 버퍼(Constant buffer)**

- 생성

  - `ID3D11Device::CreateBuffer()`

    ```cpp
    // 셰이더에서 사용할 상수 버퍼 데이터를 담을 구조체
    struct SConstantBufferData
    {
    	XMMATRIX WorldMatrix{};
    	XMMATRIX WVPMatrix{}; // WVP = World * View * Projection
    }
    
    // 상수 버퍼 묘사
    D3D11_BUFFER_DESC constant_buffer_description{};
    	constant_buffer_description.Usage = D3D11_USAGE_DEFAULT;
    	constant_buffer_description.ByteWidth = sizeof(SConstantBufferData);
    	constant_buffer_description.BindFlags = D3D11_BIND_CONSTANT_BUFFER;
    	constant_buffer_description.CPUAccessFlags = 0;
    	constant_buffer_description.MiscFlags = 0;
    
    // 상수 버퍼 생성
    // 버퍼 생성 시에 데이터를 초기화하지 않고, 나중에 지정(Set)할 때 한다.
    // 다시 말해, xxSetConstantBuffers()를 호출하기 전에 UpdateSubresource()를 호출해 데이터를 대입한다.
    PtrDevice->CreateBuffer(&constant_buffer_description, nullptr, &PtrConstantBuffer);
    ```

    ```cpp
    // 정점 정보를 저장할 구조체 선언
    struct SVertex
    {
    	XMFLOAT4 Position{};
    }
    
    // 정점 배열 선언
    SVertex Vertices[100]{};
    
    // 정점 버퍼 묘사
    D3D11_BUFFER_DESC vertex_buffer_description{};
    	vertex_buffer_description.Usage = D3D11_USAGE_DEFAULT;
    	vertex_buffer_description.ByteWidth = sizeof(SVertex) * VertexCount;
    	vertex_buffer_description.BindFlags = D3D11_BIND_VERTEX_BUFFER;
    	vertex_buffer_description.CPUAccessFlags = 0;
    	vertex_buffer_description.MiscFlags = 0;
    
    // 정점 버퍼 데이터 대입
    D3D11_SUBRESOURCE_DATA vertex_buffer_data{};
    	vertex_buffer_data.pSysMem = &Vertices[0];
    
    // 정점 버퍼 생성
    PtrDevice->CreateBuffer(&vertex_buffer_description, &vertex_buffer_data, PtrVertexBuffer);
    ```

- 업데이트

  - 디폴트 버퍼
    - `D3D11_BUFFER_DESC::Usage`가 `D3D11_USAGE_DEFAULT`이면 `ID3D11DeviceContext::UpdateSubresource()`를 활용하여 초기값을 지정하고, 업데이트는 하지 않는다!! UpdateSubresource()가 Map()/Unmap()보다 CPU를 더 많이 사용하기 때문.
  - 동적 버퍼에 쓰기
    - `D3D11_BUFFER_DESC::Usage`가 `D3D11_USAGE_DYNAMIC`이고, `D3D11_BUFFER_DESC::CPUAccessFlags`가 `D3D11_CPU_ACCESS_WRITE`이면 `ID3D11DeviceContext::Map()`, `ID3D11DeviceContext::Unmap()`을 사용하고, `ID3D11DeviceContext::Map()` 시 `D3D11_MAP`자료형 인수에 `D3D11_MAP_WRITE_DISCARD`을 사용한다!!★
  - 스테이징 버퍼에 쓰기
    - `D3D11_BUFFER_DESC::Usage`가 `D3D11_USAGE_STAGING`이고, `D3D11_BUFFER_DESC::CPUAccessFlags`가 `D3D11_CPU_ACCESS_WRITE`이면 `ID3D11DeviceContext::Map()` 시 `D3D11_MAP`자료형 인수에 `D3D11_MAP_WRITE`을 사용한다!!
  - 스테이징 버퍼에서 읽기
    - `D3D11_BUFFER_DESC::Usage`가 `D3D11_USAGE_STAGING`이고, `D3D11_BUFFER_DESC::CPUAccessFlags`가 `D3D11_CPU_ACCESS_READ`이면 `ID3D11DeviceContext::Map()` 시 `D3D11_MAP`자료형 인수에 `D3D11_MAP_READ`을 사용한다!!

  ```cpp
  auto PtrVertexArray{};
  size_t ByteSize{};
  
  // 동적(Dynamic) 버퍼는 매핑에 D3D11_MAP_WRITE_DISCARD를 사용한다
  D3D11_MAPPED_SUBRESOURCE mapped_subresource{};
  if (SUCCEEDED(PtrDeviceContext->Map(PtrDynamicVertexBuffer, 0, D3D11_MAP_WRITE_DISCARD, 0, &mapped_subresource)))
  {
      memcpy(mapped_subresource.pData, PtrVertexArray, ByteSize);
  
  	PtrDeviceContext->Unmap(PtrDynamicVertexBuffer, 0);
  }
  ```

- **지정(필수)**

  - `ID3D11DeviceContext::IASetVertexBuffers()` 정점 버퍼 지정

  - `ID3D11DeviceContext::IASetIndexBuffer()` 색인 버퍼 지정

  - `ID3D11DeviceContext::SOSetTargets()`

  - `ID3D11DeviceContext::VSSetConstantBuffers()` ...

    ```cpp
    // 상수 버퍼에 데이터를 업데이트
    PtrDeviceContext->UpdateSubresource(PtrConstantBuffer, 0, nullptr, &ConstantBufferData, 0, 0);
    
    // 상수 버퍼 0번 슬롯에 1개 대입
    PtrDeviceContext->VSSetConstantBuffers(0, 1, &PtrConstantBuffer);
    ```

    

##### 0-2-1-2. 텍스처 (Texture)

- 자료형

  - `ID3D11Texture1D` 1차원 텍스처

  - `ID3D11Texture2D` 2차원 텍스처 (**화면 (백)버퍼**, **깊이/스텐실버퍼**)

  - `ID3D11Texture3D` 3차원 텍스처

  - `DXGI_FORMAT` 텍스처 포맷

    - (예시) `DXGI_FORMAT_R32G32B32A32_FLOAT` = 32비트 float형 4개(각각 순서대로 R, G, B, A)가 하나의 텍셀을 이룬다. 즉, 한 텍셀의 크기는 32비트 x 4 = 4바이트 x 4 = 16바이트
    - 깊이 스텐실 버퍼에서는 주로 `DXGI_FORMAT_D24_UNORM_S8_UINT` + `D3D11_BIND_DEPTH_STENCIL`을 사용한다

    ```cpp
    // 헤더 <dxgiformat.h>에 있는 내용
    
    typedef enum DXGI_FORMAT
    {
        DXGI_FORMAT_UNKNOWN	                    = 0,
        DXGI_FORMAT_R32G32B32A32_TYPELESS       = 1,
        DXGI_FORMAT_R32G32B32A32_FLOAT          = 2,
        DXGI_FORMAT_R32G32B32A32_UINT           = 3,
        DXGI_FORMAT_R32G32B32A32_SINT           = 4,
        DXGI_FORMAT_R32G32B32_TYPELESS          = 5,
        DXGI_FORMAT_R32G32B32_FLOAT             = 6,
        DXGI_FORMAT_R32G32B32_UINT              = 7,
        DXGI_FORMAT_R32G32B32_SINT              = 8,
        DXGI_FORMAT_R16G16B16A16_TYPELESS       = 9,
        DXGI_FORMAT_R16G16B16A16_FLOAT          = 10,
        DXGI_FORMAT_R16G16B16A16_UNORM          = 11,
        DXGI_FORMAT_R16G16B16A16_UINT           = 12,
        DXGI_FORMAT_R16G16B16A16_SNORM          = 13,
        DXGI_FORMAT_R16G16B16A16_SINT           = 14,
        DXGI_FORMAT_R32G32_TYPELESS             = 15,
        DXGI_FORMAT_R32G32_FLOAT                = 16,
        DXGI_FORMAT_R32G32_UINT                 = 17,
        DXGI_FORMAT_R32G32_SINT                 = 18,
        DXGI_FORMAT_R32G8X24_TYPELESS           = 19,
        DXGI_FORMAT_D32_FLOAT_S8X24_UINT        = 20,
        DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS    = 21,
        DXGI_FORMAT_X32_TYPELESS_G8X24_UINT     = 22,
        DXGI_FORMAT_R10G10B10A2_TYPELESS        = 23,
        DXGI_FORMAT_R10G10B10A2_UNORM           = 24,
        DXGI_FORMAT_R10G10B10A2_UINT            = 25,
        DXGI_FORMAT_R11G11B10_FLOAT             = 26,
        DXGI_FORMAT_R8G8B8A8_TYPELESS           = 27,
        DXGI_FORMAT_R8G8B8A8_UNORM              = 28,
        DXGI_FORMAT_R8G8B8A8_UNORM_SRGB         = 29,
        DXGI_FORMAT_R8G8B8A8_UINT               = 30,
        DXGI_FORMAT_R8G8B8A8_SNORM              = 31,
        DXGI_FORMAT_R8G8B8A8_SINT               = 32,
        DXGI_FORMAT_R16G16_TYPELESS             = 33,
        DXGI_FORMAT_R16G16_FLOAT                = 34,
        DXGI_FORMAT_R16G16_UNORM                = 35,
        DXGI_FORMAT_R16G16_UINT                 = 36,
        DXGI_FORMAT_R16G16_SNORM                = 37,
        DXGI_FORMAT_R16G16_SINT                 = 38,
        DXGI_FORMAT_R32_TYPELESS                = 39,
        DXGI_FORMAT_D32_FLOAT                   = 40,
        DXGI_FORMAT_R32_FLOAT                   = 41,
        DXGI_FORMAT_R32_UINT                    = 42,
        DXGI_FORMAT_R32_SINT                    = 43,
        DXGI_FORMAT_R24G8_TYPELESS              = 44,
        DXGI_FORMAT_D24_UNORM_S8_UINT           = 45,
        DXGI_FORMAT_R24_UNORM_X8_TYPELESS       = 46,
        DXGI_FORMAT_X24_TYPELESS_G8_UINT        = 47,
        DXGI_FORMAT_R8G8_TYPELESS               = 48,
        DXGI_FORMAT_R8G8_UNORM                  = 49,
        DXGI_FORMAT_R8G8_UINT                   = 50,
        DXGI_FORMAT_R8G8_SNORM                  = 51,
        DXGI_FORMAT_R8G8_SINT                   = 52,
        DXGI_FORMAT_R16_TYPELESS                = 53,
        DXGI_FORMAT_R16_FLOAT                   = 54,
        DXGI_FORMAT_D16_UNORM                   = 55,
        DXGI_FORMAT_R16_UNORM                   = 56,
        DXGI_FORMAT_R16_UINT                    = 57,
        DXGI_FORMAT_R16_SNORM                   = 58,
        DXGI_FORMAT_R16_SINT                    = 59,
        DXGI_FORMAT_R8_TYPELESS                 = 60,
        DXGI_FORMAT_R8_UNORM                    = 61,
        DXGI_FORMAT_R8_UINT                     = 62,
        DXGI_FORMAT_R8_SNORM                    = 63,
        DXGI_FORMAT_R8_SINT                     = 64,
        DXGI_FORMAT_A8_UNORM                    = 65,
        DXGI_FORMAT_R1_UNORM                    = 66,
        DXGI_FORMAT_R9G9B9E5_SHAREDEXP          = 67,
        DXGI_FORMAT_R8G8_B8G8_UNORM             = 68,
        DXGI_FORMAT_G8R8_G8B8_UNORM             = 69,
        DXGI_FORMAT_BC1_TYPELESS                = 70,
        DXGI_FORMAT_BC1_UNORM                   = 71,
        DXGI_FORMAT_BC1_UNORM_SRGB              = 72,
        DXGI_FORMAT_BC2_TYPELESS                = 73,
        DXGI_FORMAT_BC2_UNORM                   = 74,
        DXGI_FORMAT_BC2_UNORM_SRGB              = 75,
        DXGI_FORMAT_BC3_TYPELESS                = 76,
        DXGI_FORMAT_BC3_UNORM                   = 77,
        DXGI_FORMAT_BC3_UNORM_SRGB              = 78,
        DXGI_FORMAT_BC4_TYPELESS                = 79,
        DXGI_FORMAT_BC4_UNORM                   = 80,
        DXGI_FORMAT_BC4_SNORM                   = 81,
        DXGI_FORMAT_BC5_TYPELESS                = 82,
        DXGI_FORMAT_BC5_UNORM                   = 83,
        DXGI_FORMAT_BC5_SNORM                   = 84,
        DXGI_FORMAT_B5G6R5_UNORM                = 85,
        DXGI_FORMAT_B5G5R5A1_UNORM              = 86,
        DXGI_FORMAT_B8G8R8A8_UNORM              = 87,
        DXGI_FORMAT_B8G8R8X8_UNORM              = 88,
        DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM  = 89,
        DXGI_FORMAT_B8G8R8A8_TYPELESS           = 90,
        DXGI_FORMAT_B8G8R8A8_UNORM_SRGB         = 91,
        DXGI_FORMAT_B8G8R8X8_TYPELESS           = 92,
        DXGI_FORMAT_B8G8R8X8_UNORM_SRGB         = 93,
        DXGI_FORMAT_BC6H_TYPELESS               = 94,
        DXGI_FORMAT_BC6H_UF16                   = 95,
        DXGI_FORMAT_BC6H_SF16                   = 96,
        DXGI_FORMAT_BC7_TYPELESS                = 97,
        DXGI_FORMAT_BC7_UNORM                   = 98,
        DXGI_FORMAT_BC7_UNORM_SRGB              = 99,
        DXGI_FORMAT_AYUV                        = 100,
        DXGI_FORMAT_Y410                        = 101,
        DXGI_FORMAT_Y416                        = 102,
        DXGI_FORMAT_NV12                        = 103,
        DXGI_FORMAT_P010                        = 104,
        DXGI_FORMAT_P016                        = 105,
        DXGI_FORMAT_420_OPAQUE                  = 106,
        DXGI_FORMAT_YUY2                        = 107,
        DXGI_FORMAT_Y210                        = 108,
        DXGI_FORMAT_Y216                        = 109,
        DXGI_FORMAT_NV11                        = 110,
        DXGI_FORMAT_AI44                        = 111,
        DXGI_FORMAT_IA44                        = 112,
        DXGI_FORMAT_P8                          = 113,
        DXGI_FORMAT_A8P8                        = 114,
        DXGI_FORMAT_B4G4R4A4_UNORM              = 115,
    
        DXGI_FORMAT_P208                        = 130,
        DXGI_FORMAT_V208                        = 131,
        DXGI_FORMAT_V408                        = 132,
    
    
        DXGI_FORMAT_FORCE_UINT                  = 0xffffffff
    } DXGI_FORMAT;
    ```

    

- 생성 & 파일에서 불러오기

  - `ID3D11Device::CreateTexture1D()`

    - `D3D11_TEXTURE1D_DESC`

  - `ID3D11Device::CreateTexture2D()`

    - `D3D11_TEXTURE2D_DESC`

    ```cpp
    // 텍스처 묘사
    D3D11_TEXTURE2D_DESC texture_descrption{};
    	texture_descrption.Width = m_RawPixelData.GetWidth();
    	texture_descrption.Height = m_RawPixelData.GetHeight();
    	texture_descrption.MipLevels = 1;
    	texture_descrption.ArraySize = 1;
    	texture_descrption.Format = DXGI_FORMAT_R32G32B32A32_FLOAT;
    	texture_descrption.SampleDesc.Count = 1;
    	texture_descrption.Usage = D3D11_USAGE_DYNAMIC;
    	texture_descrption.BindFlags = D3D11_BIND_SHADER_RESOURCE;
    	texture_descrption.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
    	texture_descrption.MiscFlags = 0;
    
    // 텍스처 생성 (텅 빈 텍스처)
    PtrDevice->CreateTexture2D(&texture_descrption, nullptr, &PtrTexture2D);
    ```

  - `ID3D11Device::CreateTexture3D()`

    - `D3D11_TEXTURE3D_DESC`

  - (DirectXTK) `CreateDDSTextureFromFile()`

    ```cpp
    CreateDDSTextureFromFile(PtrDevice, L"test.dds", nullptr, &PtrShaderResourceView, 0);
    ```

  - (DirectXTK) `CreateWICTextureFromFile()`

    ```cpp
    CreateWICTextureFromFile(PtrDevice, L"test.png", nullptr, &PtrShaderResourceView, 0);
    ```

- 데이터 업데이트

  ```cpp
  D3D11_MAPPED_SUBRESOURCE mapped_subresource{};
  if (SUCCEEDED(PtrDeviceContext->Map(PtrTexture, 0, D3D11_MAP_WRITE_DISCARD, 0, &mapped_subresource)))
  {
      memcpy(mapped_subresource.pData, data, sizeof(float) * data_size);
  
      PtrDeviceContext->Unmap(PtrTexture, 0);
  }
  ```

- 파일로 저장

  - (DirectXTK) `SaveDDSTextureToFile()`
  - (DirectXTK) `SaveWICTextureToFile()`



#### 0-2-2. 뷰 (View)

생성된 리소스?(텍스처만?)는 **셰이더 리소스**(=>`ID3D11ShaderResourceView`)가 되거나 **렌더 타겟**(`ID3D11RenderTargetView `), **깊이 스텐실 버퍼(**=>`ID3D11DepthStencilView`)가 될 수 있다. 같은 리소스라도 어떻게 보느냐(View)의 차이!

##### 0-2-2-1. 셰이더 리소스 뷰 (Shader resource view)

- 설명: 셰이더에서 리소스를 사용(접근)하고 싶을 때

- 자료형: `ID3D11ShaderResourceView`

- 생성

  - `ID3D11Device::CreateShaderResourceView()`

    - `D3D11_SHADER_RESOURCE_VIEW_DESC`

    ```cpp
    // 셰이더 리소스 뷰 묘사 (2D 텍스처)
    D3D11_SHADER_RESOURCE_VIEW_DESC srv_description{};
    	srv_description.Format = DXGI_FORMAT_B8G8R8A8_UNORM;
    	srv_description.ViewDimension = D3D11_SRV_DIMENSION_TEXTURE2D;
    	srv_description.Texture2D.MostDetailedMip = 0;
    	srv_description.Texture2D.MipLevels = 1;
    
    // 셰이더 리소스 뷰 생성 (2D 텍스처)
    PtrDevice->CreateShaderResourceView(PtrTexture2D, &srv_description, &PtrShaderResourceView);
    ```

    

##### 0-2-2-2. 렌더 타겟 뷰 (Render target view)

- 설명: **픽셀 셰이더(Pixel Shader)**의 결과값이 출력되는 곳이 바로 렌더 타겟이다!

- 자료형: `ID3D11RenderTargetView`

- 생성

  - `ID3D11Device::CreateRenderTargetView()`

    - `D3D11_RENDER_TARGET_VIEW_DESC`

    ```cpp
    // 렌더 타겟으로 쓰일 버퍼 얻어오기
    ID3D11Texture2D* back_buffer{};
    PtrSwapChain->GetBuffer(0, __uuidof(ID3D11Texture2D), (void**)&back_buffer);
    
    // 렌더 타겟 뷰 생성
    PtrDevice->CreateRenderTargetView(back_buffer, nullptr, &PtrRenderTargetView);
    ```

- **지정(필수)**

  - `ID3D11DeviceContext::OMSetRenderTargets()`

    ```cpp
    // 렌더 타겟 (깊이 스텐실 버퍼 포함) 지정
    // 여기서는 1개의 렌더 타겟만 지정했지만,
    // 렌더 타겟을 여러 개로 늘리려면 갯수를 바꾸고 렌더 타겟 배열의 포인터를 대입한다.
    PtrDeviceContext->OMSetRenderTargets(1, &PtrRenderTargetView, PtrDepthStencilView);
    ```

##### 0-2-2-3. 깊이 스텐실 뷰 (Depth stencil view)

- 설명: 입체 도형(즉, z값이 존재할 때)을 여러 개 그릴 때 (픽셀 셰이더에서) 서로 겹치면 어떤 픽셀을 그릴지 결정
- 자료형: `ID3D11DepthStencilView`
- 생성
  - `ID3D11Device->CreateDepthStencilView()`
    - `D3D11_DEPTH_STENCIL_VIEW_DESC`
- **지정(필수): 렌더 타겟과 동시에 지정한다!**
  - `ID3D11DeviceContext->OMSetRenderTargets()`

#### 0-2-3. 텍스처 생성 예시 #1 (깊이 스텐실)

```cpp
// 텍스처 묘사
D3D11_TEXTURE2D_DESC depth_stencil_desc{};
depth_stencil_desc.Width = m_Size.X;
depth_stencil_desc.Height = m_Size.Y;
depth_stencil_desc.MipLevels = 1;
depth_stencil_desc.ArraySize = 1;
depth_stencil_desc.Format = DXGI_FORMAT_D24_UNORM_S8_UINT;
depth_stencil_desc.SampleDesc.Count = 1;
depth_stencil_desc.SampleDesc.Quality = 0;
depth_stencil_desc.Usage = D3D11_USAGE_DEFAULT;
depth_stencil_desc.BindFlags = D3D11_BIND_DEPTH_STENCIL;
depth_stencil_desc.CPUAccessFlags = 0;
depth_stencil_desc.MiscFlags = 0;

// 텍스처 생성
PtrDevice->CreateTexture2D(&depth_stencil_desc, nullptr, &PtrDepthStencilBuffer);

// 깊이 스텐실 뷰 생성
PtrDevice->CreateDepthStencilView(PtrDepthStencilBuffer, nullptr, &PtrDepthStencilView);
```



#### 0-2-4. 텍스처 생성 예시 #2 (셰이더 리소스용) (메모리에서 생성)

```cpp
// 사용할 텍스처 포맷 지정
DXGI_FORMAT texture_format = DXGI_FORMAT_B8G8R8A8_UNORM;

// 텍스처 묘사
D3D11_TEXTURE2D_DESC texture_descrption{};
texture_descrption.Width = m_RawPixelData.GetWidth();
texture_descrption.Height = m_RawPixelData.GetHeight();
texture_descrption.MipLevels = 1;
texture_descrption.ArraySize = 1;
texture_descrption.Format = texture_format;
texture_descrption.SampleDesc.Count = 1;
texture_descrption.Usage = D3D11_USAGE_DYNAMIC;
texture_descrption.BindFlags = D3D11_BIND_SHADER_RESOURCE;
texture_descrption.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
texture_descrption.MiscFlags = 0;

// 텍스처 생성 (데이터 없는 빈 텍스처)
PtrDevice->CreateTexture2D(&texture_descrption, nullptr, &m_RawTexture2D);

// 셰이더 리소스 뷰 묘사
D3D11_SHADER_RESOURCE_VIEW_DESC srv_description{};
srv_description.Format = texture_format;
srv_description.ViewDimension = D3D11_SRV_DIMENSION_TEXTURE2D;
srv_description.Texture2D.MostDetailedMip = 0;
srv_description.Texture2D.MipLevels = 1;

// 셰이더 리소스 뷰 생성
PtrDevice->CreateShaderResourceView(m_RawTexture2D, &srv_description, &m_RawTexture2DSRV);
```

#### 0-2-5. 텍스처 생성 예시 #3 (셰이더 리소스용) (파일에서 불러오기)

WIC포맷의 경우 #include <wincodec.h>해야 format의 GUID를 사용할 수 있음

```cpp
// 텍스처를 파일에서 불러와 생성한다.
CreateDDSTextureFromFile(PtrDevice, w_fn.c_str(), (ID3D11Resource**)&PtrTexture, &PtrShaderResourceView, 0);

// 불러온 파일의 텍스처 정보를 얻어온다.
D3D11_TEXTURE2D_DESC loaded_texture_desc{};
PtrTexture->GetDesc(&loaded_texture_desc);
```

#### 0-2-6. 텍스처 데이터(Raw data) 로딩

```cpp
void GetTextureData(WSTRING FileName) noexcept
{
    // 텍스처의 크기, 포맷을 안다고 가정했을 때 ...
    uint32_t texture_width = 800;
    uint32_t texture_height = 600;
    uint32_t color_count_per_pixel = 4; // R, G, B, A
    
    uint32_t texel_count{ texture_width * texture_height };
    uint32_t texel_y_advance{ texture_width * color_count_per_pixel };
    uint32_t data_size{ texel_count * color_count_per_pixel };
    
    // 불러온 텍스처 데이터를 저장할 배열
    float* data = new float[data_size]{};
    
	// DDS 텍스처 파일 불러오기
    ID3D11Texture2D* tex{};
    ID3D11ShaderResourceView* srv{};
    CreateDDSTextureFromFile(PtrDevice, FileName.c_str(), (ID3D11Resource**)&tex, &srv, 0);

    // 텍스처 묘사 얻어오기
    D3D11_TEXTURE2D_DESC tex_desc{};
    tex->GetDesc(&tex_desc);
    
    // 텍스처 묘사 수정
    tex_desc.CPUAccessFlags = D3D11_CPU_ACCESS_READ;
    tex_desc.Usage = D3D11_USAGE_STAGING;
    tex_desc.BindFlags = 0;

    // 데이터 접근(읽기)용 텍스처 생성
    ID3D11Texture2D* tex_access{};
    PtrDevice->CreateTexture2D(&tex_desc, nullptr, &tex_access);

    // 불러온 텍스처 데이터를 읽기용 텍스처에 복사
    PtrDeviceContext->CopyResource(tex_access, tex);

    // 읽기용 텍스처 매핑
    D3D11_MAPPED_SUBRESOURCE mapped_subresource{};
    if (SUCCEEDED(PtrDeviceContext->Map(tex_access, 0, D3D11_MAP_READ, 0, &mapped_subresource)))
    {
        // 텍스처 데이터를 data 배열에 복사
        memcpy(data, mapped_subresource.pData, sizeof(float) * data_size);

        PtrDeviceContext->Unmap(tex_access, 0);
    }

    // 리소스 해제
    tex_access->Release();
    tex_access = nullptr;
    
    tex->Release();
    tex = nullptr;
    
    srv->Release();
    srv = nullptr;

    delete[] data;
    data = nullptr;
}
```



```cpp
auto w_fn = StringToWstring(m_BaseDirectory + KAssetDirectory + FileName);

STextureData texture_data{};
auto& texture = texture_data.Texture;
auto& texture_srv = texture_data.TextureSRV;
auto& texture_size = texture_data.TextureSize;

// Load WIC texture from file.
CreateWICTextureFromFile(m_pDX->GetDevice(), w_fn.c_str(), (ID3D11Resource**)&texture, &texture_srv, 0);

if (texture)
{
    // Get texture description from loaded texture.
    D3D11_TEXTURE2D_DESC loaded_texture_desc{};
    texture->GetDesc(&loaded_texture_desc);
    texture_size.Width = loaded_texture_desc.Width;
    texture_size.Height = loaded_texture_desc.Height;

    // Modify texture description
    loaded_texture_desc.CPUAccessFlags = D3D11_CPU_ACCESS_READ;
    loaded_texture_desc.Usage = D3D11_USAGE_STAGING;
    loaded_texture_desc.BindFlags = 0;

    // Create texture for reading
    ID3D11Texture2D* readable_texture{};
    m_pDX->GetDevice()->CreateTexture2D(&loaded_texture_desc, nullptr, &readable_texture);

    // Copy texture data
    m_pDX->GetDeviceContext()->CopyResource(readable_texture, texture);

    if (loaded_texture_desc.Format == DXGI_FORMAT_B8G8R8A8_UNORM)
    {
        uint32_t color_count = 4; // B, G, R, A
        uint32_t array_size = color_count * texture_size.Width * texture_size.Height;
        unsigned char* data = new unsigned char[array_size];

        // Map the readable texture
        D3D11_MAPPED_SUBRESOURCE mapped_subresource{};
        if (SUCCEEDED(m_pDX->GetDeviceContext()->Map(readable_texture, 0, D3D11_MAP_READ, 0, &mapped_subresource)))
        {
            memcpy(data, mapped_subresource.pData, sizeof(unsigned char) * array_size);
            m_pDX->GetDeviceContext()->Unmap(readable_texture, 0);
        }

        JW_DELETE_ARRAY(data);
    }

    JW_RELEASE(readable_texture);
}

// Release all resources
JW_RELEASE(texture);
JW_RELEASE(texture_srv);
```



### 0-3. Windows OS에서 윈도우 생성

```cpp
LRESULT CALLBACK WndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	switch (uMsg)
	{
	case WM_CHAR:
		break;
	case WM_KEYDOWN:
		break;
	case WM_DESTROY:
		PostQuitMessage(0);
		return 0;
	default:
		break;
	}

	return DefWindowProc(hWnd, uMsg, wParam, lParam);
}


void CreateGameWindow(SPositionInt Position, SSizeInt Size, const STRING& Title) noexcept
{
	m_hInstance = GetModuleHandleA(nullptr);

	m_WindowSize.Width = Size.Width;
	m_WindowSize.Height = Size.Height;

	WNDCLASSEXA wc{};
	wc.cbSize = sizeof(WNDCLASSEXA);
	wc.style = CS_HREDRAW | CS_VREDRAW;
	wc.lpfnWndProc = WndProc;
	wc.cbClsExtra = 0;
	wc.cbWndExtra = 0;
	wc.hInstance = m_hInstance;
	wc.hIcon = LoadIconA(nullptr, IDI_APPLICATION);
	wc.hCursor = nullptr;
	wc.hbrBackground = nullptr;
	wc.lpszMenuName = nullptr;
	wc.lpszClassName = "GameWindow";
	wc.hIconSm = LoadIconA(nullptr, IDI_APPLICATION);

	assert(RegisterClassExA(&wc));
	
	RECT rect{};
	rect.left = Position.X;
	rect.top = Position.Y;
	rect.right = Position.X + Size.Width;
	rect.bottom = Position.Y + Size.Height;
    
	AdjustWindowRect(&rect, WS_OVERLAPPEDWINDOW, false);

	assert(m_hWnd = CreateWindowExA(0, wc.lpszClassName, Title.c_str(),
		WS_OVERLAPPEDWINDOW,
		rect.left, rect.top, rect.right - rect.left, rect.bottom - rect.top,
		nullptr, nullptr, m_hInstance, nullptr));

	ShowWindow(m_hWnd, SW_SHOW);
	UpdateWindow(m_hWnd);
}
```



#### 현재 해상도 얻어오기

```cpp
// 화면 해상도
auto resolution_w = GetSystemMetrics(SM_CXSCREEN);
auto resolution_h = GetSystemMetrics(SM_CYSCREEN);
```



#### 해상도 모드 목록 얻어오기

```cpp
IDXGIOutput* output{};
UINT mode_count{};
DXGI_MODE_DESC* mode_list{};

PtrSwapChain->GetContainingOutput(&output);

output->GetDisplayModeList(DXGI_FORMAT::DXGI_FORMAT_R8G8B8A8_UNORM, 0, &mode_count, nullptr);

mode_list = new DXGI_MODE_DESC[mode_count];
output->GetDisplayModeList(DXGI_FORMAT::DXGI_FORMAT_R8G8B8A8_UNORM, 0, &mode_count, mode_list);

SAFE_DELETE_ARRAY(mode_list);
SAFE_RELEASE(output);
```

해상도 변경하기 (전체화면일 경우. 창모드면 윈도우 크기 변경)

```cpp
DXGI_MODE_DESC mode{};
mode.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
mode.Width = 640;
mode.Height = 480;
mode.RefreshRate.Denominator = 60;
mode.RefreshRate.Numerator = 1;
mode.ScanlineOrdering = DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED;
mode.Scaling = DXGI_MODE_SCALING_CENTERED;

// 창모드일 경우, 아래 코드를 실행하면 윈도우 크기도 자동으로 같이 변경된다!!★
m_SwapChain->ResizeTarget(&mode);

m_SwapChain->ResizeBuffers(0, mode.Width, mode.Height, mode.Format, DXGI_SWAP_CHAIN_FLAG_ALLOW_MODE_SWITCH);
```



```cpp
IDXGISwapChain::GetFullscreenState();

IDXGISwapChain::ResizeTarget(); // (전체화면)해상도 변경 & (창모드)윈도우 크기 변경

IDXGISwapChain::SetFullscreenState();

IDXGISwapChain::ResizeTarget(); // 전체화면으로 바꾸면 다시 호출 With zeroed RefreshRate for DXGI to calculate it automatically (recommended by MSDN)

// @warning:
// You must destroy ID3D11RenderTargetView before calling ResizeBuffers()
IDXGISwapChain::ResizeBuffers(); 

MakeWindowAssociation(hWnd, DXGI_MWA_NO_ALT_ENTER); // ALT+ENTER 전체화면 금지
```



#### 모니터 대수 구하기

```cpp
GetSystemMetrics(SM_CMONITORS); // 모니터 개수
EnumDisplayMonitors(nullptr, nullptr, MonitorEnumProc, (LPARAM)&m_monitor_list);
MonitorEnumProc() 안에서 GetMonitorInfo(~); (Proc는 모니터 대수만큼 호출됨)
```



### 0-4. 게임의 메인 루프

```cpp
void Run() noexcept
{
    MSG msg{};
    while (m_IsRunning)
    {
        if (PeekMessage(&msg, nullptr, 0, 0, PM_REMOVE))
        {
            if (msg.message == WM_QUIT)
            {
                break;
            }

            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
        else
        {
            // 게임 관련 업데이트(Update), 그리기(Draw) 등을 여기서 실행한다.
        }
    }
}
```



## 1. DirectX11 초기화

### 1-1. 장치(Device), 장치 문맥(DeviceContext), 스왑체인(SwapChain) 생성하기

```cpp
// 필요한 변수
IDXGISwapChain*			m_SwapChain{};
ID3D11Device*			m_Device11{};
ID3D11DeviceContext*	m_DeviceContext11{};

void CreateDeviceAndSwapChain(HWND hWnd) noexcept
{
    // 스왑체인(SwapChain): 프로그램의 화면 버퍼와 후면 버퍼들을 다루는 인터페이스
    // 보통 게임에서 더블 버퍼링을 통해 깜빡임(Flickering)을 방지하는데,
    // 이 때, 바로 스왑체인이 화면 버퍼와 후면 버퍼를 교환(Swap)해주는 역할을 한다.
    // 후면 버퍼는 하나일 수도 있지만, 두 개 이상일 수도 있다.
    // 마치 사슬(Chain)처럼 여러 개가 연결되어 있다는 뜻에서 작명!
    
    // DXGI는 DirectX Graphics Infrastructure의 줄임말.
    // DirectX API를 통해 유저 모드 장치(User-mode driver)에 접근할 수 있고,
    // DXGI는 커널 모드 장치(Kernel-mode driver)와 하드웨어에 접근할 수 있다!
    
    // 스왑체인에서 사용할 화면 버퍼 묘사
	DXGI_MODE_DESC buffer_description{};
    
    // 화면 버퍼의 가로 크기(Width, 너비) 및 세로 크기(Height, 높이)
	buffer_description.Width = WindowWidth;
	buffer_description.Height = WindowHeight;
    
    // 화면 재생 빈도(Refresh rate) = 60 = 60 / 1
    // 분자 = numerator     =   60
    //                        ─────
    // 분모 = denominator   =    1
	buffer_description.RefreshRate.Numerator = 60;
	buffer_description.RefreshRate.Denominator = 1;
    
    // 화면 포맷(Format, 형식)
    // DXGI_FORMAT_R8G8B8A8_UNORM
    // R8G8B8A8 = Red 8bit, Green 8bit, Blue 8bit, Alpha 8 bit = Total 32 bit
    // UNORM = Unsigned normalized integer 부호 없는 정규화된 정수
    // UNORM의 실제 값 범위는 [0.0f, 1.0f]에 해당한다!
	buffer_description.Format = DXGI_FORMAT_R8G8B8A8_UNORM;
    
    // 화면 주사선(Scanline) 설정
    // 특별한 설정을 원하지 않는 경우, DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED를 지정한다.
	buffer_description.ScanlineOrdering = DXGI_MODE_SCANLINE_ORDER_UNSPECIFIED;
 
    // 화면 늘리기(Scaling) 설정
    // Alt + Enter로 전체화면 했을 때 화면을 어떻게 할지 설정한다.
    // DXGI_MODE_SCALING_UNSPECIFIED: 현제 프로그램 해상도를 유지
    // DXGI_MODE_SCALING_CENTERED: 화면을 가운데 맞춤
    // DXGI_MODE_SCALING_STRETCHED를: 화면을 전체 화면에 맞게 늘림
	buffer_description.Scaling = DXGI_MODE_SCALING_UNSPECIFIED;

	// 스왑체인 묘사
	DXGI_SWAP_CHAIN_DESC swap_chain_description{};
    
    // 스왑체인에서 사용할 버퍼 묘사는 방금 위에 설정한 값을 대입한다.
	swap_chain_description.BufferDesc = buffer_description;
    
    // 멀리 샘플링(Multi sampling) - 픽셀 당 샘플 갯수
	swap_chain_description.SampleDesc.Count = 1;
    
    // 멀리 샘플링(Multi sampling) - 이미지 퀄리티 레벨
    // 값 범위: [0, ID3D11Device::CheckMultisampleQualityLevels() - 1]
	swap_chain_description.SampleDesc.Quality = 0;
    
    // 버퍼 용도
    // DXGI_USAGE_RENDER_TARGET_OUTPUT: 게임 화면이 그려질 버퍼
	swap_chain_description.BufferUsage = DXGI_USAGE_RENDER_TARGET_OUTPUT;
    
    // 버퍼 개수
	swap_chain_description.BufferCount = 1;
    
    // 버퍼를 그릴 윈도우 핸들
	swap_chain_description.OutputWindow = hWnd;
    
    // 창 모드 / 전체화면 지정
	swap_chain_description.Windowed = TRUE;
    
    // 버퍼 교환(Swap) 효과
    // DXGI_SWAP_EFFECT_DISCARD: 가장 성능이 좋음
	swap_chain_description.SwapEffect = DXGI_SWAP_EFFECT_DISCARD;

	// DirectX 장치(Device)와 장치 문맥(DeviceContext), 스왑체인(SwapChain)을 동시에 만든다.
	D3D11CreateDeviceAndSwapChain(nullptr, D3D_DRIVER_TYPE_HARDWARE, nullptr, 0,
        nullptr, 0, D3D11_SDK_VERSION, &swap_chain_description, &m_SwapChain,
        &m_Device11, nullptr, &m_DeviceContext11);
}
```



### 1-2. 셰이더 코드 컴파일 및 생성

```cpp
// 필요한 변수
ID3D10Blob*			m_VSBaseBuffer{};
ID3D11VertexShader*	m_VSBase{};
ID3D10Blob*			m_PSBaseBuffer{};
ID3D11PixelShader*	m_PSBase{};

void CreateVertexShader() noexcept
{
    // 셰이더를 파일로부터 컴파일한다.
	// [DEPRECATED: D3DX11CompileFromFile()]
	D3DCompileFromFile(L"VSBase.hlsl", nullptr, D3D_COMPILE_STANDARD_FILE_INCLUDE, "main", "vs_4_0", 0, 0, &m_VSBaseBuffer, nullptr);
    // 디버깅용 플래그 : D3DCOMPILE_DEBUG | D3DCOMPILE_SKIP_OPTIMIZATION

	// 정점 셰이더(Vertex Shader) 생성
	m_Device11->CreateVertexShader(m_VSBaseBuffer->GetBufferPointer(), m_VSBaseBuffer->GetBufferSize(), nullptr, &m_VSBase);
}

void CreatePixelShader() noexcept
{
    // 셰이더를 파일로부터 컴파일한다.
	// [DEPRECATED: D3DX11CompileFromFile()]
	D3DCompileFromFile(L"PSBase.hlsl", nullptr, D3D_COMPILE_STANDARD_FILE_INCLUDE, "main", "ps_4_0", 0, 0, &m_PSBaseBuffer, nullptr);

	// 픽셀 셰이더(Pixel Shader) 생성
	m_Device11->CreatePixelShader(m_PSBaseBuffer->GetBufferPointer(), m_PSBaseBuffer->GetBufferSize(), nullptr, &m_PSBase);
}
```



VS 셰이더 코드

POSITION은 항상 VS에선 float4???

- 원래 정점 struct가 XMFLOAT2든 XMFLAOT3이든 VS에서는 float4 Pos : POSITION 이 되어야 한다!??

### 1-3. 렌더 타겟 뷰 생성 & 지정

```cpp
void CreateRenderTargetView() noexcept
{
	// 렌더 타겟으로 쓰일 백버퍼의 포인터 얻어오기
	ID3D11Texture2D* back_buffer{};
	m_SwapChain->GetBuffer(0, __uuidof(ID3D11Texture2D), (void**)&back_buffer);

	// 렌더 타겟 뷰 생성
	m_Device11->CreateRenderTargetView(back_buffer, nullptr, &m_RenderTargetView11);
	
    // 백버퍼 리소스 해제(Release)
	back_buffer->Release();
    back_buffer = nullptr;
}

void SetRenderTargetView() noexcept
{
    // 렌더 타겟 뷰 지정
    // 두 번째 항목이 pp(**)인 이유는 포인터 배열(array)이기 때문.
    // 세 번째 항목은 깊이/스텐실 뷰에 대한 포인터
	m_DeviceContext11->OMSetRenderTargets(1, &m_RenderTargetView11, nullptr);
}
```



### 1-4. 뷰포트 생성 & 지정

```cpp
// ===
// 필요한 자료형
D3D11_VIEWPORT m_DefaultViewPort{};
// ===

void CreateDefaultViewport() noexcept
{
    // 뷰포트 가로 위치
	m_DefaultViewPort.TopLeftX = 0;
    
    // 뷰포트 세로 위치
	m_DefaultViewPort.TopLeftY = 0;
    
    // 뷰포트 너비
	m_DefaultViewPort.Width = static_cast<FLOAT>(WindowWidth);
    
    // 뷰포트 높이
	m_DefaultViewPort.Height = static_cast<FLOAT>(WindowHeight);
    
    // 가장 가까운 곳의 z값
	m_DefaultViewPort.MinDepth = 0.0f;
    
    // 가장 먼 곳의 z값
	m_DefaultViewPort.MaxDepth = 1.0f;

    // 일단 기본 뷰포트를 지정한다.
    SetDefaultViewport();
}

void SetDefaultViewport() noexcept
{
    // 뷰포트 지정
	m_DeviceContext11->RSSetViewports(1, &m_DefaultViewPort);
}
```



### 1-5. 화면 버퍼 비우기, 내용 그리기, 화면 버퍼 표시하기

```cpp
void BeginDrawing(const SClearColor& ClearColor) noexcept
{
	// 화면 버퍼를 초기화할 색상 지정
	FLOAT clear_color[]{ ClearColor.R, ClearColor.G, ClearColor.B, 1.0f };

	// 렌더 타겟 뷰 초기화
	m_DeviceContext11->ClearRenderTargetView(m_RenderTargetView11, clear_color);
    
    // 셰이더 지정
	m_DeviceContext11->VSSetShader(m_VSBase, nullptr, 0);
    m_DeviceContext11->PSSetShader(m_PSBase, nullptr, 0);
}

void EndDrawing() noexcept
{
	// 후면 버퍼를 화면에 표시하기(Present)
	m_SwapChain->Present(0, 0);
}
```



## 2. 삼각형 그리기

### 2-1. 버텍스 버퍼, 색상

#### 2-1-1.

자료형: XMFLOAT2(8byte) XMFLOAT3(12byte), XMFLOAT4(16byte)

`IASetVertexBuffers()` 여러 개의 버텍스 버퍼를 한번에 지정할 수 있다!

```
IASetVertexBuffers
```

Default면 UpdateSubresource(), 이후 변경 X

Dynamic이면 Map/Unmap() 활용 (UpdateSubresource는 CPU를 더 많이 써서 느리다!!)



```cpp
struct SVertex
{
    XMFLOAT3 Position{};
    XMFLOAT4 Color{};
}
```

#### 2-1-2. 인풋 레이아웃

Syntax 이름에 숫자 못 쓴다!! 아래처럼 써야 한다.

```cpp
static constexpr D3D11_INPUT_ELEMENT_DESC KInputElementDescriptionModel[] =
{
	{"COLOR", 0, DXGI_FORMAT_R32G32B32_FLOAT, 0, 0, D3D11_INPUT_PER_VERTEX_DATA, 0},
    {"COLOR", 1, DXGI_FORMAT_R32G32B32_FLOAT, 0, 12, D3D11_INPUT_PER_VERTEX_DATA, 0},
}
```



### 2-2. 래스터라이저 스테이트 #1



```cpp
// 선언
ID3D11RasterizerState*	RSWireFrame{};
ID3D11RasterizerState*	RSSolidNoCull{};

// 생성
D3D11_RASTERIZER_DESC rasterizer_description{};
rasterizer_description.FillMode = D3D11_FILL_WIREFRAME;
rasterizer_description.CullMode = D3D11_CULL_NONE;

PtrDevice->CreateRasterizerState(&rasterizer_description, &RSWireFrame);

rasterizer_description.FillMode = D3D11_FILL_SOLID;
rasterizer_description.CullMode = D3D11_CULL_NONE;
PtrDevice->CreateRasterizerState(&rasterizer_description, &RSSolidNoCull);

// 사용
if (ShouldDrawWireFrame)
{
    PtrDeviceContext->RSSetState(RSWireFrame);
}
else
{
    PtrDeviceContext->RSSetState(RSSolidNoCull);
}
```



### 2-3. 텍스처 입히기

#### 2-3-1. 2D 텍스처 생성

```cpp
// D3DX11CreateShaderResourceViewFromFile()는 deprecated
switch (file_type)
{
case EFileType::DDS:
	CreateDDSTextureFromFile(m_pDX->GetDevice(), TextureFileName.c_str(),
	nullptr, &TextureShaderResourceView, 0);
	break;
case EFileType::WIC:
	CreateWICTextureFromFile(m_pDX->GetDevice(), TextureFileName.c_str(),
	nullptr, &TextureShaderResourceView, 0);
	break;
default:
	break;
};
```

## * CPU & GPU 프로파일링

CPU에서는 QueryPerformanceCounter()?

ID3D11Query

- ID3D11Device::CreateQuery()

D3D11_QUERY_TIMESTAMP

- ID3D11DeviceContext::End()

D3D11_QUERY_TIMESTAMP_DISJOINT

- ID3D11DeviceContext::Begin(), ID3D11DeviceContext::End()

ID3D11DeviceContext::GetData()

D3D11_QUERY_DATA_TIMESTAMP_DISJOINT

```cpp
ID3D11Query* pQueryDisjoint;
ID3D11Query* pQueryBeginFrame;
ID3D11Query* pQueryShadowClear;
ID3D11Query* pQueryShadowObjects;
ID3D11Query* pQueryMainClear;
ID3D11Query* pQueryMainObjects;
ID3D11Query* pQueryEndFrame;

void Render (ID3D11DeviceContext * pContext)
{
    // Begin disjoint query, and timestamp the beginning of the frame
    pContext->Begin(pQueryDisjoint);
    pContext->End(pQueryBeginFrame);

    // Draw shadow map
    ClearShadowMap();
    pContext->End(pQueryShadowClear);
    DrawStuffInShadowMap();
    pContext->End(pQueryShadowObjects);

    // Draw main view
    ClearMainView();
    pContext->End(pQueryMainClear);
    DrawStuffInMainView();
    pContext->End(pQueryMainObjects);

    // Display frame on-screen and finish up queries
    pSwapChain->Present(1, 0);
    pContext->End(pQueryEndFrame);
    pContext->End(pQueryDisjoint);
}
```



## 3. 사각형 그리기

### 3-1. 인덱스 버퍼

```cpp
// IA 인덱스 버퍼 지정
m_pDeviceContext->IASetIndexBuffer(m_Mesh.IndexBuffer, DXGI_FORMAT_R32_UINT, 0);

// 인덱스로 정점 그리기
// 첫 번째 인자는 인덱스 구조체 `내` 실제 인덱스 개수!!
// 즉, SIndex(0, 1, 2)일 경우 총 3개다
m_pDeviceContext->DrawIndexed(m_Mesh.IndexData.GetCount(), 0, 0);
```



### 3-2. 텍스처 입히기

```cpp
static constexpr D3D11_INPUT_ELEMENT_DESC KInputElementDescriptionMain[] =
{
	{ "POSITION"	, 0, DXGI_FORMAT_R32G32B32_FLOAT	, 0, 0, D3D11_INPUT_PER_VERTEX_DATA, 0 },
	{ "TEXCOORD"	, 0, DXGI_FORMAT_R32G32_FLOAT		, 0, 12, D3D11_INPUT_PER_VERTEX_DATA, 0 },
	{ "NORMAL"		, 0, DXGI_FORMAT_R32G32B32_FLOAT	, 0, 20, D3D11_INPUT_PER_VERTEX_DATA, 0 },
	{ "COLOR"		, 0, DXGI_FORMAT_R32G32B32A32_FLOAT	, 0, 32, D3D11_INPUT_PER_VERTEX_DATA, 0 }, // COLOR0 = Diffuse
	{ "COLOR"		, 1, DXGI_FORMAT_R32G32B32A32_FLOAT	, 0, 48, D3D11_INPUT_PER_VERTEX_DATA, 0 }, // COLOR1 = Specular
};
```



## 4. 육면체 그리기

### 4-1. 카메라-월드/뷰/프로젝션 변환

### 4-2. 상수 버퍼

상수 버퍼는 Dynamic으로, Map/DISCARD로 업데이트한다!

여러 개의 상수 버퍼를 한 번의 API Call로 처리 가능하다!

World * ViewProjection은 Vertex Shader에서 계산하자. (나중에 World 변환을 위해 World 행렬이 따로 필요해서.. WVP보다는!)

셰이더 헤더 하나로 HLSL과 CPP에서 둘 다 사용 가능하다

struct, register(b0) 모두 헤더에 넣자.



## 5. 카메라 시점 추가 (자유시점)

## 6. 육면체 그리기

### 6-1. 래스터라이저 스테이트#2

현재 카메라를 이동해 육면체 안으로 들어가면 안에서는 우리가 만든 육면체를 볼 수 없다..!!! 컬링때문!!



@ RSSetScissorRects()도 참고! D3D11_RECT

### 6-2. 텍스처 및 깊이 버퍼

```cpp
// 렌더 타겟 버퍼를 비울 때 깊이 버퍼도 같이 비워준다!
PtrDeviceContext->ClearDepthStencilView(PtrDepthStencilView, D3D11_CLEAR_DEPTH | D3D11_CLEAR_STENCIL, 1.0f, 0);
```



### 6-3. 블렌딩과 클리핑

## 7. 카메라 시점 추가 (1인칭, 3인칭)

## 8. 2D 그리기 (카메라 2D 시점)

## 9. ?? ECS 도입

## 10. 비트맵 폰트 사용하기

### 10-1. BMFont 이해

### 10-2. BMFont 파일 파싱

### 10-3. 폰트 클래스 제작

### 10-4. 타이머를 이용해 FPS 표시

## 11. 사용자 입력 받기 (윈도우/다이렉트 인풋)

## 12. 그리드 그리기

## 13. 3D 모델 파일 불러오기 #1 (obj 파일)

**그냥 파싱 버전 or Assimp 버전**

## 14. 라이팅 #1 (앰비언트 라이트)

## 15. 라이팅 #2 (디렉셔널 라이트)

## 16. 3D 모델 파일 불러오기 #2 (x 파일 - rigged)

## 17. 3D 모델 파일 불러오기 #3 (Skinned animation)

## 18. 스카이 박스

### 18-1. 큐브맵 텍스처(3D 텍스처 = 2D 텍스처 배열) 생성하기

```cpp
// 필요한 변수
ID3D11ShaderResourceView* m_ShaderResourceView{};

CreateDDSTextureFromFileEx(m_pDX->GetDevice(), TextureFileName.c_str(), 0,
	D3D11_USAGE_DEFAULT, D3D11_BIND_SHADER_RESOURCE, 0,
	D3D11_RESOURCE_MISC_TEXTURECUBE, false, nullptr, &m_ShaderResourceView);
```

```cpp
// 셰이더 헤더
// 필요한 구조체
struct SKY_MAP_OUTPUT
{
	float4 Position	: SV_POSITION;
	float3 TexCoord	: TEXCOORD;
};
```

```cpp
// 정점 셰이더
cbuffer cbWorld
{
	float4x4 WVP;
	float4x4 World;
};

// 정점 셰이더
SKY_MAP_OUTPUT main(VS_INPUT_STATIC input)
{
	SKY_MAP_OUTPUT output;

    // z값 대신 w값을 쓴다.
    // w값은 항상 1인데, z값이 1이어야 항상 하늘이 다른 모든 것보다 더 멀리 그려지기 때문이다!
	output.Position = mul(input.Position, WVP).xyww;
    
    // 원점이 중심인 구의 텍스쳐 좌표는 정점의 위치와 같다!
	output.TexCoord = input.Position.xyz;

	return output;
}
```

```cpp
// 픽셀 셰이더
TextureCube SkyMapTexture;
SamplerState CurrentSamplerState;

float4 main(SKY_MAP_OUTPUT input) : SV_Target
{
	return SkyMapTexture.Sample(CurrentSamplerState, input.TexCoord);
}
```

## 19. GPU 애니메이션

2D 텍스처-> 각 애니메이션의 최종 본 행렬(final bone transformation matrix) 저장 (max_bone = 50으로 제한)

텍스처 포맷은 DXGI_FORMAT_R32G32B32A32_FLOAT -> 즉, 한 텍셀(texel)이 16바이트(128비트)

4x4행렬 = float 16개 = 4 byte * 16 개 = 64 byte per matrix

**텍셀 4개 = 행렬 1개**

행렬 50개 = 텍셀 200개 = 애니메이션 한 프레임(frame)

60 frame 애니메이션 = 200 * 60으로  충분!

 => 60 frame 애니메이션 50개 = 200 * 3000 텍스처!!

but 맨 첫줄엔 각 애니메이션에 대한 frame 수와 offset을 넣자 (텍셀 2개 = 32바이트!)

 => 즉, 가로 200텍셀이므로 맨 첫줄에만 100개 애니메이션에 대한 정보를 넣을 수 있음...! WOW

 => 첫 애니메이션은 T-Pose로 할까..?? 텍셀 200개 즉, 한 줄이면 충분한데... 고민되네?

애니메이션 ID, 현재 시간값은 정점 셰이더에 상수 버퍼로 넣자! (모델마다 달라지는 거기 때문! 만약 인스턴싱을 한다면 정점(인스턴싱) 버퍼에 넣어야 하려나..??★)

```cpp
// Animation texture
void CreateSharedResource(SSizeInt TextureSize) noexcept
{
    m_vpSharedResources.push_back(nullptr);
    auto& current_srv = m_vpSharedResources[m_vpSharedResources.size() - 1];

    D3D11_TEXTURE2D_DESC texture_descrption{};
    texture_descrption.Width = TextureSize.Width;
    texture_descrption.Height = TextureSize.Height;
    texture_descrption.MipLevels = 1;
    texture_descrption.ArraySize = 1;
    texture_descrption.Format = DXGI_FORMAT_R32G32B32A32_FLOAT;
    texture_descrption.SampleDesc.Count = 1;
    texture_descrption.Usage = D3D11_USAGE_DYNAMIC;
    texture_descrption.BindFlags = D3D11_BIND_SHADER_RESOURCE;
    texture_descrption.CPUAccessFlags = D3D11_CPU_ACCESS_WRITE;
    texture_descrption.MiscFlags = 0;

    ID3D11Texture2D* texture{};

    // Create the texture
    m_pDX->GetDevice()->CreateTexture2D(&texture_descrption, nullptr, &texture);

    D3D11_SHADER_RESOURCE_VIEW_DESC srv_description{};
    srv_description.Format = texture_descrption.Format;
    srv_description.ViewDimension = D3D11_SRV_DIMENSION_TEXTURE2D;
    srv_description.Texture2D.MostDetailedMip = 0;
    srv_description.Texture2D.MipLevels = 1;

    // Create the shader resource view.
    m_pDX->GetDevice()->CreateShaderResourceView(texture, &srv_description, &current_srv);

    JW_RELEASE(texture);

    if (current_srv == nullptr)
    {
        m_vpSharedResources.pop_back();
    }
}
```

```cpp
void LoadAnimationTextureFromFile(STRING FileName) noexcept
{
    m_vAnimationTextureData.push_back(SAnimationTextureData());

    auto& current_tex = m_vAnimationTextureData[m_vAnimationTextureData.size() - 1].Texture;
    auto& current_srv = m_vAnimationTextureData[m_vAnimationTextureData.size() - 1].TextureSRV;
    auto& current_tex_size = m_vAnimationTextureData[m_vAnimationTextureData.size() - 1].TextureSize;

    WSTRING w_fn = StringToWstring(m_BaseDirectory + KAssetDirectory + FileName);

    // Load texture from file.
    CreateDDSTextureFromFile(m_pDX->GetDevice(), w_fn.c_str(), (ID3D11Resource**)&current_tex, &current_srv, 0);

    // Get texture description from loaded texture.
    D3D11_TEXTURE2D_DESC loaded_texture_desc{};
    current_tex->GetDesc(&loaded_texture_desc);
    current_tex_size.Width = loaded_texture_desc.Width;
    current_tex_size.Height = loaded_texture_desc.Height;

    if (current_srv == nullptr)
    {
        JW_RELEASE(current_tex);

        m_vAnimationTextureData.pop_back();
    }
}
```

본 애니메이션 텍스처화 -> 정점 셰이더(GPU)에서 처리하기

```cpp
Texture2D<float4> anim_tex : register(t0);

// 보간 없이 불러오기
float4x4 LoadMatrixFromTexture(uint BoneID)
{
    // Get current animation's info
	float4 anim_info = anim_tex.Load(uint3(AnimationID, 0, 0));
	uint start_y = anim_info.y;
    
    // Get current frame's bone matrix
	float4 mat_1 = anim_tex[uint2(BoneID * 4 + 0, start_y + CurrFrame)];
	float4 mat_2 = anim_tex[uint2(BoneID * 4 + 1, start_y + CurrFrame)];
	float4 mat_3 = anim_tex[uint2(BoneID * 4 + 2, start_y + CurrFrame)];
	float4 mat_4 = anim_tex[uint2(BoneID * 4 + 3, start_y + CurrFrame)];

	float4x4 mat = float4x4(mat_1, mat_2, mat_3, mat_4);

	return mat;
}

// 선형 보간 버전
float4x4 LoadMatrixFromTextureWithInterpolation(uint BoneID)
{
	// Get current animation's info
	float4 anim_info = anim_tex.Load(uint3(AnimationID, 0, 0));
	uint start_y = anim_info.y;

	// Get current frame's bone matrix
	float4 mat_1 = anim_tex[uint2(BoneID * 4 + 0, start_y + CurrFrame)];
	float4 mat_2 = anim_tex[uint2(BoneID * 4 + 1, start_y + CurrFrame)];
	float4 mat_3 = anim_tex[uint2(BoneID * 4 + 2, start_y + CurrFrame)];
	float4 mat_4 = anim_tex[uint2(BoneID * 4 + 3, start_y + CurrFrame)];
	float4x4 mata = float4x4(mat_1, mat_2, mat_3, mat_4);

	// Get next frame's bone matrix
	mat_1 = anim_tex[uint2(BoneID * 4 + 0, start_y + NextFrame)];
	mat_2 = anim_tex[uint2(BoneID * 4 + 1, start_y + NextFrame)];
	mat_3 = anim_tex[uint2(BoneID * 4 + 2, start_y + NextFrame)];
	mat_4 = anim_tex[uint2(BoneID * 4 + 3, start_y + NextFrame)];
	float4x4 matb = float4x4(mat_1, mat_2, mat_3, mat_4);

	// Apply linear interpolation
	mata = mata + DeltaTime * (matb - mata);

	return mata;
}
```

```cpp
void BakeAnimationsIntoTexture(SAnimationTextureData* PtrAnimationTexture)
{
    if (PtrModel->RiggedModelData.AnimationSet.vAnimations.size())
    {
        auto& vec_animations{ PtrModel->RiggedModelData.AnimationSet.vAnimations };

        auto& texture_size{ PtrAnimationTexture->TextureSize };
        uint32_t texel_count{ texture_size.Width * texture_size.Height };
        uint32_t texel_y_advance{ texture_size.Width * KColorCountPerTexel };
        uint32_t data_size{ texel_count * KColorCountPerTexel };
        float* data = new float[data_size] {};

        //
        // Set animation set's info
        // (with maximum bone count = KMaxBoneCount)
        // data[0 ~ 3] = Animation ID 0 = TPose
        //
        // TPose frame count(=texel line count)
        data[0] = 1;
        // TPose texel start y index
        data[1] = 1;
        // Reserved
        data[2] = 0; 
        // Reserved
        data[3] = 0;

        for (uint16_t iter_anim = 0; iter_anim < vec_animations.size(); iter_anim++)
        {
            // current animation's frame count(=texel line count)
            data[4 + iter_anim * 4] = static_cast<float>(vec_animations[iter_anim].TotalFrameCount);

            // current animation's texel start y index
            data[4 + iter_anim * 4 + 1] = data[iter_anim * 4] + data[1 + iter_anim * 4];

            // Reserved
            //data[4 + iter_anim * 4 + 2] = 0;

            // Reserved
            //data[4 + iter_anim * 4 + 3] = 0;
        }

        // Bake animations into the texture
        uint32_t start_index{ texel_y_advance };
        XMMATRIX frame_matrices[KMaxBoneCount]{};

        // TPose into FrameMatrices
        SaveTPoseIntoFrameMatrices(frame_matrices, PtrModel->RiggedModelData,
                                   PtrModel->RiggedModelData.NodeTree.vNodes[0], XMMatrixIdentity());

        // Bake FrameMatrices into Texture
        BakeCurrentFrameIntoTexture(start_index, frame_matrices, data);

        // Update start index
        start_index += texel_y_advance;

        for (uint16_t anim_index = 0; anim_index < vec_animations.size(); anim_index++)
        {
            // This loop iterates each animation, starting from vec_animations[0]

            float frame_time{};

            for (uint16_t frame_index = 0; frame_index < vec_animations[anim_index].TotalFrameCount; frame_index++)
            {
                frame_time = static_cast<float>(frame_index) * vec_animations[anim_index].AnimationTicksPerGameTick;

                // Current frame into FrameMatrices
                SaveAnimationFrameIntoFrameMatrices(frame_matrices, anim_index, frame_time,
                                                    PtrModel->RiggedModelData, PtrModel->RiggedModelData.NodeTree.vNodes[0], XMMatrixIdentity());

                // Bake FrameMatrices into Texture
                BakeCurrentFrameIntoTexture(start_index, frame_matrices, data);

                // Update start index
                start_index += texel_y_advance;
            }
        }

        D3D11_MAPPED_SUBRESOURCE mapped_subresource{};
        if (SUCCEEDED(PtrDX->GetDeviceContext()->Map(PtrAnimationTexture->Texture, 0, D3D11_MAP_WRITE_DISCARD, 0, &mapped_subresource)))
        {
            memcpy(mapped_subresource.pData, data, sizeof(float) * data_size);

            PtrDX->GetDeviceContext()->Unmap(PtrAnimationTexture->Texture, 0);
        }

        // Save this texture data's pointer
        PtrBakedAnimationTexture = PtrAnimationTexture;

        JW_DELETE_ARRAY(data);
    }
}

inline void BakeCurrentFrameIntoTexture(uint32_t StartIndex, const XMMATRIX* FrameMatrices, float*& OutData) noexcept
{
    XMFLOAT4X4A current_matrix{};
    const int matrix_size_in_floats = 16;

    for (uint16_t bone_index = 0; bone_index < KMaxBoneCount; ++bone_index)
    {
        XMStoreFloat4x4(&current_matrix, FrameMatrices[bone_index]);

        memcpy(&OutData[StartIndex + bone_index * matrix_size_in_floats], current_matrix.m, sizeof(float) * matrix_size_in_floats);
    }
}
```



## 20. 피킹(Picking) & 바운딩볼륨(Bounding volume)

평면의 방정식...

마우스 위치: GetCursorPos(), ScreenToClient()

마우스 Screen space -> World space 변환



## 21. 인스턴싱(Instancing)

`D3D11_INPUT_ELEMENT_DESC`구조체의 `InputSlotClass`에 `D3D11_INPUT_PER_INSTANCE_DATA`를 대입, `InstanceDataStepRate`는 `1`을 대입한다.



드로우콜은 `ID3D11DeviceContext::DrawIndexedInstanced()`를 호출한다.

```cpp
static constexpr D3D11_INPUT_ELEMENT_DESC KInputElementDescriptionModel[] =
{
    // Vertex buffer #0 (VertexModel)
    { "POSITION"	, 0, DXGI_FORMAT_R32G32B32_FLOAT, 0, 0, D3D11_INPUT_PER_VERTEX_DATA, 0 },
    { "TEXCOORD"	, 0, DXGI_FORMAT_R32G32_FLOAT	, 0, 12, D3D11_INPUT_PER_VERTEX_DATA, 0 },
    { "NORMAL"		, 0, DXGI_FORMAT_R32G32B32_FLOAT, 0, 20, D3D11_INPUT_PER_VERTEX_DATA, 0 },
    { "COLOR"		, 0, DXGI_FORMAT_R32G32B32A32_FLOAT	, 0, 32, D3D11_INPUT_PER_VERTEX_DATA, 0 }, // Diffuse
    { "COLOR"		, 1, DXGI_FORMAT_R32G32B32A32_FLOAT	, 0, 48, D3D11_INPUT_PER_VERTEX_DATA, 0 }, // Specular

    // Vertex buffer #1 (VertexRigging)
    { "BLENDINDICES", 0, DXGI_FORMAT_R32G32B32A32_UINT	, 1, 0, D3D11_INPUT_PER_VERTEX_DATA, 0 }, // int BoneID[4]
    { "BLENDWEIGHT"	, 0, DXGI_FORMAT_R32G32B32A32_FLOAT	, 1, 16, D3D11_INPUT_PER_VERTEX_DATA, 0 }, // float Weight[4]

    // Vertex buffer #2 (Instance buffer)
    { "INST_WORLD", 0, DXGI_FORMAT_R32G32B32A32_FLOAT, 2, 0, D3D11_INPUT_PER_INSTANCE_DATA, 1 },
    { "INST_WORLD", 1, DXGI_FORMAT_R32G32B32A32_FLOAT, 2, 16, D3D11_INPUT_PER_INSTANCE_DATA, 1 },
    { "INST_WORLD", 2, DXGI_FORMAT_R32G32B32A32_FLOAT, 2, 32, D3D11_INPUT_PER_INSTANCE_DATA, 1 },
    { "INST_WORLD", 3, DXGI_FORMAT_R32G32B32A32_FLOAT, 2, 48, D3D11_INPUT_PER_INSTANCE_DATA, 1 },
};

// VertexShader
VS_OUTPUT_MODEL main(VS_INPUT_MODEL input)
{
	VS_OUTPUT_MODEL output;

	float4 position_result = input.Position;

    if (IsInstanced)
    {
        float4x4 instance_world = float4x4(
            input.InstanceWorld0,
            input.InstanceWorld1,
            input.InstanceWorld2,
            input.InstanceWorld3);

        position_result = mul(position_result, instance_world);
    }
    
    //...
}
```

VS에서 SV_InstanceID를 사용하면 셰이더에서 인스턴스의 ID를 제공해 준다.

## 22. 절두체 컬링 (Frustum culling)

Bounding sphere 활용!!!

절두체 8개 정점 구하기

평면의 법선 구하기

엔티티 위치를 평면 법선에 투영하여 내적 -> 값이 0보다 크면 평면 바깥에 위치함!

## 23. 지형(Terrain), 높이맵(Height map)

### 23-1. 높이맵(Height map)

### 23-2. 노멀 매핑 (Normal mapping)

normal space -> tangent space 변환 필요

TBN matrix (tangent, bitangent, normal를 기저로 하는 기저 변환 행렬)

tangent: u방향 벡터

bitangent: v 방향 벡터

기타 텍스처 효과: 스페큘러 매핑, 알파 매핑, 라이트맵

### 23-3. 쿼드 트리, LOD

쿼드 트리를 활용해 지형 탐색 속도를 향상시킨다.

밉맵 활용하기

## 24. 반사Reflection 물, 거울

굴절은 Refraction

RTT 텍스처에 그리기

## 24. 충돌(Collision)

구-삼각형 충돌

- 구-평면
- 원-삼각형

## 25. 미니맵 - 텍스처에 그리기(RTT)

## 26. 빌보딩 (Billboard)

원거리 지오메트리 렌더링

## 음향 효과 (Direct Sound? FMOD?)

## 27. 레벨 에디터 만들기 - GUI & 3D Gizmo

Dear ImGui

In-code 3D Gizmo mesh 생성

Mini axis 화면 우측 상단에..

Map 파일 구성요소: Terrain, Objects(Tree, building, ...) + ObjectList

지형 선택 및 변형 (구로 선택)

## 지오메트리 셰이더 - Grass instancing (Geometry instancing)

## 후처리 효과(Post-processing effects)

### fog

linear blending 

fog_factor = [0, 1]  <= 0 if (distance <= d_min), 1 if (distance >= d_max)

final_color = final_color * (1-fog_factor) + flog color * fog_factor

### blur

### bloom

 -> downscale -> bright-pass filter(luminance threshold) -> blur -> additive blending

## 디퍼드 셰이딩 - Pointlight, spotlight, ...



## 테셀레이션