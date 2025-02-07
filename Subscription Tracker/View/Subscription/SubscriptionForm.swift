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
    
    private var subscriptionToEdit: Subscription?
    
    private var editMode: Bool {
        subscriptionToEdit != nil
    }
    
    @State private var subscription: Subscription = Subscription(name: "", price: 0, type: Frequency.defaultFrequencies[0], date: .now)
    @State private var alertVisible = false
    @State private var errorMessage: String = ""
    
    @Environment(SubscriptionsViewModel.self) private var subscriptionsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @Query private var frequencies: [Frequency]
    
    init(subscriptionToEdit: Subscription? = nil) {
        self.subscriptionToEdit = subscriptionToEdit
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("e.g. Spotify", text: $subscription.name)
                }
                
                Section(header: Text("Date & Payment")) {
                    DatePicker("Select Date", selection: $subscription.date, displayedComponents: .date)
                    Picker("Payment Frequency", selection: $subscription.type) {
                        ForEach(frequencies, id: \.self) { type in
                            Text(type.value.capitalized)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    HStack {
                        Text("$")
                        TextField("0.00", value: $subscription.price, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button(editMode ? "Edit Subscription" : "Add Subscription") {
                    let success = saveSubscription()
                    
                    if !success {
                        alertVisible = true
                        return
                    }
                    
                    dismiss()
                }
            }
        }
        .navigationTitle(editMode ? "Edit Subscription" : "Add Subscription")
        .navigationBarTitleDisplayMode(.large)
        .scrollContentBackground(.hidden)
        .background(Color.background)
        .onAppear {
            subscription.type = frequencies.first!
            if let subscriptionToEdit {
                self.subscription = subscriptionToEdit
            }
        }
        .alert(errorMessage, isPresented: $alertVisible) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func saveSubscription() -> Bool {
        guard validateData() else { return false }
        
        if let subscriptionToEdit {
            subscriptionsViewModel.editSubscription(id: subscriptionToEdit.id, subscription)
        } else if subscriptionToEdit == nil {
            subscriptionsViewModel.addSubscription(subscription)
        }
        
        return true
    }

    private func validateData() -> Bool {
        if subscription.name.isEmpty {
            errorMessage = "Name is required"
            return false
        }
        
        if subscription.price <= 0 {
            errorMessage = "Amount must be positive and not zero"
            return false
        }
        
        return true
    }
        
}

#Preview {
    DataPreview {
        SubscriptionForm(subscriptionToEdit: nil)
    }
}
