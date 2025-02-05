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
    
    private let subscriptionToEdit: Subscription?
    
    @State private var alertVisible = false
    @State private var subscriptionsFormViewModel: SubscriptionsFormViewModel
    
    @Environment(SubscriptionsViewModel.self) private var subscriptionsViewModel
    @Environment(\.dismiss) private var dismiss
    
    @Query private var frequencies: [Frequency]
    
    init(subscriptionToEdit: Subscription? = nil, subscriptionsFormViewModel: SubscriptionsFormViewModel) {
        self.subscriptionToEdit = subscriptionToEdit
        self.subscriptionsFormViewModel = subscriptionsFormViewModel
        self.subscriptionsFormViewModel.setSubscriptionToEdit(self.subscriptionToEdit)
    }
    
    var body: some View {
        
        return VStack {
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
                
                Button(subscriptionsFormViewModel.editMode ? "Edit Subscription" : "Add Subscription") {
                    let success = subscriptionsFormViewModel.saveSubscription()
                    
                    if !success {
                        alertVisible = true
                        return
                    }
                    
                    dismiss()
                }
            }
        }
        .navigationTitle(subscriptionsFormViewModel.editMode ? "Edit Subscription" : "Add Subscription")
        .navigationBarTitleDisplayMode(.large)
        .scrollContentBackground(.hidden)
        .background(Color.background)
        .alert(subscriptionsFormViewModel.errorMessage, isPresented: $alertVisible) {
            Button("OK", role: .cancel) { }
        }
    }
        
}

#Preview {
    let previewModelContainer = PreviewModelContainerProvider.provide(for: [Subscription.self, Frequency.self])
    
    DataPreview {
        SubscriptionForm(
            subscriptionToEdit: nil,
            subscriptionsFormViewModel: SubscriptionsFormViewModel(
                subscriptionsViewModel: SubscriptionsViewModel(
                    modelContext: ModelContext(previewModelContainer)
                )
            )
        )
    }
    
    
}
