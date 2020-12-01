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
extension TutorialKitSwiftDelegate{
    public func showTutorial(ofView view: UIView,text:String, direction: Direction, tutKey:String, mode:TutorialShowMode = .once,bubbleColor:UIColor = UIColor.systemBlue){
        
        let frame = view.getFrameOnScreen()
        guard let window = UIApplication.shared.keyWindow else{
            return
        }
        window.subviews.filter({$0 is TutorialView && ($0 as! TutorialView).tutKey == tutKey}).forEach { (view) in
            view.removeFromSuperview()
        }
        let circleRadius = sqrt(pow(frame.width, 2)  + pow(frame.height, 2))/2.0 * 1.2
        let newFrame = CGRect(x: frame.origin.x - (2.0 * circleRadius - frame.width)/2.0, y: frame.origin.y - (2.0 * circleRadius - frame.height)/2.0, width: 2.0 * circleRadius, height: 2.0 * circleRadius)
        let image = window.takeSnapshot(newFrame)
        
        let tutView = TutorialView(ofView: UIImageView(image: image), frame: newFrame, text: text, direction: direction, tutKey:tutKey,bubbleColor:bubbleColor, delegate: self)
        //        self.view.addSubview(tutView)
        //        tutView.snp.remakeConstraints({remake in
        //            remake.edges.equalToSuperview()
        //        })
        if view.isHidden || (UserDefaults.standard.bool(forKey: tutKey) && mode == .once) {
            tutView.nextTut()
        }else{
            window.addSubview(tutView)
            tutView.snp.remakeConstraints({remake in
                remake.edges.equalToSuperview()
            })
            window.setNeedsLayout()
            window.layoutIfNeeded()
            tutView.popInstruction()
            
        }
    }
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

