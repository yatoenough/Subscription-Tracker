//
//  SubscriptionsViewModel.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 02/12/2024.
//

import Foundation
import SwiftData

@Observable
@MainActor
class SubscriptionsViewModel {
    var modelContext: ModelContext
    
    init (modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addSamples() {
        modelContext.insert(Subscription(id: 1, name: "Test", price: 100, date: Date()))
    }
}
