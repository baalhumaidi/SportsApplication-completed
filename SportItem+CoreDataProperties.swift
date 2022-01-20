//
//  SportItem+CoreDataProperties.swift
//  SportsApplication
//
//  Created by admin on 28/12/2021.
//
//

import Foundation
import CoreData


extension SportItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SportItem> {
        return NSFetchRequest<SportItem>(entityName: "SportItem")
    }

    @NSManaged public var nameofsport: String?
    @NSManaged public var players: NSSet?

}

// MARK: Generated accessors for players
extension SportItem {

    @objc(addPlayersObject:)
    @NSManaged public func addToPlayers(_ value: Players)

    @objc(removePlayersObject:)
    @NSManaged public func removeFromPlayers(_ value: Players)

    @objc(addPlayers:)
    @NSManaged public func addToPlayers(_ values: NSSet)

    @objc(removePlayers:)
    @NSManaged public func removeFromPlayers(_ values: NSSet)

}

extension SportItem : Identifiable {

}
