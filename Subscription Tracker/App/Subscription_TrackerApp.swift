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
    private let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Schema([Subscription.self, Frequency.self]))
            
            @AppStorage("isFirstLaunch")
            var isFirstLaunch: Bool = true
            
            if isFirstLaunch {
                isFirstLaunch = false
                
                for type in Frequency.defaultFrequencies {
                    container.mainContext.insert(type)
                }
                
                try container.mainContext.save()
            }
        } catch {
            fatalError("Failed to create ModelContainer: \(error.localizedDescription)")
        }
    }
    
    private var subscriptionsViewModel: SubscriptionsViewModel {
        SubscriptionsViewModel(modelContext: container.mainContext)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }.preferredColorScheme(.dark)
        }
        .modelContainer(container)
        .environment(subscriptionsViewModel)
        .environment(CalendarViewModel(.now))
    }
}
