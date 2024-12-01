//
//  DayDetails.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 01/12/2024.
//

import SwiftUI

struct DayDetails: View {
    let subscriptions: [Subscription]
    
    var body: some View {
        VStack {
            ForEach(subscriptions) { subscription in
                HStack {
                    Text(subscription.name)
                        .font(.title)
                    Spacer()
                    Text(String(format: "%.2f", subscription.price))
                }.padding()
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(K.Colors.secondaryGray))
                            .shadow(color:subscription.type.color.opacity(0.3) ,radius: 10, x: 0, y: 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(subscription.type.color.opacity(0.4), lineWidth: 1)
                            )
                    }
            }.padding()
            Spacer()
        }
    }
}

#Preview {
    DayDetails(subscriptions: [Subscription(id: 1,name: "Test", price: 100, type: SubscriptionTypes.yearly.getType(), date: Date()), Subscription(id: 1,name: "Test", price: 100, type: SubscriptionTypes.yearly.getType(), date: Date())])
        .preferredColorScheme(.dark)
}
