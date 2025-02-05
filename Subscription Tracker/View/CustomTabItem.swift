//
//  CustomTabItem.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 24/12/2024.
//

import SwiftUI

struct CustomTabItem: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(text, action: action)
        .foregroundStyle(isSelected ? .white : .secondaryText)
        .font(.title2)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CustomTabItem(text: "Calendar", isSelected: true) {
        print("")
    }
        .preferredColorScheme(.dark)
        .padding()
}
