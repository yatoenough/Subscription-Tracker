//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI

struct CalendarScreenView: View {
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Divider()
                        .foregroundStyle(Color(K.Colors.secondaryGray))
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
                        .foregroundStyle(Color(K.Colors.secondaryText))
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
        CalendarScreenView()
    }.preferredColorScheme(.dark)
}
