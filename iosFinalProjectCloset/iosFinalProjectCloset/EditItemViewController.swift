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
    var deleteOutfits: [Outfit] = []
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
        print("before functions?? \(photoItem?.category)")
        if (checkItem(item: photoItem)) {
            print("after checkitem \(photoItem?.category)")
            print("Item exists!!!")
            let fetchRequest2: NSFetchRequest<Outfit> = Outfit.fetchRequest()
            //pull what category photoItem is
            //filter deleteOutfits by what category photoItem is
            print("photo category in delete is \(photoItem?.category)")
            do {
                if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    
                    deleteOutfits = (try managedContext.fetch(fetchRequest2)) ?? []
                    var index = 0
                    
                    if (photoItem?.category == Int64(0)) {
                        while index < deleteOutfits.count {
                            print("deleting shirt check")
                            print(index)
                            if (photoItem == deleteOutfits[index].shirt) {
                                
                                managedContext.delete(deleteOutfits[index])
                                
                                do {
                                    print("deleted shirt")
                                    try managedContext.save()
                                    
                                } catch let error as NSError {
                                    print("Could not save \(error)")
                                }
                            }
                            index += 1
                        }
                    } else if (photoItem?.category == Int64(1)) {
                        index = 0
                        while index < deleteOutfits.count {
                            print("deleteing pants check")
                            print(index)
                            if (photoItem == deleteOutfits[index].pants) {
                                print("deleted pants")
                                managedContext.delete(deleteOutfits[index])
                                
                                do {
                                    try managedContext.save()
                                    
                                } catch let error as NSError {
                                    print("Could not save \(error)")
                                }
                            }
                            index += 1
                        }
                    } else {
                        index = 0
                        while index < deleteOutfits.count {
                            print("deleting shoes check")
                            print(index)
                            if (photoItem == deleteOutfits[index].shoes) {
                                
                                managedContext.delete(deleteOutfits[index])
                                
                                do {
                                    print("deleted shoes")
                                    try managedContext.save()
                                    
                                } catch let error as NSError {
                                    print("Could not save \(error)")
                                }
                            }
                            index += 1
                        }
                    }
                }
            } catch {
                print("ManagedContext error!!")
            }
            
            let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
            
            do {
                if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    print("inside managed context \(photoItem?.category)")
                    deleteItems = (try managedContext.fetch(fetchRequest)) ?? []
                    
                    var index = 0
                    while index < deleteItems.count {
                        if (photoItem == deleteItems[index]) {
                            print("inside index check \(photoItem?.category)")
                            managedContext.delete(deleteItems[index])
                            
                            do {
                                print("inside managed save \(photoItem?.category)")
                                try managedContext.save()
                                
                            } catch let error as NSError {
                                print("Could not save \(error)")
                            }
                            print("outside save managed \(photoItem?.category)")
                        }
                        print("oustide index \(photoItem?.category)")
                        index += 1
                    }
                    print("outside while \(photoItem?.category)")
                }
            } catch {
                print("ManagedContext error!!")
            }
            print("outside Items \(photoItem?.category)")
            
        
        } else {
            print ("Item doesn't exist!!!")
        }
        
        
    }
    
    
    var photo: UIImage? {
        didSet {
            self.itemPhoto?.image = photo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(photoItem?.category)
        items = createItems()
        
        itemPhoto?.image = photo
        
        checkItem(item: photoItem)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func checkItem(item: Item?) -> Bool {
        var index = 0
        while index < items.count {
            if (item == items[index]) {
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
