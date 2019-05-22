# LeeLayout

[![CI Status](https://img.shields.io/travis/840382477@qq.com/LeeLayout.svg?style=flat)](https://travis-ci.org/840382477@qq.com/LeeLayout)
[![Version](https://img.shields.io/cocoapods/v/LeeLayout.svg?style=flat)](https://cocoapods.org/pods/LeeLayout)
[![License](https://img.shields.io/cocoapods/l/LeeLayout.svg?style=flat)](https://cocoapods.org/pods/LeeLayout)
[![Platform](https://img.shields.io/cocoapods/p/LeeLayout.svg?style=flat)](https://cocoapods.org/pods/LeeLayout)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LeeLayout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LeeLayout'
```

## Usage

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

## Author

840382477@qq.com, 840382477@qq.com

## License

LeeLayout is available under the MIT license. See the LICENSE file for more info.
