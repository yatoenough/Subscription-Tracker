//
//  CalendarViewModel.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 05/12/2024.
//

import Foundation

@Observable
class CalendarViewModel {
    var currentDate: Date
    let calendar = Calendar.current
    
    var year: Int { calendar.component(.year, from: currentDate) }
    var month: Int { calendar.component(.month, from: currentDate) }
    var day: Int { calendar.component(.day, from: currentDate) }
    
    private let formatter = DateFormatter()
    
    init(_ date: Date) {
        self.currentDate = date
    }
    
    func monthName(_ month: Int) -> String {
        return formatter.monthSymbols[month - 1]
    }
    
    func daysInMonth(month: Int, year: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.month = month
        dateComponents.year = year
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        return calendar.range(of: .day, in: .month, for: date)!.count
    }
    
    func firstDayOfMonthStartingMonday(month: Int, year: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.month = month
        dateComponents.year = year
        dateComponents.day = 1
        
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let weekday = calendar.component(.weekday, from: date)
        
        return (weekday == 1 ? 6 : weekday - 2)
    }
    
    func dateForDay(_ day: Int) -> Date {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: month, day: day)
        return calendar.date(from: components) ?? Date()
    }
}
