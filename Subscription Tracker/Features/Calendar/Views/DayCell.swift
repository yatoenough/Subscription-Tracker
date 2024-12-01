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
                if let subscriptions {

                    if subscriptions.count == 1, let subscription = subscriptions.first {
                        Circle()
                            .fill(subscription.type.color)
                            .frame(width: 20, height: 20)
                            
                            
                    } else if subscriptions.count > 1 {
                        let count = subscriptions.count
                        let subscription = subscriptions.first!
                        Circle()
                            .fill(subscription.type.color)
                            .frame(width: 20, height: 20)
                            .overlay {
                                Circle()
                                    .fill(Color(K.Colors.primaryGray))
                                    .overlay {
                                        Text("+\(count-1)")
                                            .font(.caption)
                                            .bold()
                                        
                                    }.offset(x: 5, y: 0)
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
            .gesture (
                TapGesture()
                    .onEnded {
                        dayInfoModalPresented.toggle()
                    }
            )
        }.sheet(isPresented: $dayInfoModalPresented) {
            if let subscriptions {
                DayDetails(subscriptions: subscriptions)
            }
        }
    }
}



#Preview {
    HStack {
        DayCell(dayNumber: 13, subscriptions: [Subscription(id: 1,name: "Test", price: 100, type: SubscriptionTypes.yearly.getType(), date: Date()), Subscription(id: 1,name: "Test", price: 100, type: SubscriptionTypes.yearly.getType(), date: Date())])
        DayCell(dayNumber: 13, subscriptions: [Subscription(id: 1,name: "Test", price: 100, type: SubscriptionTypes.yearly.getType(), date: Date())])
        DayCell(dayNumber: 13, subscriptions: nil)
        
    }.preferredColorScheme(.dark)
}
