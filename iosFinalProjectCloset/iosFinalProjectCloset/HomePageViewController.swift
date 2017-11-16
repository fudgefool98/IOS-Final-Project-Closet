//
//  HomePageViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/16/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    
    //May or may not use these variables - they are buttons... added functions below
    @IBOutlet weak var viewOutfit: UIBarButtonItem!
    @IBOutlet weak var viewCloset: UIBarButtonItem!
    @IBOutlet weak var editCloset: UIBarButtonItem!
    @IBOutlet weak var addItem: UIBarButtonItem!
    @IBOutlet weak var favorite: UIBarButtonItem!
    @IBOutlet weak var tutorial: UIBarButtonItem!
    
    
    @IBOutlet weak var shoesFormalSegment: UISegmentedControl!
    @IBOutlet weak var pantsFormalSegment: UISegmentedControl!
    @IBOutlet weak var shirtsFormalSegment: UISegmentedControl!
    @IBOutlet weak var shirtsWeatherSegment: UISegmentedControl!
    @IBOutlet weak var pantsWeatherSegment: UISegmentedControl!
    @IBOutlet weak var shoesWeatherSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewOutfit(_ sender: Any) {
    }
    
    @IBAction func viewCloset(_ sender: Any) {
    }
    
    @IBAction func editCloset(_ sender: Any) {
    }
    
    @IBAction func favoriteOutfit(_ sender: Any) {
    }
    
    @IBAction func addItem(_ sender: Any) {
    }
    
    @IBAction func showTutorial(_ sender: Any) {
    }
    
    
    
}
