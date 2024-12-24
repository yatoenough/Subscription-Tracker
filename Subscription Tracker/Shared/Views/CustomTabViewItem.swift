//
//  CustomTabViewItem.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 24/12/2024.
//

import SwiftUI

struct CustomTabViewItem: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(text) {
            action()
        }
        .foregroundStyle(isSelected ? .white : Color(K.Colors.secondaryText))
        .font(.title2)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CustomTabViewItem(text: "Calendar", isSelected: true) {
        print("")
    }
        .preferredColorScheme(.dark)
        .padding()
}
