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
    
    private var previewContainer: ModelContainer {
        let container = PreviewModelContainerProvider.provide(for: [Subscription.self, Frequency.self])
        
        for type in Frequency.defaultFrequencies {
            container.mainContext.insert(type)
        }
        
        return container
    }
    
    private var modelContext: ModelContext { ModelContext(previewContainer) }
    
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
