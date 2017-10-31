//
//  Outfit+CoreDataProperties.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 10/31/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//
//

import Foundation
import CoreData


extension Outfit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Outfit> {
        return NSFetchRequest<Outfit>(entityName: "Outfit")
    }

    @NSManaged public var shoes: Item?
    @NSManaged public var shirt: Item?
    @NSManaged public var pants: Item?

}
