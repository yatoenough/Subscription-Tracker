//
//  SubscriptionsViewModel.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 02/12/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class SubscriptionsViewModel {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getFrequencies() -> [FrequencyType] {
        let fetchDescriptor = FetchDescriptor<FrequencyType>()
        var frequencies: [FrequencyType] = []
        
        do {
            frequencies = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to load subscription types.")
        }
        
        return frequencies
    }
    
    func addSubscription(_ subscription: Subscription) {
        do {
            modelContext.insert(subscription)
            try modelContext.save()
        } catch {
            print("Failed to save subscription.")
        }
    }
    
    func getSubscriptions() -> [Subscription] {
        let fetchDescriptor = FetchDescriptor<Subscription>()
        var subscriptions: [Subscription] = []
        
        do {
            subscriptions = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to load subscriptions.")
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
}
