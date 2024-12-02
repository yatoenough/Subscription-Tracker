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
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CalendarScreenView()
            }.preferredColorScheme(.dark)
        }
        .modelContainer(for: Subscription.self)
    }
}
