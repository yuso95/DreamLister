//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Younoussa Ousmane Abdou on 11/28/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import Foundation
import CoreData

extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
