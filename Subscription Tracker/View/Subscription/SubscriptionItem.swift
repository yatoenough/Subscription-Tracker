//
//  SubscriptionItem.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 05/02/2025.
//

import SwiftUI

struct SubscriptionItem: View {
    let subscription: Subscription
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(subscription.name)
                .font(.title)
                .bold()
            
            HStack {
                SubscriptionTrait(color: subscription.type.color, text: subscription.type.value)
                    .padding(.trailing)
                
                Image(systemName: "dollarsign.circle.fill")
                    .foregroundStyle(subscription.type.color)
                
                Text(String(format: "%.2f$", subscription.price))
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "arrow.left")
                    .font(.footnote)
                    .foregroundColor(.white)
                    
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.secondaryGray)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DataPreview {
        SubscriptionItem(subscription: Subscription(name: "Test", price: 100, type:  Frequency(value: "Monthly", colorHex: Color.green.toHex()!), date: Date()))
    }
}
