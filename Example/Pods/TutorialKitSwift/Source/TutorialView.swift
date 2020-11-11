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
    var delegate:TutorialViewDelegate?
    var position:TitlePosition!
    var tutKey:String!
    var interactView = UIImageView()
    lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.isUserInteractionEnabled = false
        return label
    }()
    @objc func nextTut(){
        DispatchQueue.main.async {
            self.delegate?.didFinishTut(tutKey: self.tutKey)
            UserDefaults.standard.set(true, forKey: self.tutKey)
            self.removeFromSuperview()
        }
    }
    init(ofView view:UIView,frame:CGRect,title:String, titlePosition:TitlePosition, tutKey:String, delegate:TutorialViewDelegate? = nil) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        self.position = titlePosition
        self.tutKey = tutKey

        
        self.interactView.image =  view.asImage()

        self.title.text = title
        self.addSubview(self.interactView)
        self.interactView.frame = frame
        self.interactView.circlize()

        self.commonInit()
        self.interactView.isUserInteractionEnabled = false
    }
    
    
    private func commonInit(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.title.textColor = UIColor.white
        self.addSubview(self.title)
        self.title.snp.makeConstraints({make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        })
        
        switch position {
        case .top:
            self.title.snp.makeConstraints({make in
                make.bottom.equalTo(self.interactView.snp.top).offset(-16)
                
            })
            break
        case .bottom:
            self.title.snp.makeConstraints({make in
                make.top.equalTo(self.interactView.snp.bottom).offset(16)
            })
            break
        case .center:
            self.title.snp.makeConstraints({make in
                make.centerY.equalToSuperview()
            })
            break
        default:
            break
        }
        self.layoutIfNeeded()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.nextTut)))
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
