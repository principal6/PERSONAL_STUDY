# 3DS MAX PLUGIN
## Exporter
DLE 파일! <> DLI
SceneExport 클래스 상속 필요
IGameExporter sample 참고
SceneExport::DoExport() 에서 Export가 실시됨

다음 가상함수들 구현 필요
> SceneExport::ExtCount() - The number of supported file extensions
> 
> SceneExport::Ext() - The nth file extension without leading ".". E.g. "txt" instead of ".txt"
> 
> SceneExport::LongDesc() - A detailed file output description.
> 
> SceneExport::ShortDesc() - A short description of the exported file type, which appears in file save dialog.
> 
> SceneExport::AuthorName() - A long description of the exported file type.
> 
> SceneExport::CopyrightMessage() - A copyright message.
> 
> SceneExport::OtherMessage1() - A message string.
> 
> SceneExport::OtherMessage2() - Another message string.
> 
> SceneExport::Version() - The version number of the export plug-in. The format is the major number times 100 plus the minor version. E.g. version 1.03 would be represented as 103.
> 
> SceneExport::ShowAbout() - Called in response to display an about box.
> 
> SceneExport::DoExport() - Perform the file export.

### 필수 구현 DLL 함수
https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_608B1265_B25E_47BB_A49B_5AF2A27F71CC_htm
> DllMain() noexcept
```cpp
HINSTANCE hInstance{};
BOOL WINAPI DllMain(HINSTANCE hinstDLL, ULONG fdwReason, LPVOID /*lpvReserved*/)
{
    if (fdwReason == DLL_PROCESS_ATTACH)
    {
        // Hang on to this DLL's instance handle.
        hInstance = hinstDLL;
        DisableThreadLibraryCalls(hInstance);
    }
    return TRUE;
}
 
__declspec( dllexport ) const TCHAR* LibDescription()
{
    // Retrieve a string from the resource string table
    static TCHAR buf[256]{};
    if (hInstance) return LoadString(hInstance, IDS_LIBDESCRIPTION, buf, sizeof(buf)) ? buf : nullptr;
    return nullptr;
}
 
__declspec( dllexport ) int LibNumberClasses()
{
    return 1;
}
 
__declspec( dllexport ) ClassDesc* LibClassDesc(int i)
{
    switch(i)
    {
    case 0:
        return GetSimpleWidgetDesc();
    }

    return 0;
}
 
__declspec( dllexport ) ULONG LibVersion()
{
    return Get3DSMAXVersion();
}
 
__declspec( dllexport ) int LibInitialize()
{
    // TODO: Perform initialization here.
    return TRUE;
}
 
__declspec( dllexport ) int LibShutdown()
{
    // TODO: Perform uninitialization here.
    return TRUE;
}
```

### DEF 파일
```def
LIBRARY MyPlugIn.dll
EXPORTS
   LibDescription   @1
   LibNumberClasses @2
   LibClassDesc     @3
   LibVersion       @4
SECTIONS
.data READ WRITE
```

### RC 파일 (Resource 파일)
안에 포함(#include)되어야할 것들
> veroverrrides.h - This is a file that is defined on a per-project level. Here you can can redefine some standard symbols for company name, copyrights, product name, etc. This file needs to be included in the plug-in's .rc file, before maxversion.r.
> 
> maxversion.r - This is found in the SDK include folder and is required to be used by all plug-ins in order to add a file version resource to it that contains the standard entries expected of a plug-in DLL.


## Utility Plug-in (.DLU)
http://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__developer_3ds_max_sdk___the_learning_path_lesson_1_sample_utility_plug_in_html

UtilityObj 를 상속
roll-out panel 있음
UtilityObj::BeginEditParams(): Command Panel에서 선택되면 호출됨
UtilityObj::EndEditParams(): 더이상 사용 안 될 때 호출됨
UtilityObj::SelectionSetChanged()
UtilityObj::DeleteThis()
UtilityObj::SetStartupParam()

# Max Script
## tutorial
https://www.youtube.com/watch?v=H030WBIfzF8

## SDK Documentation
http://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_F039181A_C072_4469_A329_AE60FF7535E7_htm
http://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_46ECBAD7_35E9_43BD_8A8C_849772924805_htm
http://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_B83B4297_B521_4553_A22D_B812AFA766C4_htm

## 예제
```ms
fileIn "FSEngineMain.ms"

global mainFloater
macroscript FSEngine
	category:"FSEngine" --Customize-Toolbars-Category 항목
	tooltip:"FSEngine Toolbar" --Cutomize 내 Item 이름이자, 마우스 올리면 나오는 설명
	buttontext:"FSEngine" --툴바 내 버튼 이름
(
	try (closeRolloutFloater mainFloater) catch()

	mainFloater = newRolloutFloater "Main" 300 200

	addRollout fsMainRollout mainFloater
)
```


## 자료형
### 형변환
as integer
as string
as eulerAngles

### string
local str = "가" + (123 as string) + "나"
str.count
substring <string> offset count

### 배열
local arr = #()
append <array> <value>
appendIfUnique <array> <value>
insertItem
deleteItem
findItem
free arr -- @IMP

### struct
```ms
struct VertexData
(
	_position	= point3 0 0 0,
	_normal     = point3 0 0 0,
	_color		= point3 0 0 0,
	_uv			= point2 0 0
)

local var = VertexData() -- 인스턴스 선언 방법
```

### point3
<point3>.x: Float -- the x coordinate
<point3>.y: Float -- the y coordinate
<point3>.z: Float -- the z coordinate
<point3> == <point3>
<point3> != <point3>
<point3> + <point3_or_number>
<point3> - <point3_or_number>
<point3> * <point3_or_number>
<point3> / <point3_or_number>
local vertex_normal = Point3 0 0 0

length <point3>

## loop
```ms
for i = 1 to myCount do
(

)
```

## UI Control
### 속성
```ms
button btnA "A" width:120 pos:[8, 24] enabled:false border:false visible:true
button btnB "B" width:120 align:#left
button btnC "C" width:120 align:#center -- 기본이 중앙
button btnC "C" width:120 offset:[4, 0]
```

### 종류
```ms
label theLabel "Label" offset:[0,20]
dropdownlist theDDL "DropDownList:" items:#("Item 1","Item 2") width:80 across:2
listbox theListbox "Listbox:" items:#("Item 1","Item 2") height:3 width:80 across:2
multilistbox theMLBox "Multilistbox:" items:#("Item 1","Item 2") height:3 width:80
edittext theEdittext "Edittext:"
angle theAngle "Angle" width:80 across:2 degrees:45 align:#left
slider theSlider "Slider:" orient:#vertical
spinner theSpinner "Spinner:"
group "Group" (
button theButton "Button" across:2 width:80 align:#left
checkbutton theCheckbutton "Checkbutton" width:80 align:#right
mapbutton theMapButton "Map Button" width:80 across:2 align:#left
materialbutton theMatButton "Material Button" width:80 align:#right
pickbutton thePickbutton "Pickbutton:" width:80)
checkbox theCheckbox "Checkbox" [checked:false] across:2 offset:[0,2]
colorpicker theColorpicker "Colorpicker:"
combobox theCombobox "Combobox:" items:#("Item 1","Item 2") height:3 width:80
hyperlink theHyperlink "Hyperlink" url:"http://www.autodesk.com" color:red across:2 offset:[10,20]
groupBox theGroupbox "Groupbox:" height:40 offset:[0,-40] width:174
progressbar theProgressbar "Progressbar:" value:50
radiobuttons theRadiobuttons labels:#("Option 1","Option 2")
bitmap theBitmap "Bitmap" width:80 height:50 offset:[0,0] bitmap:(bitmap 80 50 color:red) align:#left across:2
imgTag theImgTag "Bitmap" width:80 height:50 offset:[0,0] bitmap:(bitmap 80 50 color:green) align:#right
SubRollout theSubrollout "Subrollout" height:50
curvecontrol theCurvecontrol "Curvecontrol:" height:150
```

### Utility에 rollout 만들기
```ms
utility name "title"
(

)
```
```ms
group "이름"
(

)
```

```ms
addRollout [롤아웃] [대상]
removeRollout [롤아웃]

myFloater = newRolloutFloater "Title" myWidth myHeight
closeRolloutFloater myFloater

slider orient:#vertical across:5
spinner -- 범위 정해진 숫자..
```

## 함수 정의
```ms
function myFunc arg0 arg1 =
(

)

function refFunc &refArg =
(

)
```

## 메소드
```
-- open, close, pressed, changed
on fsMainRollout open do
(

)
```

### 지오메트리 메소드
https://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_D1D7EB56_A370_4B07_99B4_BC779FB87CAF_htm#WS3ED54CBA79FF2E3DDCBAB2212B7835B3AF-7E0A

```ms
numPoints
```

## 파일 다루기
```ms
fileIn "파일명" -- 현재 경로(기본 scriptsPath)에서 파일을 불러들인다
fileIn (scriptsPath + "FSEngine\my.ms")
scriptsPath -- @IMP
maxFilePath -- 현재 열린 파일의 경로!
maxFileName -- 현재 열린 파일의 이름!!
getSavePath [caption:<window_caption_string>] [initialDir:<pathname>] 
sysInfo.windowsdir
sysInfo.systemdir
sysInfo.tempdir
sysInfo.currentdir
doesFileExist
getINISetting <filename_string> <section_string> <key_string>
setINISetting <filename_string> <section_string> <key_string> <key_value_string> [ forceUTF16:<boolean> ]
delIniSetting <filename_string> <section_string> <key_string>   
getFiles <wild_card_filename_string>
getDirectories <wild_card_directory_name_string>
makeDir <directory_path_string> all:<boolean> 
hiddenDOSCommand() -- 디렉토리 지우려면...
deleteFile <filename_string> 
renameFile <old_filename_string> <new_filename_string> 
copyFile <existing_filename_string> <target_filename_string> 
getFileSize <filename_string> 
getFileAttribute <filename_string> <attribute> 
setFileAttribute <filename_string> <attribute> <boolean> 
getFileSecurityInfo <file_name> <attribute> testFileAttribute: <bool> 
isDirectoryWriteable <dir_name> 
createFile <filename_string> [encoding:]
openFile <filename_string> [mode:] [encoding:]
 -- openFile selectedFileName mode:#wt (write, text)
 -- openFile selectedFileName mode:#wb (write, binary)
 -- openFile selectedFileName mode:#r+ (read + write)
readLine <filestream>
readChar <filestream>
readChars <filestream> <char_count>
readDelimitedString <filestream> <string>
filePos <filestream>
seek <filestream> <integer>
eof <filestream>
close <filestream> --★중요
free <filestream>
print <value> to:<filestream>
format <fmt_string> { <value> } to:<filestream>
```

### 바이너리 파일
```ms
<BinStream>fopen <String fileName> <String mode>
<Boolean>fclose <BinStream>
<Boolean>fseek <BinStream> <Integer> <#seek_set | #seek_cur | #seek_end>
<Integer>ftell <BinStream>
writeByte <BinStream> <Integer> [#signed | #unsigned]
writeShort <BinStream> <Integer> [#signed | #unsigned]
writeLong <BinStream> <Integer> [#signed | #unsigned]
writeFloat <BinStream> <Float>
writeString 
<Integer>readByte <BinStream> [#signed | #unsigned]
```

## 기타 시스템 변수/함수 (System Globals)
```ms
sysInfo.username
sysInfo.computername
sysInfo.cpucount
sysInfo.desktopSize
sysinfo.getSystemMemoryInfo()
rootNode -- children 참조
rootScene 
sliderTime --@IMP 각 프레임!! (set, get 가능!)
getDir #temp -- #maxroot
undefined
pi
e
keyboard.shiftPressed
keyboard.controlPressed
keyboard.altPressed
keyboard.escPressed 
listener
localTime
getLocalTime() -- @IMP array로 리턴해줌!!
rootNode -- @IMP Scene 내 모든 노드의 부모!
sceneMaterials 
trackbar.visible 
units.MetricType 
apropos "light"
showClass "path*"
showClass "noise.*"
showClass "*:mod*" -- :뒤에는 superclass!
showClass "*.*" to:<stream>
showProperties 
hasProperty 
```

## dotNetObject
```ms
openFileDialog = dotNetObject "System.Windows.Forms.OpenFileDialog" -- SaveFileDialog도 있음!
openFileDialog.Title = "내보내기"
openFileDialog.Filter = "txt files (*.txt)|*.txt|Script Files (*.ms)|*.ms|ini files (*.ini)|*.ini|XML files (*.xml)|*.xml|All files (*.*)|*.*"
ofdResult = openFileDialog.ShowDialog()
dlgResult = dotNetClass "System.Windows.Forms.DialogResult"
if (ofdResult == dlgResult.OK) do
(
    selectedFileName = openFileDialog.Filename
)
```

## modifier
local mod_edit_mesh = Edit_Mesh()
addModifier selected_object mod_edit_mesh
deleteModifier selected_object mod_edit_mesh

getSelectionLevel <maxobject> 
setSelectionLevel <maxobject> {#object | #vertex | #edge | #face} 

modPanel

## skinops

## geometry, node
for node in geometry do ...

### node  @IMP
<node>.name
<node>.material
<node>.parent
<node>.children
<node>.mesh
<node>.wireColor
<node>.isHidden -- @IMP: 눈 모양!
<node>.isFrozen -- @IMP
<node>.visibility
<node>.transform  -- @IMP: 기본 좌표계는 world 좌표계!!!!
<node>.transform.translationpart
<node>.transform.rotationpart
<node>.transform.scalepart

## mesh 
http://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_0532C071_4401_4846_8450_3DA5510A3883_htm#GUID-E6E4714A-35EF-4F00-8A13-0F4AEE33D0DD

```ms
<mesh>.material
<mesh>.numFaces -- @IMP
<mesh>.faces
<mesh>.numVerts
<mesh>.vertices
<mesh>.edges
tVertCount = (getNumTVerts <mesh>)

getFace <mesh> <face_index> --@IMP @IMP
getFaceNormal <mesh> <face_index> --@IMP 아 이거 로컬 기준 노멀이므로 주의!!!!
getVert <mesh> <vert_index_integer> -- position만 얻어옴
getNormal <mesh> <vert_index_integer>
getTVert <mesh> <tvert_index_integer>
meshop.getVertsByColor <Mesh mesh> <color color> <float red_thresh> <float green_thresh> <float blue_thresh> channel:<int=0>
meshop.getVertsByColor <Mesh mesh> <point3 uvw> <Float u_thresh> <Float v_thresh> <Float w_thresh> channel: <int=0>
meshop.getVertWeight <Mesh mesh> <int vertIndex>
meshop.getVAlpha <Mesh mesh> <int vertIndex>

meshop.getNumVerts
meshop.getNumFaces
meshop.getFacesUsingVert
meshop.getPolysUsingVert -- @IMP 이걸로 해야 PolygonFace를 얻는다...!!!

meshop.getNumMaps
meshop.getMapSupport -- @IMP @IMP (-2: alpha, -1: illumination, 0: color, 1: texture)
meshop.getNumMapFaces
meshop.getNumMapVerts -- @IMP
meshop.getMapFace -- @IMP mapChannel 0 == vertex color, 1 == texture ?

meshop.getNumCPVVerts -- Color Per Vertex (mapChannel 0)
meshop.getVCFaces
meshop.getVertexColor

meshop.getNumTVerts -- Texture (mapChannel 1)
meshop.getMapVert -- @IMP

meshop.getFaceRNormals
```

### 예시
```ms
vertexPosition = vertex.position
format "\t\t<position x=\"%\" y=\"%\" z=\"%\"/>\n" \
    vertexPosition.x vertexPosition.y vertexPosition.z \
    to:savedFile
```

## poly (Editable_Poly) ★★
```ms
<poly>.Retriangulate
<poly>.GetNumFaces
<poly>.GetFaceDegree <faceID>
<poly>.GetNumVertices
<poly>.GetVertex
<poly>.GetVertexColor #VertexColor|#Illumination|#Alpha
<poly>.GetVertexFaceCount <vertexID>
<poly>.GetVertexFace <vertexID> <faceID> -- @IMP

<poly>.faces[i]
```

```ms
polyop.getNumVerts <Poly poly>
polyop.getNumEdges <Poly poly>
polyop.getNumFaces <Poly poly> -- @IMP
polyop.getFaceVerts <Poly poly> <int face> -- @IMP
polyop.getFaceEdges <Poly poly> <int face>
polyop.getFaceDeg <Poly poly> <int face> -- face의 degree (vertex의 수)
polyop.getFaceNormal -- @IMP
polyop.getFacesUsingVert
polyop.retriangulate <Poly poly> <facelist>
```

### vertex color
```ms
select target.vertices[i]
a = (selection[1].GetVertexColor #illumination)
```

### 예제
```ms
target = selection[1]
vertexCount = target.GetNumVertices() as integer

format "Vertex 개수: % 개\n" vertexCount
format "<vertices count=\"%\">\n" vertexCount to:savedFile

targetMaterial = target.material
print targetMaterial as string

for i = 1 to vertexCount do
(
    vertex = (target.GetVertex i)
    
    --#TAG <vertex>
    format "\t<vertex id=\"%\">\n" (i - 1) to:savedFile

    target.setSelection #Vertex #{i}
    vertexColor_ = (target.GetVertexColor #VertexColor)
    vertexIllum = (target.GetVertexColor #Illumination)

    -- position
    format "\t\t<position x=\"%\" y=\"%\" z=\"%\"/>\n" \
        vertex.x vertex.y vertex.z \
        to:savedFile

    -- color
    format "\t\t<color r=\"%\" g=\"%\" b=\"%\"/>\n" \
        vertexColor_.r vertexColor_.g vertexColor_.b \
        to:savedFile
    
    -- illum
    format "\t\t<illum r=\"%\" g=\"%\" b=\"%\"/>\n" \
        vertexIllum.r vertexIllum.g vertexIllum.b \
        to:savedFile
    
    --#TAG </vertex>
    format "\t</vertex>\n" to:savedFile
)
format "</vertices>\n" to:savedFile
```


## material
<material>.name 

### Standardmaterial (class)
<Standard>.shaderType Integer default: 1 -- alias: Shader_Type 
 0- Anisotropic
 1- Blinn
 2- Metal
 3- Multi-Layer
 4- Oren-Nayar-Blinn
 5- Phong
 6- Strauss
 7- Translucent
<standard>.wire Boolean default: false -- boolean 
<standard>.twoSided
<standard>.opacity

<Standard>.ambient Color default:(color 127.5 127.5 127.5)- animatable; RGB color; Ambient_Color 
<Standard>.diffuse Color default:(color 127.5 127.5 127.5)-- animatable, alias: Diffuse_Color 
<Standard>.specular Color

<Standard>.ambientMap TextureMap default: undefined -- alias for maps[0] 
<Standard>.ambientMapAmount Float default: 100.0 -- alias for mapAmounts[0] 


<Standard>.diffuseLevel Float default: 100.0 -- animatable; percentage; Diffuse_Level 
<Standard>.diffuseLevelMap TextureMap default: undefined -- alias for maps[8] 
<Standard>.diffuseLevelMapAmount Float default: 100.0 -- alias for mapAmounts[8] 
<Standard>.diffuseMap TextureMap default: undefined -- alias for maps[1] 
<Standard>.diffuseMapAmount Float default: 100.0 -- alias for mapAmounts[1] 
<Standard>.bumpMap TextureMap default: undefined -- alias for maps[10] 
<Standard>.bumpMapAmount Float default: 30.0 -- alias for mapAmounts[10] 

## FrameTagManager
``` ms
FrameTagManager.getTagCount
FrameTagManager.getTagID
FrameTagManager.getNameByID
FrameTagManager.getTimeByID
```

## 유용한 함수
```ms
print
format
swap <a> <b>
matchPattern "문자열" pattern:"*.*" [ignoreCase:false]
random (0 255)
messagebox
queryBox
yesNoCancelBox
classOf <노드> <클래스> -- @IMP: Point3, Box, BoneGeometry, Biped_Object, Dummy, Directionallight
superClassOf <노드> <클래스> -- 보통 GeometryClass가 많다, helper, light
superclassOf selection[1]
canConvertTo <노드> <클래스>
convertTo <노드> <클래스>
 -- convertToMesh
 -- convertToPoly
```
|    | class | superClass |
| -- | -- | -- |
| Box | Box | GeometryClass |
| Bone | BoneGeometry | GeometryClass |
| Biped | Biped_Object | GeometryClass |
| Dummy (of Ring Array) | Dummy | helper |
| Sunlight == Free Directional Light | Directionallight | light |
| Physical Camera | Physical | camera |
| Target (of camera) | Target Object | GeometryClass |