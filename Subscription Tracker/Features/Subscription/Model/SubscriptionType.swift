//
//  SubscriptionType.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 01/12/2024.
//

import SwiftUI
import SwiftData

@Model
class SubscriptionType {
    @Attribute(.unique) var id: UUID = UUID()
    var value: String
    var colorHex: String
    @Relationship(deleteRule: .cascade, inverse: \Subscription.type) var subsciptions: [Subscription]?
    
    init(value: String, colorHex: String) {
        self.value = value
        self.colorHex = colorHex
    }
}
