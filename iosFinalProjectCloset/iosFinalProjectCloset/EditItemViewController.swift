//
//  EditItemViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit


class EditItemViewController: UIViewController {
   
    @IBOutlet weak var itemPhoto: UIImageView? 
    @IBOutlet weak var editClothing: UISegmentedControl!
    @IBOutlet weak var editWeather: UISegmentedControl!
    @IBOutlet weak var editFormal: UISegmentedControl!
    
    @IBAction func saveItem(_ sender: Any) {
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        let managedContext = appDelegate?.managedObjectContext
//        let fetchRequest = NSFetchRequest(entityName: "Item")
        fetchRequest.predicate = NSPredicate(format: "photo = %@", "\(photo)")
    }
    
    
    var photo: UIImage? {
        didSet {
            self.itemPhoto?.image = photo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemPhoto?.image = photo
        // Do any additional setup after loading the view.
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
