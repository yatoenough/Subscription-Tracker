//
//  CalendarView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI

struct CalendarView: View {
    let daysList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
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
        }
    }
}

#Preview {
    CalendarView()
}
