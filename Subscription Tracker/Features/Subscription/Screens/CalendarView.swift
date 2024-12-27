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
    @Environment(CalendarViewModel.self) var calendarViewModel: CalendarViewModel
    
    @Query(sort: \FrequencyType.value) var frequencies: [FrequencyType]
    var subscriptions: [Subscription] { subscriptionsViewModel.getSubscriptions() }
    
    var body: some View {
        ScrollView {
            VStack {
                
                MonthTotalInfo(total: subscriptionsViewModel.calculateMonthlySubscriptionCost(month: calendarViewModel.month ))
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

#Preview(traits: .sizeThatFitsLayout) {
    SubscriptionsDataPreview {
        CalendarView()
    }
}
