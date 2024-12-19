//
//  AddSubscriptionForm.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 11/12/2024.
//

import SwiftUI
import SwiftData

struct AddSubscriptionForm: View {
    @State private var name: String = ""
    
    @State private var date: Date = Date()
    @State private var amount: Double?
    
    private var subscriptionTypes: [SubscriptionType] {
        var types: [SubscriptionType] = []
        for type in DefaultSubscriptionTypes.allCases {
            let typeValue = type.getValue()
            types.append(typeValue)
        }
        return types
    }
    
    @State private var frequency: SubscriptionType = DefaultSubscriptionTypes.monthly.getValue()
    @State private var alertVisible = false
    
    @Environment(SubscriptionsViewModel.self) var subscriptionsViewModel: SubscriptionsViewModel
    
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
                    .pickerStyle(.segmented)
                    HStack {
                        Text("$")
                        
                        TextField("0.00", value: $amount, formatter: numberFormatter())
                            .keyboardType(.decimalPad)
                    }
                }
                
                Button("Add Subscription") { addSubscription() }
                #warning("Fix keyboard dismiss")
            }
//            .onTapGesture {
//                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//            }
            .navigationTitle("Add Subscription")
            .scrollContentBackground(.hidden)
        }
        .alert("Validation Error", isPresented: $alertVisible) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func addSubscription() {
        let isDataValid = validateData()
        
        if !isDataValid {
            alertVisible = true
            return
        }
        
        let subscription = Subscription(name: name, price: amount!, type: frequency, date: date)
        subscriptionsViewModel.addSubscription(subscription)
    }
    
    private func numberFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private func validateData() -> Bool {
        guard amount != nil else { return false }
        guard !name.isEmpty else { return false }
        
        return true
    }
    
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Subscription.self, SubscriptionType.self, configurations: config)
    
    NavigationView {
        AddSubscriptionForm()
    }
    .preferredColorScheme(.dark)
    .modelContainer(container)
    .environment(SubscriptionsViewModel(modelContext: container.mainContext))
    
}
