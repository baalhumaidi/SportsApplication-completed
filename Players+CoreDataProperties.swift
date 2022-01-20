//
//  Players+CoreDataProperties.swift
//  SportsApplication
//
//  Created by admin on 28/12/2021.
//
//

import Foundation
import CoreData


extension Players {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Players> {
        return NSFetchRequest<Players>(entityName: "Players")
    }

    @NSManaged public var height: Int16
    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var sport: SportItem?

}

extension Players : Identifiable {

}
