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
            container = try ModelContainer(
                for: Subscription.self, SubscriptionType.self
            )
            
            let isFirstLaunch = !UserDefaults.standard.bool(forKey: "firstLaunch")
            
            if isFirstLaunch {
                UserDefaults.standard.set(true, forKey: "firstLaunch")
                for typeCase in DefaultSubscriptionTypes.allCases {
                    let type = typeCase.getValue()
                    container.mainContext.insert(type)
                }
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
