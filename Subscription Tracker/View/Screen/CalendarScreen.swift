//
//  CalendarScreen.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI
import SwiftData

struct CalendarScreen: View {
    @Environment(SubscriptionsViewModel.self) private var subscriptionsViewModel: SubscriptionsViewModel
    @Environment(CalendarViewModel.self) private var calendarViewModel: CalendarViewModel
    
    @Query(sort: \Frequency.value) private var frequencies: [Frequency]
    private var subscriptions: [Subscription] { subscriptionsViewModel.getSubscriptions() }
    
    private var monthlyTotal: Double {
        subscriptionsViewModel.calculateMonthlySubscriptionCost(month: calendarViewModel.month)
    }
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 3)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                MonthTotalInfo(total: monthlyTotal)
                    .padding(.vertical)
                
                Divider()
                    .foregroundStyle(.secondaryGray)
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(frequencies, id: \.id) { type in
                        SubscriptionTrait(color: type.color, text: type.value)
                    }
                }
                
                CalendarView(subscriptions: subscriptions)
            }
            .padding()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DataPreview {
        CalendarScreen()
    }
}
