//
//  Players.swift
//  TheVolleyballSheet
//
//  Created by Todd McCready on 4/9/15.
//  Copyright (c) 2015 Todd McCready. All rights reserved.
//

import Foundation
import CoreData
@objc(Players)

class Players: NSManagedObject {

    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var number: NSNumber
    @NSManaged var team: Teams

}
