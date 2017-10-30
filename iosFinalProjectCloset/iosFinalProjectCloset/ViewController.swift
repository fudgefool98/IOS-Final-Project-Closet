//
//  ViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 10/29/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    enum category {
        case shoes
        case pants
        case shirt
    }
    
    struct outfit {
        let shoes: String
        let pants: String
        let shirt: String
        
        init(shoes: String, pants: String, shirt: String) {
            self.shoes = shoes
            self.pants = pants
            self.shirt = shirt
        }
    }
    

    

}

