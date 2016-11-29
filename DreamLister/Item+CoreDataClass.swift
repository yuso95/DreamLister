//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Younoussa Ousmane Abdou on 11/28/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
