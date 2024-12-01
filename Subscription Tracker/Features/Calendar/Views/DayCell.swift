//
//  DayCell.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 30/11/2024.
//

import SwiftUI

struct DayCell: View {
    let dayNumber: Int
    let subscription: Subscription?
    
    var body: some View {
        ZStack {
            VStack {
                if let subscription {
                    Image(subscription.image)
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
            if let subscription {
                Circle()
                    .fill(subscription.type.color)
                    .frame(width: 10, height: 10)
                    .offset(x: 20, y: -20)
            }
        }
    }
}

#Preview {
    HStack {
        DayCell(dayNumber: 13, subscription: Subscription(id: 1,name: "Test", price: 100, image: "spotify", type: SubscriptionTypes.yearly.getType()))
            .preferredColorScheme(.dark)
        DayCell(dayNumber: 13, subscription: nil)
            .preferredColorScheme(.dark)
    }
}
