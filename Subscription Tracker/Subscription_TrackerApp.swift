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
    let calendarViewModel: CalendarViewModel
    
    init() {
        do {
            container = try ModelContainer(
                for: Subscription.self, FrequencyType.self
            )
            
            let isFirstLaunch = !UserDefaults.standard.bool(forKey: K.firstLaunchFlag)
            
            if isFirstLaunch {
                UserDefaults.standard.set(true, forKey: K.firstLaunchFlag)
                
                let defaultFrequencies: [FrequencyType] = [
                    FrequencyType(value: "Yearly", colorHex: Color.purple.toHex()!),
                    FrequencyType(value: "Monthly", colorHex: Color.green.toHex()!),
                    FrequencyType(value: "Weekly", colorHex: Color.blue.toHex()!),
                    FrequencyType(value: "Quarterly", colorHex: Color.orange.toHex()!),
                ]
                
                for type in defaultFrequencies {
                    container.mainContext.insert(type)
                }
            }
            try container.mainContext.save()
            
        } catch {
            fatalError("Failed to create ModelContainer.")
        }
        
        subscriptionsViewModel = SubscriptionsViewModel(modelContext: container.mainContext)
        calendarViewModel = CalendarViewModel(.now)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }.preferredColorScheme(.dark)
        }
        .modelContainer(container)
        .environment(subscriptionsViewModel)
        .environment(calendarViewModel)
    }
}
