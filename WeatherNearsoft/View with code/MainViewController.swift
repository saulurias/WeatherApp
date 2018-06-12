////
////  MainViewController.swift
////  WeatherNearsoft
////
////  Created by Saul Urias on 6/4/18.
////  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
////
//
//import UIKit
//
//class MainViewController: UIViewController {
//    //MARK:- UI Variables And Constants
//    private let myCustomLabel = UILabel()
//    private let myCustomButton = UIButton()
//    private let myCustomLabelTwo = UILabel()
//    private let myCustomLabelThree = UILabel()
//    private var constraints = [NSLayoutConstraint]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureMyCustomLabel()
//        configureMyCustomButton()
//        setConstraintsForElementsOnView()
//    }
//
//    @objc func buttonAction(sender: UIButton){
//        myCustomLabel.text = "Confirmed!"
//    }
//
//    private func configureMyCustomButton(){
//        myCustomButton.setTitle("Confirm", for: .normal)
//        myCustomButton.setTitleColor(UIColor.blue, for: .normal)
//        myCustomButton.backgroundColor = UIColor.orange
//        myCustomButton.layer.borderColor = UIColor.black.cgColor
//        myCustomButton.layer.borderWidth = 2
//        myCustomButton.layer.cornerRadius = 3
//        myCustomButton.translatesAutoresizingMaskIntoConstraints = false
//        myCustomButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        view.addSubview(myCustomButton)
//    }
//
//    private func configureMyCustomLabel(){
//        myCustomLabel.text = "Hello, World!!"
//        myCustomLabel.textColor = UIColor.blue
//        myCustomLabel.textAlignment = .center
//        myCustomLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
//        myCustomLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(myCustomLabel)
//
//        myCustomLabelTwo.text = "Hello, Second"
//
//        myCustomLabelTwo.textColor = UIColor.blue
//        myCustomLabelTwo.textAlignment = .right
//        myCustomLabelTwo.numberOfLines = 0
//        myCustomLabelTwo.lineBreakMode = .byWordWrapping
//        myCustomLabelTwo.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
//        myCustomLabelTwo.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(myCustomLabelTwo)
//
//
//        myCustomLabelThree.text = "Hello, third"
//
//        myCustomLabelThree.textColor = UIColor.blue
//        myCustomLabelThree.textAlignment = .left
//        myCustomLabelThree.numberOfLines = 0
//        myCustomLabelThree.lineBreakMode = .byWordWrapping
//        myCustomLabelThree.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
//        myCustomLabelThree.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(myCustomLabelThree)
//    }
//
//    func setConstraintsForElementsOnView(){
//        //Constraint
//        let views = ["myCustomLabel": myCustomLabel, "button": myCustomButton, "myCustomLabelTwo": myCustomLabelTwo, "myCustomLabelThree": myCustomLabelThree]
//        let metrics = ["width150": 150, "high50": 50, "width55": 55, "width25": 25]
//
//
//        //Center all elements
//        constraints.append(NSLayoutConstraint(item: myCustomLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
//
//        constraints.append(NSLayoutConstraint(item: myCustomButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
//
//        constraints.append(NSLayoutConstraint(item: myCustomLabelTwo, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 17.5))
//
//        constraints.append(NSLayoutConstraint(item: myCustomLabelTwo, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 35.0))
//
//        constraints.append(NSLayoutConstraint(item: myCustomLabelThree, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 17.5))
//
//        constraints.append(NSLayoutConstraint(item: myCustomLabelThree, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 35.0))
//
//        //Width of all elements
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[myCustomLabel]-|", options: [], metrics: metrics, views: views)
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[myCustomLabelTwo]-|", options: [], metrics: metrics, views: views)
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "|-[myCustomLabelThree]-|", options: [], metrics: metrics, views: views)
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[myCustomLabelTwo(width25)]", options: [], metrics: metrics, views: views)
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[myCustomLabelThree(width25)]", options: [], metrics: metrics, views: views)
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:[button(width150)]", options: [], metrics: metrics, views: views)
//        //high and vertical position of all elements
//        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[myCustomLabel(high50)]-[button(high50)]", options: [], metrics: metrics, views: views)
//
//
//        NSLayoutConstraint.activate(constraints)
//    }
//}
