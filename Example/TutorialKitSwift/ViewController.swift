//
//  ViewController.swift
//  TutorialKit
//
//  Created by macro-dadt on 11/09/2020.
//  Copyright (c) 2020 macro-dadt. All rights reserved.
//

import UIKit
import TutorialKitSwift

typealias BenefitItem = (title:String,content:String,image:UIImage?)
typealias BenefitGroup = (title:String, items:[BenefitItem] , footer:String)


//MARK:- ViewController
class ViewController: UIViewController {
    //MARK:- properties
    var groups = [BenefitGroup]()
    
    let cellIdentifier = "cellIdentifier"
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        //        scrollView.bounces = false
        return scrollView
    }()
    //MARK:- views
    lazy var topView:UIView = {
        let view = UIView()
        view.backgroundColor = .red
        let imageView:UIImageView = {
            let imv = UIImageView(image: UIImage(named: "bg"))
            imv.contentMode = .scaleAspectFit
            return imv
        }()
        let groupsContainer:UIView = {
            let view = UIView()
            let subViews = self.groups[0..<(self.groups.count - 2)].map({ BenefitGroupView(group:$0)})
            for (index,groupView) in subViews.enumerated(){
                view.addSubview(groupView)
                groupView.setNeedsLayout()
                groupView.layoutIfNeeded()
                groupView.snp.remakeConstraints { (remake) in
                    if index == 0{
                        remake.top.equalTo(view.snp.top)
                    }else{
                        remake.top.equalTo(subViews[index - 1].snp.bottom)
                    }
                    remake.width.equalToSuperview()
                    remake.bottom.equalTo(groupView.subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY}).last!.snp.bottom)
                }
            }
            return view
        }()

        view.addSubview(imageView)
        view.addSubview(groupsContainer)
        
        imageView.snp.remakeConstraints { (remake) in
            remake.leading.trailing.top.equalToSuperview()
            remake.height.equalToSuperview().multipliedBy(0.3)
        }
        groupsContainer.backgroundColor = .white
        groupsContainer.layer.cornerRadius = 8
        groupsContainer.layer.masksToBounds = true
        groupsContainer.snp.remakeConstraints { (remake) in
            remake.top.equalTo(imageView.snp.bottom)
            remake.bottom.equalTo(groupsContainer.subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY}).last!.snp.bottom)
            remake.centerX.equalToSuperview()
            remake.leading.equalToSuperview().offset(8)
            remake.trailing.equalToSuperview().offset(-8)

        }
        return view
    }()
    
    
    
    //MARK:- override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groups = self.generateData()
        self.layout()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        self.scrollView.updateContentView()
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    private func layout(){
        self.view.backgroundColor = .white
        view.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        self.view.addSubview(scrollView)
        self.scrollView.snp.remakeConstraints { (remake) in
            remake.leading.trailing.top.bottom.equalToSuperview()
        }
        let subViews = [topView, BenefitGroupView(group: self.groups.last!)]

        for (index, subView) in subViews.enumerated(){
            self.scrollView.addSubview(subView)
            subView.setNeedsLayout()
            subView.layoutIfNeeded()
            subView.snp.remakeConstraints { (remake) in
                if index == 0{
                    remake.top.equalToSuperview()
                }else{
                    remake.top.equalTo(subViews[index - 1].snp.bottom)
                }
                remake.centerX.equalToSuperview()
                remake.width.equalToSuperview()
                remake.bottom.equalTo(subView.subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY}).last!.snp.bottom).offset(32)
            }
        }
        
        self.scrollView.contentSize.height = 1000
    }
    private func generateData() -> [BenefitGroup]{
        let item_1_1 = BenefitItem(title:"「この表現は自然ですか？」質問テンプレート",content:"あなたの文章をネイティブスピーカーに添削してもらおう",image:UIImage(named: ""))
        let item_1_2 = BenefitItem(title:"質問の優先表示優先",content:"表示チケットで質問を目立たせて、より多くの回答をもらおう",image:UIImage(named: ""))
        let item_1_3 = BenefitItem(title:"音声録音時間の延長",content:"10秒から60秒に延長された録音時間を使って、発音をチェックしてもらう",image:UIImage(named: ""))
        
        let item_2_1 = BenefitItem(title:"翻訳機能",content:"読めない言語で書かれた回答も、Google翻訳で素早く理解",image:UIImage(named: ""))
        
        let item_3_1 = BenefitItem(title:"検索結果の信頼度順表示",content:"信頼度順表示を使うと、より良い回答がすぐに見つかる",image:UIImage(named: ""))
        
        let item_4_1 = BenefitItem(title:"ブックマーク",content:"あとで復習したい質問・回答はブックマークしておこう",image:UIImage(named: ""))

        let item_5_1 = BenefitItem(title:"広告の非表示",content:"広告が非表示になります。今よりも語学学習に集中できる環境を作りましょう。",image:UIImage(named: ""))
        let item_5_2 = BenefitItem(title:"他人の音声/動画回答の再生",content:"他人の質問について音声動画回答を再生できます。ネイティブの発音を聞く機会を増やすことができます。",image:UIImage(named: ""))
        let item_5_3 = BenefitItem(title:"読みたい回答がすぐ読める",content:"質問を検索した時に制限なしですべての回答を見ることができます。（無料会員は数回に1回制限がかかります）",image:UIImage(named: ""))
        let item_5_4 = BenefitItem(title:"ブックマーク通知",content:"ブックマークした質問への通知を受け取ることができます。",image:UIImage(named: ""))
        
        return [(title:"質問する", items:[item_1_1, item_1_2, item_1_3], footer:"質問する"), (title:"回答を読む", items:[item_2_1], footer:""), (title:"調べる", items:[item_3_1], footer:""), (title:"復習する", items:[item_4_1], footer:"検索する"), (title:"その他の機能", items:[item_5_1, item_5_2, item_5_3, item_5_4], footer:"過去の質問を見る")]
    }
}

// MARK:- BenefitGroupView
class BenefitGroupView:UIView{
    var group:BenefitGroup!
    override init(frame: CGRect) {
           super.init(frame: frame)
       }
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    init(group:BenefitGroup) {
        super.init(frame: .zero)
        self.group = group
        self.commonInit()
    }
    lazy var headerLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = label.font.withSize(label.font.pointSize + 2)
        return label
    }()
    lazy var footerLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = label.font.withSize(label.font.pointSize + 2)
        return label
    }()
    lazy var mainView:UIView = {
        let view = UIView()
        let subViews = group.items.map({SingleBenefitView(item: $0)})
        
        for (index, aSubView) in subViews.enumerated(){
            view.addSubview(aSubView)
            aSubView.setNeedsLayout()
            aSubView.layoutIfNeeded()
            aSubView.snp.remakeConstraints { (remake) in
                if index == 0{
                    remake.top.equalToSuperview()
                }else{
                    remake.top.equalTo(subViews[index - 1].snp.bottom).offset(16)
                }
                remake.bottom.equalTo(aSubView.subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY}).last!.snp.bottom)
                remake.centerX.equalToSuperview()
                remake.width.equalToSuperview()
            }
        }
        return view
    }()
    private func commonInit(){
        self.addSubview(headerLabel)
        self.addSubview(mainView)
        self.addSubview(footerLabel)
        self.headerLabel.snp.remakeConstraints { (remake) in
            remake.leading.equalToSuperview().offset(8)
            remake.trailing.equalToSuperview()
            remake.top.equalToSuperview().offset(8)
        }
        mainView.backgroundColor = .white
        self.mainView.snp.remakeConstraints { (remake) in
            remake.top.equalTo(self.headerLabel.snp.bottom)
            remake.leading.trailing.equalTo(self.headerLabel)
            remake.bottom.equalTo(mainView.subviews.sorted(by: {$0.frame.maxY < $1.frame.maxY}).last!.snp.bottom)
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.footerLabel.snp.remakeConstraints { (remake) in
            remake.trailing.equalToSuperview()
            remake.top.equalTo(self.mainView.snp.bottom)
        }
        self.setup()
    }
    private func setup(){
        self.headerLabel.text = self.group.title
        self.footerLabel.text = self.group.footer
    }
}
//MARK:- SingleBenefitView
class SingleBenefitView:UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var item:BenefitItem!
    init(item:BenefitItem) {
        super.init(frame: .zero)
        self.item = item
        self.commonInit()
        self.setup(benefit: self.item)
    }
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = label.font.withSize(label.font.pointSize + 2)
        return label
    }()
    lazy var contentLabel:UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    lazy var imv:UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFit
        imv.layer.cornerRadius = 10
        imv.clipsToBounds = true
        imv.backgroundColor = .green
        return imv
    }()
    private func commonInit(){
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        self.addSubview(imv)
        self.imv.snp.remakeConstraints { (remake) in
            remake.top.equalToSuperview().offset(8)
            remake.leading.equalToSuperview().offset(8)
            remake.width.equalToSuperview().multipliedBy(0.2)
            remake.height.equalTo(self.imv.snp.width)
        }
        self.titleLabel.snp.remakeConstraints { (remake) in
            remake.leading.equalTo(self.imv.snp.trailing).offset(8)
            remake.trailing.equalToSuperview()
            remake.top.equalTo(self.imv.snp.top)
        }
        self.contentLabel.snp.remakeConstraints { (remake) in
            remake.leading.trailing.equalTo(self.titleLabel)
            remake.top.equalTo(self.titleLabel.snp.bottom).offset(8)
        }

    }
    func setup(benefit:BenefitItem){
        self.titleLabel.text = benefit.title
        self.contentLabel.text = benefit.content
        self.imv.image = UIImage(named: "bg")
        
    }
}


extension UIScrollView{
    func updateContentView(onlyHeight:Bool? = nil, onlyWidth:Bool? = nil) {
        DispatchQueue.main.async {
            self.setNeedsLayout()
            self.layoutIfNeeded()
            if let onlyHeight = onlyHeight, onlyHeight {
                self.contentSize.height = self.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? self.contentSize.height
                self.contentSize.height += 100
                self.contentSize.width = self.frame.width
            }
            if let onlyW = onlyWidth, onlyW{
                self.contentSize.width = self.subviews.sorted(by: { $0.frame.maxX < $1.frame.maxX }).last?.frame.maxX ?? self.contentSize.width
                self.contentSize.width += 50
                self.contentSize.height = self.frame.height
                
            }
            if onlyHeight == nil && onlyWidth == nil {
                self.contentSize.height = self.subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? self.contentSize.height
                self.contentSize.width = self.subviews.sorted(by: { $0.frame.maxX < $1.frame.maxX }).last?.frame.maxX ?? self.contentSize.width
            }
        }
        
    }
}
