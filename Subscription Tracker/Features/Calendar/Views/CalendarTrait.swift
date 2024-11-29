//
//  CalendarTrait.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 29/11/2024.
//

import SwiftUI

struct CalendarTrait: View {
    let color: Color
    let text: String
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 5, height: 5)
            Text(text)
                .font(.headline)
        }
    }
}


#Preview {
    CalendarTrait(color: .purple, text: "Text")
}
