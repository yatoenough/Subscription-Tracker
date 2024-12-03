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
            container = try ModelContainer(for: Subscription.self)
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
