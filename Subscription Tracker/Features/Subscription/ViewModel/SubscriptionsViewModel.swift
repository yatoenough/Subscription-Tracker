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
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func getSubscriptions(for date: Date) -> [Subscription] {
        let calendar = Calendar.current
        
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: 0), to: startOfMonth)!
        
        let fetchDescriptor = FetchDescriptor<Subscription>(
            predicate: #Predicate { subscription in
                subscription.date >= startOfMonth && subscription.date < endOfMonth
            }
        )
        
        var subscriptions: [Subscription] = []
        
        do {
            subscriptions = try modelContext.fetch(fetchDescriptor)
        } catch {
            print("Failed to load Subscriptions.")
        }
        
        return subscriptions
    }
}
