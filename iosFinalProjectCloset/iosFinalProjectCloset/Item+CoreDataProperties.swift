//
//  Item+CoreDataProperties.swift
//  iosFinalProjectCloset
//
//  Created by Mandy Rogers on 10/31/17.
//  Copyright © 2017 Mandy Rogers. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var category: String?
    @NSManaged public var formalTag: String?
    @NSManaged public var photo: String?
    @NSManaged public var weatherTag: String?

}
