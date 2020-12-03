//
//  extensions.swift
//  TutorialKit
//
//  Created by DatDT on 2020/11/09.
//

import Foundation
import UIKit

public protocol TutorialKitSwiftDelegate{
    func didDismissTut(tutKey:String)
}
public enum TutorialShowMode{
    case always, once
}
public enum Direction {
    case up,down, auto
}

extension UIView{
    func takeSnapshot(_ frame: CGRect) -> UIImage? {
      UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
      
      let context = UIGraphicsGetCurrentContext();
      context?.translateBy(x: frame.origin.x * -1, y: frame.origin.y * -1)
      
      guard let currentContext = UIGraphicsGetCurrentContext() else {
        return nil
      }
      self.layer.render(in: currentContext)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return image
    }
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let image = renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
        return image
    }
    func getFrameOnScreen() -> CGRect{
        return CGRect(origin: self.superview!.convert(self.frame.origin, to: nil), size: self.frame.size)
    }
    
    func circlize()  {
        if self.frame.size.width != self.frame.size.height {
            self.frame.size.width = min(self.frame.size.width, self.frame.size.height)
            self.frame.size.height = min(self.frame.size.width, self.frame.size.height)
        }
        self.layer.cornerRadius = self.frame.size.width/2
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }

}

