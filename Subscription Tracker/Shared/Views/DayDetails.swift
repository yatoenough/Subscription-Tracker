//
//  DayDetails.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 01/12/2024.
//

import SwiftUI

struct DayDetails: View {
    let date: Date
    let subscriptions: [Subscription]
    
    var calendarViewModel: CalendarViewModel { CalendarViewModel(date) }
    
    var body: some View {
        let formattedYear = String(calendarViewModel.year).replacingOccurrences(of: " ", with: "")
        
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            ScrollView {
                ForEach(subscriptions) { subscription in
                    HStack {
                        VStack {
                            HStack {
                                Text(subscription.name)
                                    .font(.title)
                                    .bold()
                                
                                Spacer()
                            }
                            
                            HStack {
                                SubscriptionTrait(color: Color(hex: subscription.type.colorHex), text: subscription.type.value)
                                    .padding(.trailing)
                                
                                Image(systemName: "dollarsign.circle.fill")
                                    .foregroundStyle(Color(hex: subscription.type.colorHex))
                                
                                Text(String(format: "%.2f$", subscription.price))
                                    .font(.headline)
                                
                                Spacer()
                            }
                            
                        }
                    }.padding()
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(K.Colors.secondaryGray))
                                .shadow(color: Color(hex: subscription.type.colorHex).opacity(0.3) ,radius: 10, x: 0, y: 10)
                        }
                }.padding()
                Spacer()
            }
        }
        .navigationTitle("\(calendarViewModel.day), \(calendarViewModel.monthName(calendarViewModel.month)) \(formattedYear)")
    }
}

#Preview {
    NavigationView {
        DayDetails(date: Date(), subscriptions: [
            Subscription(name: "Test", price: 100, type:  FrequencyType(value: "Monthly", colorHex: Color.green.toHex()!),date: Date()),
            Subscription(name: "Test", price: 100, type:  FrequencyType(value: "Monthly", colorHex: Color.green.toHex()!), date: Date())
        ])
        .preferredColorScheme(.dark)
        .environment(CalendarViewModel(.now))
    }
}
