//
//  Restaurant.swift
//  Test Application
//
//  Created by Kiril on 07.05.16.
//  Copyright © 2016 Kiril. All rights reserved.
//

import Foundation
import CoreData


class Restaurant: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var imageName: String?
    @NSManaged var location: String
    @NSManaged var type: String

}
