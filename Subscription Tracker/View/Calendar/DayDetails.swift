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
    
    @State private var calendarViewModel: CalendarViewModel
    
    init(date: Date, subscriptions: [Subscription]) {
        self.date = date
        self.calendarViewModel = CalendarViewModel(date)
        self.subscriptions = subscriptions
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMMM d"
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            ForEach(subscriptions, id: \.id) { subscription in
                VStack(alignment: .leading) {
                    Text(subscription.name)
                        .font(.title)
                        .bold()
                    
                    HStack {
                        SubscriptionTrait(color: subscription.type.color, text: subscription.type.value)
                            .padding(.trailing)
                        
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundStyle(subscription.type.color)
                        
                        Text(String(format: "%.2f$", subscription.price))
                            .font(.headline)
                        
                        Spacer()
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.secondaryGray)
                }
            }
            .padding()
        }
        .background(
            Color.background
        )
        .navigationTitle(dateFormatter.string(from: date))
        .navigationBarTitleDisplayMode(.large)
        
    }
}

#Preview {
    NavigationStack {
        DayDetails(date: .now, subscriptions: [
            Subscription(name: "Test", price: 100, type:  Frequency(value: "Monthly", colorHex: Color.green.toHex()!), date: .now),
            Subscription(name: "Test", price: 100, type:  Frequency(value: "Monthly", colorHex: Color.green.toHex()!), date: .now)
        ])
        .preferredColorScheme(.dark)
        .environment(CalendarViewModel(.now))
    }
}
