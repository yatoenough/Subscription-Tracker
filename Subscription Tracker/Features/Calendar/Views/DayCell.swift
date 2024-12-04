//
//  DayCell.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 30/11/2024.
//

import SwiftUI

struct DayCell: View {
    let dayNumber: Int
    let subscriptions: [Subscription]?
    
    @State var dayInfoModalPresented: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if let subscriptions, !subscriptions.isEmpty {
                    let count = subscriptions.count
                    let firstSubscription = subscriptions.first!
                    
                    Circle()
                        .fill(Color(hex: firstSubscription.type.colorHex))
                        .frame(width: 25, height: 25)
                        .overlay {
                            if count > 1 {
                                Circle()
                                    .fill(Color(K.Colors.primaryGray))
                                    .overlay {
                                        Text("+\(count-1)")
                                            .font(.caption2)
                                            .scaledToFit()
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
                    .fill(Color(K.Colors.secondaryGray))
            )
            .gesture(
                TapGesture()
                    .onEnded {
                        dayInfoModalPresented.toggle()
                    }
            )
        }.sheet(isPresented: $dayInfoModalPresented) {
            if let subscriptions {
                #warning("Refactore to date provider")
                DayDetails(subscriptions: subscriptions, day: dayNumber, month: 12, year: 2024)
            }
        }
    }
}



#Preview(traits: .sizeThatFitsLayout) {
    HStack {
        DayCell(dayNumber: 13, subscriptions: [
            Subscription(name: "Test", price: 100, type: DefaultSubscriptionTypes.monthly.getValue(), date: Date()),
            Subscription(name: "Test", price: 100, type: DefaultSubscriptionTypes.monthly.getValue(), date: Date())
        ])
        
        DayCell(dayNumber: 13, subscriptions: [
            Subscription(name: "Test", price: 100, type: DefaultSubscriptionTypes.monthly.getValue(), date: Date())
        ])
        
        DayCell(dayNumber: 13, subscriptions: nil)
        
    }.preferredColorScheme(.dark)
}
