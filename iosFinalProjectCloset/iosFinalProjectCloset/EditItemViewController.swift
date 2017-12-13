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
    var deleteItems: [Item] = []
    var items: [Item] = []
    var photoItem: Item?
    
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
        
        if (checkItem(item: photoItem)) {
            print("Item exists!!!")
            
            let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
            
            do {
                if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    
                    deleteItems = (try managedContext.fetch(fetchRequest)) ?? []
                    
                    var index = 0
                    while index < deleteItems.count {
                        if (photoItem == deleteItems[index]) {
                            
                            managedContext.delete(deleteItems[index])
                            
                            do {
                                try managedContext.save()
                                
                            } catch let error as NSError {
                                print("Could not save \(error)")
                            }   
                        }
                        index += 1
                    }
                    
                }
        
            } catch {
                print("ManagedContext error!!")
            }
        } else {
            print ("Item doesn't exist!!!")
        }
        
        
//        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
//
//        do {
//            if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//                items = (try managedContext.fetch(fetchRequest)) ?? []
//                items = items.filter({$0.category == Int64(editClothing.selectedSegmentIndex)})
//                items = items.filter({$0.formalTag == Int64(editFormal.selectedSegmentIndex)})
//                items = items.filter({$0.weatherTag == Int64(editWeather.selectedSegmentIndex)})
//                items = items.filter({$0.photo == photoItem})
//
//                for object in items {
//                    managedContext.delete(object)
//                }
//
//                do {
//                    try managedContext.save()
//                    print("saved!")
//                } catch let error as NSError  {
//                    print("Could not save \(error)")
//                } catch {
//
//                }
//            }
//
//
//        } catch {
//            print(error)
//        }
//        
        
        
        

    }
    
    
    var photo: UIImage? {
        didSet {
            self.itemPhoto?.image = photo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check to see if photo exists in Item
        //if it does update segmented controls
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                items = (try managedContext.fetch(fetchRequest)) ?? []
            }
            
        } catch {
            print(error)
        }
        
        itemPhoto?.image = photo
        
        checkItem(item: photoItem)
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

    func checkItem(item: Item?) -> Bool {
        var index = 0
        print("check???")
        while index < items.count {
            print("index is \(index)")
            if (item == items[index]) {
                print("if!!!")
                updateSegments(item: items[index])
                return true
            }
            index += 1
        }
        return false
    }
    
    func updateSegments(item: Item) {
        print("UPDATE!!!!")
        editClothing.selectedSegmentIndex = Int(item.category)
        editWeather.selectedSegmentIndex = Int(item.weatherTag)
        editFormal.selectedSegmentIndex = Int(item.formalTag)
    }
    
    
}
