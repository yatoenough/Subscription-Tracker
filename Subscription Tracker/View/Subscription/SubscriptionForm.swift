//
//  SubscriptionForm.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 11/12/2024.
//

import SwiftUI
import SwiftData

struct SubscriptionForm: View {
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    @State private var alertVisible = false
    
    @Environment(SubscriptionsViewModel.self) private var subscriptionsViewModel
    @Environment(SubscriptionsFormViewModel.self) private var subscriptionsFormViewModel
    @Environment(\.dismiss) private var dismiss
    
    @Query private var frequencies: [Frequency]
    
    var body: some View {
        @Bindable var subscriptionsFormViewModel = subscriptionsFormViewModel
        
        VStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("e.g. Spotify", text: $subscriptionsFormViewModel.name)
                }
                
                Section(header: Text("Date & Payment")) {
                    DatePicker("Select Date", selection: $subscriptionsFormViewModel.date, displayedComponents: .date)
                    Picker("Payment Frequency", selection: $subscriptionsFormViewModel.frequency) {
                        ForEach(frequencies, id: \.self) { type in
                            Text(type.value.capitalized)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    HStack {
                        Text("$")
                        TextField("0.00", value: $subscriptionsFormViewModel.amount, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button("Add Subscription") {
                    let success = subscriptionsFormViewModel.saveSubscription()
                    
                    if !success {
                        alertVisible = true
                        return
                    }
                    
                    dismiss()
                }
            }
        }
        .navigationTitle("Add Subscription")
        .navigationBarTitleDisplayMode(.large)
        .scrollContentBackground(.hidden)
        .background(Color.background)
        .alert(subscriptionsFormViewModel.errorMessage, isPresented: $alertVisible) {
            Button("OK", role: .cancel) { }
        }
    }
        
}

#Preview {
    DataPreview {
        SubscriptionForm()
    }
    
}
