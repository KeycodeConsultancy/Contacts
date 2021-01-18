//
//  ViewController.swift
//  Contacts
//
//  Created by Kevin Reid on 17/01/2019.
//

import UIKit
import CoreData

class MainMenuViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          styleButtons()
    }
    
    
    func styleButtons() {
        for case let button as UIButton in self.view.subviews {
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
            
            
        }
    }

}

