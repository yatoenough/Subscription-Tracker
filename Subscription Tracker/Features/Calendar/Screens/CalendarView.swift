//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(SubscriptionsViewModel.self) var subscriptionsViewModel: SubscriptionsViewModel
    
    @Query(sort: \FrequencyType.value) var frequencies: [FrequencyType]
    var subscriptions: [Subscription] { subscriptionsViewModel.getSubscriptions() }
    
    var body: some View {
        ScrollView {
            VStack {
                
                MonthTotalInfo(total: 23.45)
                    .padding(.vertical)
                
                Divider()
                    .foregroundStyle(Color(K.Colors.secondaryGray))
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 5) {
                    ForEach(frequencies, id: \.self) { type in
                        SubscriptionTrait(color: Color(hex: type.colorHex), text: type.value)
                    }
                }
                
                SubscriptionsCalendar(subscriptions: subscriptions)
            }
            .padding()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subscription.self, FrequencyType.self, configurations: config)
    
    let defaultTypes: [FrequencyType] = [
        FrequencyType(value: "Yearly", colorHex: Color.purple.toHex()!),
        FrequencyType(value: "Monthly", colorHex: Color.green.toHex()!),
        FrequencyType(value: "Weekly", colorHex: Color.blue.toHex()!),
        FrequencyType(value: "Quarterly", colorHex: Color.orange.toHex()!),
    ]
    
    for type in defaultTypes {
        container.mainContext.insert(type)
    }
    
    return NavigationStack {
        CalendarView()
    }
    .preferredColorScheme(.dark)
    .modelContainer(container)
    .environment(SubscriptionsViewModel(modelContext: container.mainContext))
    .environment(CalendarViewModel(.now))
}
