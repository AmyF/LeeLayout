# LeeLayout

使用方法
```swift
view.layoutManager
    .left(equalTo: leftAnchor)
    .right(equalTo: rightAnchor)
    .end()
```

```swift
let manager = LayoutManager(view: view)
manager.left(equalTo: leftAnchor).over()
manager.setEdges().over()
manager.end()
```
