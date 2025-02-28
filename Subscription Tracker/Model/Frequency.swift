//
//  Frequency.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 01/12/2024.
//

import SwiftUI
import SwiftData

@Model
class Frequency {
    var id: UUID = UUID()
    var value: String
    private var colorHex: String
    var color: Color { Color(hex: colorHex) }
    
    @Relationship(deleteRule: .cascade, inverse: \Subscription.type)
    var subsciptions: [Subscription]?
    
    init(value: String, colorHex: String) {
        self.value = value
        self.colorHex = colorHex
    }
    
    static let defaultFrequencies: [Frequency] = [
        Frequency(value: "Yearly", colorHex: Color.purple.toHex()!),
        Frequency(value: "Monthly", colorHex: Color.green.toHex()!),
        Frequency(value: "Weekly", colorHex: Color.blue.toHex()!),
        Frequency(value: "Quarterly", colorHex: Color.orange.toHex()!)
    ]
    
}
