//
//  TutorialView.swift
//  TutorialKit
//
//  Created by DatDT on 2020/11/09.
//

import UIKit
import SnapKit


class TutorialView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    let popTip = PopTip()
    var delegate:TutorialViewDelegate?
    var direction:Direction!
    var tutKey:String!
    var interactView = UIImageView()
    var text:String!

    @objc func nextTut(){
        DispatchQueue.main.async {
            self.delegate?.didFinishTut(tutKey: self.tutKey)
            UserDefaults.standard.set(true, forKey: self.tutKey)
            self.removeFromSuperview()
        }
    }
    init(ofView view:UIView,frame:CGRect,text:String, direction:Direction, tutKey:String,bubbleColor:UIColor = UIColor.systemBlue, delegate:TutorialViewDelegate? = nil) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        self.direction = direction
        self.tutKey = tutKey
        self.popTip.bubbleColor = bubbleColor
        self.popTip.text = text
        self.text = text
        
        self.interactView.image =  view.asImage()

        self.addSubview(self.interactView)
        self.interactView.frame = frame
        self.interactView.circlize()

        self.commonInit()
        self.interactView.isUserInteractionEnabled = false
    }
    private func commonInit(){
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)       
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.nextTut)))
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func popInstruction(){
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        popTip.dismissHandler = { popTip in
            self.nextTut()
        }

        switch direction {
        case .up:
            popTip.show(text: self.text, direction: .up, maxWidth: 200, in: self, from: self.interactView.frame)

            break
        case .down:
            popTip.show(text: self.text, direction: .down, maxWidth: 200, in: self, from: self.interactView.frame)
            break
        default:
            break
        }
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
