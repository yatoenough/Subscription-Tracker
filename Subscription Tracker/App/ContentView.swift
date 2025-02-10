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
    
    @AppStorage("selectedTab") private var storedSelectedTab: String = "calendar"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            CalendarScreen()
                .tag(Tab.calendar)
            
            ListScreen()
                .tag(Tab.list)
        }
        .onAppear {
            selectedTab = Tab(rawValue: storedSelectedTab) ?? .calendar
        }
        .onChange(of: selectedTab) { _, newValue in
            storedSelectedTab = newValue.rawValue
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.background)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                CustomTabItem(text: "Calendar", isSelected: determineSelectedView(currentTab: selectedTab, tab: .calendar)) {
                    withAnimation {
                        selectedTab = .calendar
                    }
                }
                
                CustomTabItem(text: "List", isSelected: determineSelectedView(currentTab: selectedTab, tab: .list)) {
                    withAnimation {
                        selectedTab = .list
                    }
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                NavigationLink(destination: SubscriptionForm()) {
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
