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
        if (checkItem(item: photoItem)) {
            print("Item exists!!!")
            let fetchRequest2: NSFetchRequest<Outfit> = Outfit.fetchRequest()
            do {
                if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    
                    deleteOutfits = (try managedContext.fetch(fetchRequest2)) ?? []
                    
                    if (photoItem?.category == Int64(0)) {
                        deleteOutfit(outfits: deleteOutfits, item: photoItem, managedContext: managedContext, category: 0)
                        
                    } else if (photoItem?.category == Int64(1)) {
                        deleteOutfit(outfits: deleteOutfits, item: photoItem, managedContext: managedContext, category: 1)
                    } else {
                        deleteOutfit(outfits: deleteOutfits, item: photoItem, managedContext: managedContext, category: 2)
                    }
                }
            } catch {
                print("ManagedContext error!!")
            }
            
            let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
            
            do {
                if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                    deleteItems = (try managedContext.fetch(fetchRequest)) ?? []
                    
                    iosFinalProjectCloset.deleteItem(items: deleteItems, item: photoItem, managedContext: managedContext)
                    
                }
            } catch {
                print("ManagedContext error!!")
            }
            
        
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
        editClothing.selectedSegmentIndex = Int(item.category)
        editWeather.selectedSegmentIndex = Int(item.weatherTag)
        editFormal.selectedSegmentIndex = Int(item.formalTag)
    }
    
    
}
