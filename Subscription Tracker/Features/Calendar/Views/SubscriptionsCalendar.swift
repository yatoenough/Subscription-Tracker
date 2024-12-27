//
//  CalendarView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI
import SwiftData

struct SubscriptionsCalendar: View {
    let daysList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var subscriptions: [Subscription]
    
    @Environment(CalendarViewModel.self) var calendarViewModel: CalendarViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(daysList, id: \.self) { day in
                    Text(day.uppercased())
                        .foregroundStyle(Color(K.Colors.secondaryText))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                    
                }
            }
            
            let days = calendarViewModel.daysInMonth(month: calendarViewModel.month, year: calendarViewModel.year)
            let firstWeekday = calendarViewModel.firstDayOfMonthStartingMonday(month: calendarViewModel.month, year: calendarViewModel.year)
            
            let totalSlots = days + firstWeekday
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 3) {
                ForEach(0..<totalSlots, id: \.self) { index in
                    if index < firstWeekday {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 40)
                    } else {
                        let filteredSubscriptions = subscriptions.filter({ sub in
                            Calendar.current.component(.day, from: sub.date) == index - firstWeekday + 1
                        })
                        NavigationLink(destination: DayDetails(date: calendarViewModel.dateForDay(index - firstWeekday + 1), subscriptions: filteredSubscriptions)) {
                            if filteredSubscriptions.count >= 1 {
                                DayCell(dayNumber: index - firstWeekday + 1, subscriptions: filteredSubscriptions)
                            } else {
                                DayCell(dayNumber: index - firstWeekday + 1, subscriptions: nil)
                            }
                        }
                        .foregroundStyle(.white)
                    }
                }
            }
        }
    }
    
    
}

#Preview(traits: .sizeThatFitsLayout) {
    SubscriptionsDataPreview {
        SubscriptionsCalendar(subscriptions: [])
    }
}
