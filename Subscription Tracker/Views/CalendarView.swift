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
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                GeometryReader { geometry in
                    let cellSize = geometry.size.width / 7
                    
                    VStack {
                        Divider()
                            .foregroundStyle(Color("PrimaryGray"))
                        HStack {
                            Text("October, 2024")
                                .font(.title3)
                                .bold()
                            Spacer()
                            Text("Monthly total:")
                                .foregroundStyle(Color("InactiveText"))
                            Text("$59.99")
                        }.padding(.top)
                        HStack {
                            HStack {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 10, height: 10)
                                Text("Monthly")
                                    .font(.subheadline)
                            }
                            HStack {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 10, height: 10)
                                Text("Yearly").font(.subheadline)
                            }
                            Spacer()
                        }
                        VStack {
                            HStack {
                                ForEach(daysList, id: \.self) { day in
                                    Text(day.uppercased())
                                        .foregroundStyle(Color("InactiveText"))
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity)
                                    
                                }
                            }
                            let days = generateDays(for: 2, year: 2024)
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 1) {
                                ForEach(days.indices, id: \.self) { index in
                                    if let day = days[index] {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color("PrimaryGray"))
                                            .overlay {
                                                VStack {
                                                    Spacer()
                                                    Text(day)
                                                        .font(.caption)
                                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                                }
                                            }
                                            .frame(width: cellSize, height: cellSize)
                                        
                                    } else {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(.clear)
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding()
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarLeading) {
                            Button("Calendar") {
                                print("Pressed")
                            }
                            .foregroundStyle(.white)
                            .font(.title2)
                            
                            Button("List") {
                                print("Pressed")
                            }
                            .foregroundStyle(Color("InactiveText"))
                            .font(.title2)
                        }
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            Button(action: {
                                print("Pressed")
                            }, label: {
                                Text("+")
                                    .font(.title)
                                    .foregroundStyle(.white)
                            })
                            
                        }
                    }
                    Spacer()
                }
            }
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
