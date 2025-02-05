//
//  DayCell.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 30/11/2024.
//

import SwiftUI

struct DayCell: View {
    let dayNumber: Int
    let subscriptions: [Subscription]
    
    private var subscriptionCount: Int { subscriptions.count }
    private var firstSubscription: Subscription? { subscriptions.first }
    
    init(dayNumber: Int, subscriptions: [Subscription]) {
        self.dayNumber = dayNumber
        self.subscriptions = subscriptions
    }
    
    var body: some View {
        VStack {
            if !subscriptions.isEmpty, let firstSubscription {
                Circle()
                    .fill(firstSubscription.type.color)
                    .frame(width: 25, height: 25)
                    .overlay {
                        if subscriptionCount > 1 {
                            Circle()
                                .fill(.primaryGray)
                                .overlay {
                                    Text("+\(subscriptionCount-1)")
                                        .font(.caption2)
                                        .bold()
                                    
                                }.offset(x: 5, y: 0)
                        } else {
                            EmptyView()
                        }
                    }
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
                .fill(.secondaryGray)
        )
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HStack {
        DayCell(dayNumber: 13, subscriptions: [
            Subscription(name: "Test", price: 100, type:  Frequency(value: "Monthly", colorHex: Color.green.toHex()!), date: Date()),
            Subscription(name: "Test", price: 100, type:  Frequency(value: "Monthly", colorHex: Color.green.toHex()!), date: Date())
        ])
        
        DayCell(dayNumber: 13, subscriptions: [
            Subscription(name: "Test", price: 100, type:  Frequency(value: "Monthly", colorHex: Color.green.toHex()!), date: Date())
        ])
        
        DayCell(dayNumber: 13, subscriptions: [])
        
    }.preferredColorScheme(.dark)
}
