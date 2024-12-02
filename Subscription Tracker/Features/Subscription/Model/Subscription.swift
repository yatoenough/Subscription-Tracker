//
//  Subscription.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 01/12/2024.
//

import Foundation
import SwiftData

@Model
class Subscription {
    var id: Int
    var name: String
    var price: Double
    @Relationship(deleteRule: .noAction) var type: SubscriptionType
    var date: Date
    
    init(id: Int, name: String, price: Double, type: SubscriptionType, date: Date) {
        self.id = id
        self.name = name
        self.price = price
        self.type = type
        self.date = date
    }
}
