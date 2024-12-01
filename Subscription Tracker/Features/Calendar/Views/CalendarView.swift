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
            
            let days = daysInMonth(month: month, year: year)
            let firstWeekday = firstDayOfMonthMondayStart(month: month, year: year)
            
            let totalSlots = days + firstWeekday
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 3) {
                ForEach(0..<totalSlots, id: \.self) { index in
                    if index < firstWeekday {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 40)
                    } else {
                        DayCell(dayNumber: index - firstWeekday + 1, subscription: nil)
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
