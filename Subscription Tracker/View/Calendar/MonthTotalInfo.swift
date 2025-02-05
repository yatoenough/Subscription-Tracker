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
            Spacer()
            Text("Monthly total:")
                .foregroundStyle(.secondaryText)
            Text(String(format: "%.2f", total))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MonthTotalInfo(total: 59.33)
        .environment(CalendarViewModel(.now))
}
