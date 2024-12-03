//
//  SubscriptionType.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 01/12/2024.
//

import SwiftUI

struct SubscriptionType {
    let value: String
    let color: Color
}

enum DefaultSubscriptionTypes: CaseIterable {
    case yearly
    case monthly
    case weekly
    case threeMonth
    
    func getValue() -> SubscriptionType {
        switch self {
        case .yearly:
            return SubscriptionType(value: "Yearly", color: .purple)
        case .monthly:
            return SubscriptionType(value: "Monthly", color: .green)
        case .weekly:
            return SubscriptionType(value: "Weekly", color: .blue)
        case .threeMonth:
            return SubscriptionType(value: "3-Months", color: .orange)
        }
    }
}
