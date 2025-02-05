//
//  PreviewModelContainerProvider.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 06/02/2025.
//

import SwiftData

struct PreviewModelContainerProvider {
    static func provide(for models: [any PersistentModel.Type]) -> ModelContainer {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let modelContainer = try! ModelContainer(for: Schema(models), configurations: configuration)
            
            return modelContainer
        }
}
