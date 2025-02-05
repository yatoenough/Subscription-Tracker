//
//  DataPreview.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 05/02/2025.
//


import SwiftUI
import SwiftData

struct DataPreview<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    private var modelContext: ModelContext { ModelContext(previewContainer) }
    private let previewContainer: ModelContainer = {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Subscription.self, Frequency.self, configurations: config)
        
        for type in Frequency.defaultFrequencies {
            container.mainContext.insert(type)
        }
        
        return container
    }()
    
    private var subscriptionViewModel: SubscriptionsViewModel {
        SubscriptionsViewModel(modelContext: modelContext)
    }
    
    private var subscriptionsFormViewModel: SubscriptionsFormViewModel {
        .init(subscriptionsViewModel: subscriptionViewModel)
    }
    
    var body: some View {
        NavigationStack {
            content
        }
        .preferredColorScheme(.dark)
        .modelContainer(previewContainer)
        .environment(subscriptionViewModel)
        .environment(subscriptionsFormViewModel)
        .environment(CalendarViewModel(.now))
    }
}
