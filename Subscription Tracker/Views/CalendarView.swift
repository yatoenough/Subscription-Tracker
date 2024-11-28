//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI

struct CalendarView: View {
    let daysList: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var body: some View {
        VStack {
            HStack {
                Text("Calendar")
                    .font(.title)
                Spacer()
                Text("Monthly total: $59.99")
            }
            HStack {
                HStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                    Text("Monthly")
                }
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                    Text("Yearly")
                }
                Spacer()
            }
            HStack {
                ForEach(daysList, id: \.self) { day in
                    Text(day).frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Calendar") {
                    print("Pressed")
                }
                
                Button("List") {
                    print("Pressed")
                }
            }
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("+") {
                    print("Pressed")
                }
            }
        }
        Spacer()
    }
}

#Preview {
    NavigationStack {
        CalendarView()
    }
}
