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
    
    @Query(sort: \SubscriptionType.value) var defaultSubscriptionTypes: [SubscriptionType]
    var subscriptions: [Subscription] { subscriptionsViewModel.getSubscriptions() }
    
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Divider()
                        .foregroundStyle(Color(K.Colors.secondaryGray))
                    
                    MonthTotalInfo(total: 23.45)
                        .padding(.vertical)
                    
                    Divider()
                        .foregroundStyle(Color(K.Colors.secondaryGray))
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 5) {
                        ForEach(defaultSubscriptionTypes, id: \.self) { type in
                            CalendarTrait(color: Color(hex: type.colorHex), text: type.value)
                        }
                    }
                    
                    SubscriptionsCalendar(subscriptions: subscriptions)
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Calendar") {
                            print(Color.red.toHex()!)
                        }
                        .foregroundStyle(.white)
                        .font(.title2)
                        
                        Button("List") {
                            print("Pressed")
                        }
                        .foregroundStyle(Color(K.Colors.secondaryText))
                        .font(.title2)
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink(destination: AddSubscriptionForm()) {
                            Text("+")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subscription.self, SubscriptionType.self, configurations: config)
    
    for typeCase in DefaultSubscriptionTypes.allCases {
        let type = typeCase.getValue()
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
