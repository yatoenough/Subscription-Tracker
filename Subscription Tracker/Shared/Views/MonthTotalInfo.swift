//
//  MonthInfo.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI

struct MonthTotalInfo: View {
    let total: Double
    
    @Environment(CalendarViewModel.self) var calendarViewModel: CalendarViewModel
    
    var body: some View {
        let formattedYear = String(calendarViewModel.year).replacingOccurrences(of: " ", with: "")
        
        HStack {
            Text("\(calendarViewModel.monthName(calendarViewModel.month)), \(formattedYear)")
                .font(.title3)
                .bold()
            Spacer()
            Text("Monthly total:")
                .foregroundStyle(Color(K.Colors.secondaryText))
            Text(String(format: "%.2f", total))
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MonthTotalInfo(total: 59.33)
        .environment(CalendarViewModel(.now))
}
