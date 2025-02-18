//
//  ListScreen.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 10/02/2025.
//

import SwiftUI
import SwiftData

struct ListScreen: View {
    @Query var subscriptions: [Subscription]
    
    @Environment(SubscriptionsViewModel.self) private var subscriptionsViewModel: SubscriptionsViewModel
    @Environment(CalendarViewModel.self) private var calendarViewModel: CalendarViewModel
    
    private var monthlyTotal: Double {
        subscriptionsViewModel.calculateMonthlySubscriptionCost(month: calendarViewModel.month, year: calendarViewModel.year)
    }
    
    var body: some View {
        ScrollView {
            MonthTotalInfo(total: monthlyTotal)
                .padding(.vertical)
            
            Divider()
                .foregroundStyle(.secondaryGray)
            
            ForEach(subscriptions, id: \.id) { subscription in
                SubscriptionItem(subscription: subscription)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                
            }
        }
        .padding()
        .background(Color.background)
        
        
    }
    
}

#Preview {
    DataPreview {
        ListScreen()
    }
}
