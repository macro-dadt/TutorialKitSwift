# TutorialKitSwift

[![CI Status](https://img.shields.io/travis/macro-dadt/TutorialKitSwift.svg?style=flat)](https://travis-ci.org/macro-dadt/TutorialKitSwift)
[![Version](https://img.shields.io/cocoapods/v/TutorialKitSwift.svg?style=flat)](https://cocoapods.org/pods/TutorialKitSwift)
[![License](https://img.shields.io/cocoapods/l/TutorialKitSwift.svg?style=flat)](https://cocoapods.org/pods/TutorialKitSwift)
[![Platform](https://img.shields.io/cocoapods/p/TutorialKitSwift.svg?style=flat)](https://cocoapods.org/pods/TutorialKitSwift)

## Screenshot

<img src="https://storage.googleapis.com/moress_general/github/Screen_Shot.png" width="50%">

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TutorialKitSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TutorialKitSwift'
```

## Usage

```swift
import UIKit
import TutorialKitSwift
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTutorial(ofView: your_view, text: "Hey bae, How you doin?", direction: .down, tutKey: "tut1_key",mode: .always, bubbleColor:UIColor.systemBlue)
    }
}
extension ViewController:TutorialViewDelegate{
    func didFinishTut(tutKey: String) {
        print(tutKey)
    }
}
```

## Author

macro-dadt, do7dat@gmail.com

## License

TutorialKitSwift is available under the MIT license. See the LICENSE file for more info.
