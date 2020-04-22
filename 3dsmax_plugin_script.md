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

## script tutorial
https://www.youtube.com/watch?v=H030WBIfzF8