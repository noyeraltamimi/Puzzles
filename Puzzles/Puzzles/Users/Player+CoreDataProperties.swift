//
//  Player+CoreDataProperties.swift
//  Puzzles
//
//  Created by noyer altamimi on 10/05/1443 AH.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var pic: Data?
    @NSManaged public var time: String?

}

extension Player : Identifiable {

}
