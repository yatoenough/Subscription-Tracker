//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 11/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            VStack {
                CalendarView()
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subscription.self, SubscriptionType.self, configurations: config)
    
    let defaultTypes: [SubscriptionType] = [
        SubscriptionType(value: "Yearly", colorHex: Color.purple.toHex()!),
        SubscriptionType(value: "Monthly", colorHex: Color.green.toHex()!),
        SubscriptionType(value: "Weekly", colorHex: Color.blue.toHex()!),
        SubscriptionType(value: "Quarterly", colorHex: Color.orange.toHex()!),
    ]
    
    for type in defaultTypes {
        container.mainContext.insert(type)
    }
    
    return NavigationStack {
        ContentView()
    }
    .preferredColorScheme(.dark)
    .modelContainer(container)
    .environment(SubscriptionsViewModel(modelContext: container.mainContext))
    .environment(CalendarViewModel(.now))
}
