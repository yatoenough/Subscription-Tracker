//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 11/12/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedView = 0
    
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            TabView(selection: $selectedView) {
                CalendarView()
                    .tag(0)
                
                #warning("Implement list view")
                Text("List")
                    .tag(1)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                CustomTabViewItem(text: "Calendar", isSelected: determineSelectedView(currentIndex: selectedView, viewIndex: 0)) {
                    selectedView = 0
                }
                
                CustomTabViewItem(text: "List", isSelected: determineSelectedView(currentIndex: selectedView, viewIndex: 1)) {
                    selectedView = 1
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                NavigationLink(destination: AddSubscriptionForm()) {
                    Text("+")
                        .font(.title)
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    private func determineSelectedView(currentIndex: Int, viewIndex: Int) -> Bool {
        currentIndex == viewIndex
    }
    
}

#Preview {
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
        ContentView()
    }
    .preferredColorScheme(.dark)
    .modelContainer(container)
    .environment(SubscriptionsViewModel(modelContext: container.mainContext))
    .environment(CalendarViewModel(.now))
}
