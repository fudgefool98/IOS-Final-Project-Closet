//
//  Model.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 12/13/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func createItems() -> [Item] {
    var items: [Item] = []
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    
    do {
        if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            items = (try managedContext.fetch(fetchRequest)) ?? []
            return items
        }
        
    } catch {
        print(error)
    }
    
    return items
    
}

func createOutfits() -> [Outfit] {
    let fetchRequest: NSFetchRequest<Outfit> = Outfit.fetchRequest()
    var outfits: [Outfit] = []
    do {
        if let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            outfits = (try managedContext.fetch(fetchRequest)) ?? []
            return outfits
        }
        
    } catch {
        print(error)
    }
    
    return outfits
}

func checkIndexItem(items: [Item], outfit: Outfit, category: Int) -> IndexPath {
    var index = 0
    var indexPath: IndexPath?
    
    switch category {
        case 0:
            while index < items.count {
                if (outfit.shirt == items[index]) {
                    indexPath = IndexPath(row: index, section: 0)
                    return indexPath!
                }
                index += 1
            }
        case 1:
            while index < items.count {
                if (outfit.pants == items[index]) {
                    indexPath = IndexPath(row: index, section: 0)
                    return indexPath!
                }
                index += 1
        }
        default:
            while index < items.count {
                if (outfit.shoes == items[index]) {
                    indexPath = IndexPath(row: index, section: 0)
                    return indexPath!
                }
                index += 1
        }
    }
    
    return indexPath!
}

func deleteItem(items: [Item], item: Item?, managedContext: NSManagedObjectContext) {
    var index = 0
    while index < items.count {
        if (item == items[index]) {
            managedContext.delete(items[index])
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
        index += 1
    }

}

func deleteOutfit (outfits: [Outfit], item: Item?, managedContext: NSManagedObjectContext, category: Int) {
    var index = 0
    switch category {
    case 0:
        while index < outfits.count {
        print(index)
        if (item == outfits[index].shirt) {
        
        managedContext.delete(outfits[index])
        
        do {
        try managedContext.save()
        
        } catch let error as NSError {
        print("Could not save \(error)")
        }
        }
        index += 1
        }
    
    case 1:
        while index < outfits.count {
            print(index)
            if (item == outfits[index].pants) {
            
                managedContext.delete(outfits[index])
            
                do {
                    try managedContext.save()
                
                } catch let error as NSError {
                    print("Could not save \(error)")
            }
        }
        index += 1
        }
    default:
        while index < outfits.count {
            print(index)
            if (item == outfits[index].shoes) {
            
                managedContext.delete(outfits[index])
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save \(error)")
            }
        }
        index += 1
        }
}
}


