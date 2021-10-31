//
//  Cart+CoreDataProperties.swift
//  TaskProductList
//
//  Created by Ramesh Mishra on 19/10/21.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var image_url: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var rating: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var items: Items?

}

extension Cart : Identifiable {

}
