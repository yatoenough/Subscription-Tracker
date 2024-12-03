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

enum DefaultSubscriptionTypes: CaseIterable {
    case yearly
    case monthly
    case weekly
    case quarterly
    
    func getValue() -> SubscriptionType {
        switch self {
        case .yearly:
            return SubscriptionType(value: "Yearly", colorHex: Color.purple.toHex()!)
        case .monthly:
            return SubscriptionType(value: "Monthly", colorHex: Color.green.toHex()!)
        case .weekly:
            return SubscriptionType(value: "Weekly", colorHex: Color.blue.toHex()!)
        case .quarterly:
            return SubscriptionType(value: "Quarterly", colorHex: Color.orange.toHex()!)
        }
    }
}
