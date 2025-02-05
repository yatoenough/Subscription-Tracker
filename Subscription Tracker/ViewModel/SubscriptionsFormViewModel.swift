//
//  SubscriptionsFormViewModel.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 05/02/2025.
//

import Foundation
import SwiftData

@Observable
class SubscriptionsFormViewModel {
    var name: String = ""
    var date: Date = .now
    var amount: Double?
    var frequency: Frequency = .defaultFrequencies.first!
    
    var errorMessage: String = ""
    
    private let subscriptionsViewModel: SubscriptionsViewModel
    
    init(subscriptionsViewModel: SubscriptionsViewModel) {
        self.subscriptionsViewModel = subscriptionsViewModel
    }
    
    func saveSubscription() {
        guard validateData() else { return }
        
        let subscription = Subscription(
            name: name,
            price: amount!,
            type: frequency,
            date: date
        )
        
        subscriptionsViewModel.addSubscription(subscription)
        
        resetForm()
    }
    
    private func resetForm() {
        name = ""
        date = .now
        amount = nil
        frequency = .defaultFrequencies.first!
        errorMessage = ""
    }

    private func validateData() -> Bool {
        if name.isEmpty {
            errorMessage = "Name is required"
            return false
        }
        
        guard let amount else { return false }
        if amount <= 0 {
            errorMessage = "Amount must be positive and greater than zero"
            return false
        }
        
        return true
    }
    
}
