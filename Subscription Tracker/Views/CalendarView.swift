//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI

struct CalendarView: View {
    let daysList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let calendar = Calendar.current
    let currentDate = Date()
    
    var body: some View {
        GeometryReader { geometry in
            let cellSize = geometry.size.width / 7
            VStack {
                HStack {
                    Text("Calendar")
                        .font(.title)
                    Spacer()
                    Text("Monthly total: $59.99")
                }
                HStack {
                    HStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Text("Monthly")
                    }
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        Text("Yearly")
                    }
                    Spacer()
                }
                VStack {
                    HStack {
                        ForEach(daysList, id: \.self) { day in
                            Text(day)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    let days = generateDays(for: 11, year: 2024)
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 1) {
                        ForEach(days.indices, id: \.self) { index in
                            if let day = days[index] {
                                Text(day)
                                    .frame(width: cellSize, height: cellSize)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.gray)
                                    )
                            } else {
                                Spacer()
                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                }
                .padding(.vertical)
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Calendar") {
                        print("Pressed")
                    }
                    
                    Button("List") {
                        print("Pressed")
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("+") {
                        print("Pressed")
                    }
                }
            }
            Spacer()
        }
    }
    
    func generateDays(for month: Int, year: Int) -> [String?] {
        var days: [String?] = Array(repeating: nil, count: 7) // Empty spaces for alignment
        
        // Find the first day of the month
        let dateComponents = DateComponents(year: year, month: month)
        guard let firstDayOfMonth = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
            return []
        }
        
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth) // Sunday = 1, Monday = 2, etc.
        let offset = firstWeekday - 1 // Adjust to start from Sunday
        
        // Add blank spaces before the first day of the month
        days.append(contentsOf: Array(repeating: nil, count: offset))
        
        // Add all days of the month
        days.append(contentsOf: range.map { String($0) })
        
        return days
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
