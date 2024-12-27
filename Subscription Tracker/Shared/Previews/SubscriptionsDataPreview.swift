//
//  SubscriptionsDataPreview.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 27/12/2024.
//

import SwiftUI
import SwiftData

struct SubscriptionsDataPreview<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Subscription.self, FrequencyType.self, configurations: config)
        
        let defaultTypes: [FrequencyType] = [
            FrequencyType(value: "Yearly", colorHex: Color.purple.toHex()!),
            FrequencyType(value: "Monthly", colorHex: Color.green.toHex()!),
            FrequencyType(value: "Weekly", colorHex: Color.blue.toHex()!),
            FrequencyType(value: "Quarterly", colorHex: Color.orange.toHex()!),
        ]
        
        for type in defaultTypes {
            container.mainContext.insert(type)
        }
        
        return NavigationStack {
            content
        }
        .preferredColorScheme(.dark)
        .modelContainer(container)
        .environment(SubscriptionsViewModel(modelContext: container.mainContext))
        .environment(CalendarViewModel(.now))
    }
}
