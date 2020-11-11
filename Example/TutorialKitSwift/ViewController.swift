//
//  ViewController.swift
//  TutorialKit
//
//  Created by macro-dadt on 11/09/2020.
//  Copyright (c) 2020 macro-dadt. All rights reserved.
//

import UIKit
import TutorialKitSwift
class ViewController: UIViewController {
    lazy var button:UIButton = {
        let button = UIButton()
        button.setTitle("Click me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    lazy var bgImageView:UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bg"))
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bgImageView)
        self.view.addSubview(button)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.bgImageView.frame = self.view.bounds
        self.button.frame.size = CGSize(width: 150, height: 50)
        self.button.center = self.view.center

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.showTutorial(ofView: self.button, text: "Hey bae, How you doin?", direction: .down, tutKey: "test",mode: .always, bubbleColor:UIColor.systemBlue)
    }

}
extension ViewController:TutorialViewDelegate{
    func didFinishTut(tutKey: String) {
        print(tutKey)
    }
}
