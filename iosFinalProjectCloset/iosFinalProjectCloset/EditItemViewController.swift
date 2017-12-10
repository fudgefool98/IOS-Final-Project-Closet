//
//  EditItemViewController.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 11/30/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import UIKit
import CoreData


class EditItemViewController: UIViewController {
   
    @IBOutlet weak var itemPhoto: UIImageView? 
    @IBOutlet weak var editClothing: UISegmentedControl!
    @IBOutlet weak var editWeather: UISegmentedControl!
    @IBOutlet weak var editFormal: UISegmentedControl!
    var items: [Item] = []
    
    @IBAction func saveItem(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let _ = Item(category: Int64(editClothing.selectedSegmentIndex), formalTag: Int64(editFormal.selectedSegmentIndex), photo: itemPhoto?.image, weatherTag: Int64(editWeather.selectedSegmentIndex))
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
        
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func deleteItem(_ sender: Any) {
        //var photo = itemPhoto?.image
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                items = (try managedContext.fetch(fetchRequest)) ?? []
                items = items.filter({$0.category == Int64(editClothing.selectedSegmentIndex)})
                items = items.filter({$0.formalTag == Int64(editFormal.selectedSegmentIndex)})
                items = items.filter({$0.weatherTag == Int64(editWeather.selectedSegmentIndex)})
                items = items.filter({$0.photo == photo})
                
                for object in items {
                    managedContext.delete(object)
                }
                
                do {
                    try managedContext.save()
                    print("saved!")
                } catch let error as NSError  {
                    print("Could not save \(error)")
                } catch {
                    
                }
            }

            
        } catch {
            print(error)
        }
        
        

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
