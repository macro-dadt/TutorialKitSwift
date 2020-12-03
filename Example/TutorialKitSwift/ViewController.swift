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
    let button = UIButton()

    //MARK:- override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        button.backgroundColor = .white
        button.setTitle("Click me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        self.view.addSubview(button)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        button.center = self.view.center
        button.frame.size = CGSize(width: 100, height: 50)
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TutorialKitSwift.showTutorial(ofView: button, text: "Hey bae, How you doin?", direction: .auto, tutKey: "an_unique_key")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
