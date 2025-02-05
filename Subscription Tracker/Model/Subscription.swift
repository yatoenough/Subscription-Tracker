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
    var id: UUID = UUID()
    var name: String
    var price: Double
    var type: Frequency
    var date: Date
    
    init(name: String, price: Double, type: Frequency, date: Date) {
        self.name = name
        self.price = price
        self.type = type
        self.date = date
    }
}
