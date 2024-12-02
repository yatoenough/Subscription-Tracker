//
//  MonthInfo.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI

struct MonthTotalInfo: View {
    let month: Int
    let year: Int
    let total: Double
    
    var body: some View {
        let formattedYear = String(year).replacingOccurrences(of: " ", with: "")
        
        HStack {
            Text("\(monthName(month)), \(formattedYear)")
                .font(.title3)
                .bold()
            Spacer()
            Text("Monthly total:")
                .foregroundStyle(Color(K.Colors.secondaryText))
            Text(String(format: "%.2f", total))
        }
    }
    
    private func monthName(_ month: Int) -> String {
        let formatter = DateFormatter()
        return formatter.monthSymbols[month - 1]
    }
}

#Preview {
    MonthTotalInfo(month: 11, year: 2024, total: 59.33)
}
