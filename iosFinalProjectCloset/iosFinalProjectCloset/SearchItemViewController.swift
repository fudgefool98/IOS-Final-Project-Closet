//
//  NewItemViewController.swift
//  iosFinalProjectCloset
//
//  Created by Tiara Jarrett on 11/28/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import CoreData

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case "showItems":
            if let navController = segue.destination as? UINavigationController, let destination = navController.viewControllers.first as? ListItemsViewController {
                let category = searchClothing.selectedSegmentIndex
                let weatherTag = searchWeather.selectedSegmentIndex
                let formalTag = searchFormal.selectedSegmentIndex
                
                let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "category == %@ AND weatherTag == %@ AND formalTag == %@", "\(category)", "\(weatherTag)", "\(formalTag)")
            }
        default:
            break
        }
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

