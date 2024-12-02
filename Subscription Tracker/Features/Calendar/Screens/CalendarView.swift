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
    
    @Environment(SubscriptionsViewModel.self) var subsViewModel: SubscriptionsViewModel
    var subscriptions: [Subscription] {
        subsViewModel.getSubscriptions(for: currentDate)
    }
    
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
                    HStack {
                        ForEach(SubscriptionTypes.allCases, id: \.self) { enumCase in
                            let type = enumCase.getType()
                            CalendarTrait(color: type.color, text: type.value)
                            Spacer()
                        }
                        Spacer()
                    }.padding(.vertical)
                    SubscriptionsCalendar(month: 10, year: 2024, subscriptions: subscriptions)
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Calendar") {
                            print("Pressed")
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
                        }, label: {
                            Text("+")
                                .font(.title)
                                .foregroundStyle(.white)
                        })
                        
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Subscription.self, configurations: config)
        
        return NavigationStack {
            CalendarView()
        }
        .preferredColorScheme(.dark)
        .modelContainer(container)
        .environment(SubscriptionsViewModel(modelContext: container.mainContext))
        
    } catch {
        fatalError("Failed to create model container.")
    }
}
