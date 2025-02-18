//
//  MonthInfo.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI

struct MonthTotalInfo: View {
    let total: Double
    
    @Environment(CalendarViewModel.self) private var calendarViewModel: CalendarViewModel
    
    @State private var datePickerShown: Bool = false
    @State private var selectedDate: Date = Date()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM, yyyy"
        return formatter
    }()
    
    var body: some View {
        HStack {
            Text(dateFormatter.string(from: calendarViewModel.currentDate))
                .font(.title3)
                .bold()
                .onTapGesture {
                    datePickerShown.toggle()
                }
            Spacer()
            Text("Monthly total:")
                .foregroundStyle(.secondaryText)
            Text(String(format: "%.2f", total))
        }
        .sheet(isPresented: $datePickerShown) {
            VStack {
                Text("Select date")
                    .font(.title)
                    .bold()
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
            }
            .padding()
            .presentationDetents([.medium])
            .onChange(of: selectedDate) { _, _ in
                calendarViewModel.currentDate = selectedDate
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MonthTotalInfo(total: 59.33)
        .environment(CalendarViewModel(.now))
}
