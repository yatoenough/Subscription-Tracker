//
//  Subscription_TrackerApp.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI
import SwiftData

@main
struct Subscription_TrackerApp: App {
    let container: ModelContainer
    let subscriptionsViewModel: SubscriptionsViewModel
    
    init() {
        do {
            let subscriptionConfig = ModelConfiguration(for: Subscription.self)
            let subscriptionTypesConfig = ModelConfiguration(
                for: SubscriptionType.self,
                isStoredInMemoryOnly: true
            )
            
            container = try ModelContainer(
                for: Subscription.self, SubscriptionType.self,
                configurations: subscriptionConfig, subscriptionTypesConfig
            )
            try container.mainContext.delete(model: SubscriptionType.self)
            
            for typeCase in DefaultSubscriptionTypes.allCases {
                let type = typeCase.getValue()
                container.mainContext.insert(type)
            }
            try container.mainContext.save()
        } catch {
            fatalError("Failed to create ModelContainer.")
        }
        
        subscriptionsViewModel = .init(modelContext: container.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CalendarView()
            }.preferredColorScheme(.dark)
        }
        .modelContainer(container)
        .environment(subscriptionsViewModel)
    }
}
