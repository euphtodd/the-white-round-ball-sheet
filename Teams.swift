//
//  Teams.swift
//  TheVolleyballSheet
//
//  Created by Todd McCready on 4/9/15.
//  Copyright (c) 2015 Todd McCready. All rights reserved.
//

import Foundation
import CoreData
@objc(Teams)

class Teams: NSManagedObject {

    @NSManaged var teamName: String
    @NSManaged var leagueName: String
    @NSManaged var wins: NSNumber
    @NSManaged var losses: NSNumber
    @NSManaged var isCurrentSeason: NSNumber
    @NSManaged var season: String
    @NSManaged var colorPrimary: AnyObject
    @NSManaged var colorSecondary: AnyObject
    @NSManaged var players: NSManagedObject
    
}
