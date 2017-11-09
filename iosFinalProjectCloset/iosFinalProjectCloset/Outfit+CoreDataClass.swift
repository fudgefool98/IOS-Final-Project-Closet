//
//  Outfit+CoreDataClass.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 10/31/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Outfit)
public class Outfit: NSManagedObject {
    
    convenience init?(shoes: Item?, shirt: Item?, pants: Item?) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: Outfit.entity(), insertInto: context)
        
        self.shoes = shoes
        self.shirt = shirt
        self.pants = pants
        
    }

}
