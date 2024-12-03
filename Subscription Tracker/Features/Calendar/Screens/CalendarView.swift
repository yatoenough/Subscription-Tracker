//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    let currentDate = Date()
    let calendar = Calendar.current
    
    var year: Int { calendar.component(.year, from: currentDate) }
    var month: Int { calendar.component(.month, from: currentDate) }
    var day: Int { calendar.component(.day, from: currentDate) }
    
    @Query(sort: \SubscriptionType.value) var defaultSubscriptionTypes: [SubscriptionType]
    @Environment(SubscriptionsViewModel.self) var subscriptionsViewModel: SubscriptionsViewModel
    var subscriptions: [Subscription] { subscriptionsViewModel.getSubscriptions() }
    
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Divider()
                        .foregroundStyle(Color(K.Colors.secondaryGray))
                    
                    MonthTotalInfo(month: month, year: year, total: 23.45)
                        .padding(.vertical)
                    
                    Divider()
                        .foregroundStyle(Color(K.Colors.secondaryGray))
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 5) {
                        ForEach(defaultSubscriptionTypes, id: \.self) { type in
                            CalendarTrait(color: Color(hex: type.colorHex), text: type.value)
                        }
                    }
        
                    SubscriptionsCalendar(month: 10, year: 2024, subscriptions: subscriptions)
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
                        Button(action: {
                            subscriptionsViewModel.addSubscription(Subscription(name: "Test", price: 23, type: defaultSubscriptionTypes.last!, date: Date()))
                        }, label: {
                            Text("+")
                                .font(.title)
                                .foregroundStyle(.white)
                        })
                        
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
}
