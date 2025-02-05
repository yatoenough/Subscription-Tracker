//
//  DayDetails.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 01/12/2024.
//

import SwiftUI

struct DayDetails: View {
    let subscriptions: [Subscription]
    let date: Date
    
    @Environment(SubscriptionsViewModel.self) private var subscriptionsViewModel
    @Environment(CalendarViewModel.self) private var calendarViewModel
    
    init(date: Date, subscriptions: [Subscription]) {
        self.date = date
        self.subscriptions = subscriptions
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMMM d"
        return formatter
    }()
    
    var body: some View {
        List(subscriptions, id: \.id) { subscription in
            
            SubscriptionItem(subscription: subscription)
                .swipeActions(edge: .trailing) {
                    Button("Edit", systemImage: "pencil") {
                        
                    }
                    .frame(height: 30)
                    .tint(.orange)
                    
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        subscriptionsViewModel.deleteSubscription(subscription)
                    }
                    .frame(height: 30)
                    .tint(.red)
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .background(
            Color.background
        )
        .listStyle(.plain) // Remove default List style
        .scrollContentBackground(.hidden)
        .navigationTitle(dateFormatter.string(from: date))
        .navigationBarTitleDisplayMode(.large)
        
    }
}

#Preview {
    DataPreview {
        DayDetails(date: .now, subscriptions: [
            Subscription(name: "Test", price: 100, type:  Frequency(value: "Monthly", colorHex: Color.green.toHex()!), date: .now),
            Subscription(name: "Test", price: 100, type:  Frequency(value: "Monthly", colorHex: Color.green.toHex()!), date: .now)
        ])
    }
}
