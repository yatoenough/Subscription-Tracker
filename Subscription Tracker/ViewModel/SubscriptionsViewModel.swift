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
    
    func calculateMonthlySubscriptionCost(month: Int, year: Int) -> Double {
        let subscriptions = getSubscriptions()
        
        var start = DateComponents()
        start.year = year
        start.month = month
        start.day = 1
        
        var end = DateComponents()
        end.year = year
        end.month = month + 1
        end.day = 1
        
        let visibleRange = DateInterval(start: Calendar.current.date(from: start)!, end: Calendar.current.date(from: end)!)
        
        var totalAmount: Double = 0
        
        for subscription in subscriptions {
            let subscriptionDates = getSubscriptionDates(subscription: subscription, visibleRange: visibleRange)
            totalAmount += subscription.price * Double(subscriptionDates.count)
        }
        
        return totalAmount
    }
    
    func deleteSubscription(_ subscription: Subscription) {
        modelContext.delete(subscription)
    }
    
    func getSubscriptionDates(subscription: Subscription, visibleRange: DateInterval) -> Set<Date> {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        var datesSet = Set<Date>()
        
        var currentDate = subscription.date
        
        while currentDate <= visibleRange.end {
            if currentDate >= visibleRange.start {
                datesSet.insert(calendar.startOfDay(for: currentDate))
            }
            
            switch subscription.type.value {
                
            case "Weekly":
                currentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate) ?? currentDate
            case "Monthly":
                currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? currentDate
            case "Yearly":
                currentDate = calendar.date(byAdding: .year, value: 1, to: currentDate) ?? currentDate
            default:
                currentDate = calendar.date(byAdding: .month, value: 3, to: currentDate) ?? currentDate
                
            }
            
        }
        
        return datesSet
    }
}
