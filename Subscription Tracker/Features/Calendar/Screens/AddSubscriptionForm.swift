//
//  AddSubscriptionForm.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 11/12/2024.
//

import SwiftUI

struct AddSubscriptionForm: View {
    @State private var name: String = ""
    
    @State private var date: Date = Date()
    @State private var amount: Double = 0
    
    private var subscriptionTypes: [SubscriptionType] {
        var types: [SubscriptionType] = []
        for type in DefaultSubscriptionTypes.allCases {
            let typeValue = type.getValue()
            types.append(typeValue)
        }
        return types
    }
    @State private var frequency: SubscriptionType = DefaultSubscriptionTypes.monthly.getValue()
    
    var body: some View {
        
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            Form {
                
                Section(header: Text("Name")) {
                    TextField("e.g. Spotify", text: $name)
                }
                
                Section(header: Text("Date & Payment")) {
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                    Picker("Payment Frequency", selection: $frequency) {
                        ForEach(subscriptionTypes, id: \.self) { type in
                            Text(type.value.capitalized)
                                .tag(type)
                        }
                    }
                    TextField("e.g. 12.99", value: $amount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Subscription")
            .scrollContentBackground(.hidden)
        }
    }
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$" // Adjust for desired currency
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    NavigationView {
        AddSubscriptionForm()
    }.preferredColorScheme(.dark)
    
}
