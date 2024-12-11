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

private let defaultTypes: [String: SubscriptionType] = [
    "yearly": SubscriptionType(value: "Yearly", colorHex: Color.purple.toHex()!),
    "monthly": SubscriptionType(value: "Monthly", colorHex: Color.green.toHex()!),
    "weekly": SubscriptionType(value: "Weekly", colorHex: Color.blue.toHex()!),
    "quarterly": SubscriptionType(value: "Quarterly", colorHex: Color.orange.toHex()!),
]

enum DefaultSubscriptionTypes: CaseIterable {
    case yearly
    case monthly
    case weekly
    case quarterly
    
    func getValue() -> SubscriptionType {
        switch self {
        case .yearly:
            return defaultTypes["yearly"]!
        case .monthly:
            return defaultTypes["monthly"]!
        case .weekly:
            return defaultTypes["weekly"]!
        case .quarterly:
            return defaultTypes["quarterly"]!
        }
    }
}
