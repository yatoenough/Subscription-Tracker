//
//  CalendarView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    var subscriptions: [Subscription]
    
    @Environment(CalendarViewModel.self) private var calendarViewModel: CalendarViewModel
    @Environment(SubscriptionsViewModel.self) private var subscriptionsViewModel: SubscriptionsViewModel
    
    private let daysList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 7)
    
    private var daysInMonth: Int {
        calendarViewModel.daysInMonth(month: calendarViewModel.month, year: calendarViewModel.year)
    }
    
    private var firstWeekday: Int {
        calendarViewModel.firstDayOfMonthStartingMonday(month: calendarViewModel.month, year: calendarViewModel.year)
    }
    
    private var totalSlots: Int {
        daysInMonth + firstWeekday
    }
    
    private var monthInterval: DateInterval {
        var start = DateComponents()
        start.year = calendarViewModel.year
        start.month = calendarViewModel.month
        start.day = 1
        
        var end = DateComponents()
        end.year = calendarViewModel.year
        end.month = calendarViewModel.month + 1
        end.day = 1

        return DateInterval(start: Calendar.current.date(from: start)!, end: Calendar.current.date(from: end)!)
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(daysList, id: \.self) { day in
                    Text(day.uppercased())
                        .foregroundStyle(.secondaryText)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    
                }
            }
            
            LazyVGrid(columns: columns, spacing: 3) {
                ForEach(0..<totalSlots, id: \.self) { index in
                    if index < firstWeekday {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 40)
                    } else {
                        let dayNumber = index - firstWeekday + 1
                        
                        let filteredSubscriptions: [Subscription] = subscriptions.filter({ subscription in
                            isSubscriptionAppearingOnDay(subscription: subscription, day: dayNumber)
                        })
                        
                        NavigationLink(
                            destination: DayDetails(
                                date: calendarViewModel.dateForDay(dayNumber),
                                subscriptions: filteredSubscriptions)
                        ) {
                            DayCell(dayNumber: dayNumber, subscriptions: filteredSubscriptions)
                        }
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
    
    private func isSubscriptionAppearingOnDay(subscription: Subscription, day: Int) -> Bool {
        let subscriptionDates = subscriptionsViewModel.getSubscriptionDates(subscription: subscription, visibleRange: monthInterval)
        let daysOfDates = subscriptionDates.map({ Calendar.current.component(.day, from: $0) })
        
        return daysOfDates.contains(day)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DataPreview {
        CalendarView(subscriptions: [])
    }
}
