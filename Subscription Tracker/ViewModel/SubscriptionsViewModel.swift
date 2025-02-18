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
    
    func fetchSubscriptionById(_ id: UUID) -> Subscription? {
        let fetchDescriptor = FetchDescriptor<Subscription>(predicate: #Predicate { subscription in
            subscription.id == id
        })
        
        var subscriptions: [Subscription] = []
        
        do {
            subscriptions = try modelContext.fetch(fetchDescriptor)
        } catch {
            print(error.localizedDescription)
        }
        
        return subscriptions.first
    }
    
    func editSubscription(id: UUID, _ newSubscription: Subscription){
        guard let subscriptionToEdit = self.fetchSubscriptionById(id) else { return }
        
        subscriptionToEdit.name = newSubscription.name
        subscriptionToEdit.price = newSubscription.price
        subscriptionToEdit.type = newSubscription.type
        subscriptionToEdit.date = newSubscription.date
        
        do {
            try modelContext.save()
        }
        catch {
            print(error.localizedDescription)
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
    
    func getSubscriptionDates(subscriptions: [Subscription], visibleRange: DateInterval) -> Set<Date> {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        var datesSet = Set<Date>()
        
        for subscription in subscriptions {
            var currentDate = subscription.date
            
            while currentDate <= visibleRange.end {
                if currentDate >= visibleRange.start {
                    datesSet.insert(calendar.startOfDay(for: currentDate))
                }
                
                
                
                switch subscription.type {
                    
                case Frequency.defaultFrequencies.first(where: { $0.value == "Weekly" }):
                    currentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate) ?? currentDate
                case Frequency.defaultFrequencies.first(where: { $0.value == "Monthly" }):
                    currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
                case Frequency.defaultFrequencies.first(where: { $0.value == "Yearly" }):
                    currentDate = calendar.date(byAdding: .year, value: 1, to: currentDate) ?? currentDate
                default :
                    currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
                    
                }
            }
        }
        
        return datesSet
    }
}
