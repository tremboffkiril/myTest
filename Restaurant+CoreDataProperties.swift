//
//  Restaurant+CoreDataProperties.swift
//  Test Application
//
//  Created by Kiril on 07.05.16.
//  Copyright © 2016 Kiril. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Restaurant {

    @NSManaged var name: String?
    @NSManaged var imageName: String?
    @NSManaged var location: String?
    @NSManaged var type: String?

}
