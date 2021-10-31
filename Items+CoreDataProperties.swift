//
//  Items+CoreDataProperties.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 19/10/21.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var productName: String?
    @NSManaged public var carts: Set<Cart>?

}

// MARK: Generated accessors for carts
extension Items {

    @objc(addCartsObject:)
    @NSManaged public func addToCarts(_ value: Cart)

    @objc(removeCartsObject:)
    @NSManaged public func removeFromCarts(_ value: Cart)

    @objc(addCarts:)
    @NSManaged public func addToCarts(_ values: Set<Cart>?)

    @objc(removeCarts:)
    @NSManaged public func removeFromCarts(_ values: Set<Cart>?)

}

extension Items : Identifiable {

}
