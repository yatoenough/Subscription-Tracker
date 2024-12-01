//
//  CalendarView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI

struct CalendarView: View {
    let daysList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let month: Int
    let year: Int
    
    func createSpecificDate(year: Int, month: Int, day: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        // Use the current calendar to create the date
        return Calendar.current.date(from: components)
    }
    
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
            
            #warning("Rewrite to MVVM")
            let days = daysInMonth(month: month, year: year)
            let firstWeekday = firstDayOfMonthMondayStart(month: month, year: year)
            let subscriptions: [Subscription] = [
                Subscription(id: 1, name: "Spotify", price: 10.99, type: SubscriptionTypes.threeMonth.getType(), date: createSpecificDate(year: 2024, month: 12, day: 1)!),
                Subscription(id: 2, name: "YouTube", price: 20.99, type: SubscriptionTypes.weekly.getType(), date: createSpecificDate(year: 2024, month: 12, day: 6)!),
                Subscription(id: 3, name: "ChatGPT", price: 11.00, type: SubscriptionTypes.monthly.getType(), date: createSpecificDate(year: 2024, month: 12, day: 6)!),
                Subscription(id: 4, name: "iCloud", price: 13.56, type: SubscriptionTypes.yearly.getType(), date: createSpecificDate(year: 2024, month: 12, day: 21)!)
            ]
            
            
            
            
            let totalSlots = days + firstWeekday
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 3) {
                ForEach(0..<totalSlots, id: \.self) { index in
                    if index < firstWeekday {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 40)
                    } else {
                        #warning("Simplify code")
                        let sub = subscriptions.filter({ sub in
                            Calendar.current.component(.day, from: sub.date) == index - firstWeekday + 1
                        })
                        if sub.count > 1 {
                            DayCell(dayNumber: index - firstWeekday + 1, subscriptions: sub)
                        } else if sub.count == 1 {
                            DayCell(dayNumber: index - firstWeekday + 1, subscriptions: sub)
                        }
                        else {
                            DayCell(dayNumber: index - firstWeekday + 1, subscriptions: nil)
                        }
                    }
                }
            }
        }
    }
    
    private func daysInMonth(month: Int, year: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.month = month
        dateComponents.year = year
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        return calendar.range(of: .day, in: .month, for: date)!.count
    }
    
    private func firstDayOfMonthMondayStart(month: Int, year: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.day = 1
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let weekday = calendar.component(.weekday, from: date)
        
        return (weekday == 1 ? 6 : weekday - 2)
    }
}

#Preview {
    CalendarView(month: 11, year: 2024)
        .padding()
        .preferredColorScheme(.dark)
}
