//
//  MonthInfo.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI

struct MonthInfo: View {
    let month: Int
    let year: Int
    let total: Double
    
    var body: some View {
        let formattedYear = String(year).replacingOccurrences(of: " ", with: "")
        
        HStack {
            Text("\(month), \(formattedYear)")
                .font(.title3)
                .bold()
            Spacer()
            Text("Monthly total:")
                .foregroundStyle(Color(K.Colors.secondaryText))
            Text(String(format: "%.2f", total))
        }
    }
}

#Preview {
    MonthInfo(month: 11, year: 2024, total: 59.33)
}
