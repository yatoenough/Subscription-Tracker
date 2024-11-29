//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Divider()
                        .foregroundStyle(Color("PrimaryGray"))
                    MonthInfo(month: 11, year: 2024, total: 23.45)
                        .padding(.top)
                    HStack {
                        CalendarTrait(color: .purple, text: "Monthly")
                        CalendarTrait(color: .red, text: "Yearly")
                        Spacer()
                    }
                    CalendarView()
                        .padding(.vertical)
                }
                .padding()
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        Button("Calendar") {
                            print("Pressed")
                        }
                        .foregroundStyle(.white)
                        .font(.title2)
                        
                        Button("List") {
                            print("Pressed")
                        }
                        .foregroundStyle(Color("InactiveText"))
                        .font(.title2)
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button(action: {
                            print("Pressed")
                        }, label: {
                            Text("+")
                                .font(.title)
                                .foregroundStyle(.white)
                        })
                        
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
