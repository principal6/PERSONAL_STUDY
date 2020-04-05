# C#

## 개요

GC (Garbage Collector)가 있는 언어!



## 객체 초기화

```c#
 SurfaceTile = new MGSurfaceTile(KAssetDir)
 {
     Parent = SplitViews.Panel1,
     Dock = DockStyle.Fill,
     FixedMovementTileSize = KDefaultTileSize
 };
```

## 속성 (property)

```c#
public Color BackgroundColor { set; get; } = Color.White;
```



## 메서드

```c#
private void MainFrm_KeyDown(object sender, KeyEventArgs e)
{
    if (e.KeyCode == Keys.D1)
    {
        if (e.Control == true)
        {
            TabTileView.SelectedIndex = 0;
        }
    }
}
```



```

            

```





## 유용한 이름공간/객체

### System.Windows.Forms

```c#
MessageBox.Show(...)
```



### System.Collections.Generic

```c#
List<~>

```

### System.Math

```c#
Math.Abs(~);
Math.Max(a, 0);
```



### System.Convert

```c#
Convert.ToInt32("123");
```



### System.IO.Directory

### System.Environment

### System.Xml

```c#
XmlDocument doc = new XmlDocument();
doc.Load(file_name);

XmlElement root = doc.DocumentElement;
XmlElement level_info = (XmlElement)root.ChildNodes[0];
XmlAttribute name = level_info.Attributes[0];
// ...
```

