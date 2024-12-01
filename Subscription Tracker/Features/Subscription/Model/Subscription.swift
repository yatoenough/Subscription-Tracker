//
//  Subscription.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 01/12/2024.
//

import Foundation

struct Subscription: Identifiable {
    let id: Int
    let name: String
    let price: Double
    let image: String
    let type: SubscriptionType
    let date: Date
}
