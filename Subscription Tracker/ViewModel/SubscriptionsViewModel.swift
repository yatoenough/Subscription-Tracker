//
//  SubscriptionsViewModel.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 02/12/2024.
//

import Foundation
import SwiftData

@Observable
class SubscriptionsViewModel {
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addSubscription(_ subscription: Subscription) {
        do {
            modelContext.insert(subscription)
            try modelContext.save()
        } catch {
            print("Failed to save subscription: \(error.localizedDescription)")
        }
    }
    
    func getSubscriptions() -> [Subscription] {
        let fetchDescriptor = FetchDescriptor<Subscription>()
        var subscriptions: [Subscription] = []
        
        do {
            subscriptions = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to load subscriptions: \(error.localizedDescription)")
        }
        
        return subscriptions
    }
    
    func calculateMonthlySubscriptionCost(month: Int) -> Double {
        let subscriptions = getSubscriptions()
        
        let filtered = subscriptions.filter({ sub in
            Calendar.current.component(.month, from: sub.date) == month
        })
        
        return filtered.reduce(0) { $0 + $1.price }
    }
    
    func deleteSubscription(_ subscription: Subscription) {
        modelContext.delete(subscription)
    }
}
