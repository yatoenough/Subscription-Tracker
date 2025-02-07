//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 11/12/2024.
//

import SwiftUI
import SwiftData

enum Tab: String {
    case calendar
    case list
}

struct ContentView: View {
    @State private var selectedTab: Tab = .calendar
    
    @Environment(SubscriptionsViewModel.self) private var subscriptionsViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarScreen()
                .tag(Tab.calendar)
            
            #warning("Implement list view")
            Text("List")
                .tag(Tab.list)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.background)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                CustomTabItem(text: "Calendar", isSelected: determineSelectedView(currentTab: selectedTab, tab: .calendar)) {
                    selectedTab = .calendar
                }
                
                CustomTabItem(text: "List", isSelected: determineSelectedView(currentTab: selectedTab, tab: .list)) {
                    selectedTab = .list
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                NavigationLink(destination: SubscriptionForm(subscriptionToEdit: nil)) {
                    Text("+")
                        .font(.title)
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    private func determineSelectedView(currentTab: Tab, tab: Tab) -> Bool { currentTab == tab }
    
}

#Preview {
    DataPreview {
        ContentView()
    }
}
