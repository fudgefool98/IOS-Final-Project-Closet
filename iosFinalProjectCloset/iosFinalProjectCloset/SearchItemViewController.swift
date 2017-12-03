//
//  NewItemViewController.swift
//  iosFinalProjectCloset
//
//  Created by Tiara Jarrett on 11/28/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit

class SearchItemViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var searchClothing: UISegmentedControl!
    @IBOutlet weak var searchWeather: UISegmentedControl!
    @IBOutlet weak var searchFormal: UISegmentedControl!
    
    @IBAction func searchItems(_ sender: Any) {
    }
    
    @IBAction func resetSegments(_ sender: Any) {
        searchClothing.selectedSegmentIndex = 0
        searchWeather.selectedSegmentIndex = 0
        searchFormal.selectedSegmentIndex = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

