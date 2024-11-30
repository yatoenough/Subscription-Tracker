//
//  DayCell.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 30/11/2024.
//

import SwiftUI

struct DayCell: View {
    let dayNumber: Int
    let image: String?
    
    var body: some View {
        VStack {
            if let image {
                Image(image)
                    .resizable()
                    .frame(width: 20, height: 20)
            } else {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 20, height: 20)
            }
            
            Text("\(dayNumber)")
                .font(.caption)
                .padding(.bottom, 1)
        }
        .frame(width: 50, height: 50)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(K.Colors.secondaryGray))
        )
    }
}

#Preview {
    HStack {
        DayCell(dayNumber: 13, image: "spotify")
            .preferredColorScheme(.dark)
        DayCell(dayNumber: 13, image: nil)
            .preferredColorScheme(.dark)
    }
}
