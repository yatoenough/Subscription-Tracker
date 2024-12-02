//
//  ContentView.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 28/11/2024.
//

import SwiftUI

struct CalendarScreenView: View {
    let currentDate = Date()
    let calendar = Calendar.current
    
    var year: Int { calendar.component(.year, from: currentDate) }
    var month: Int { calendar.component(.month, from: currentDate) }
    var day: Int { calendar.component(.day, from: currentDate) }
    
    @Environment(SubscriptionsViewModel.self) var subsViewModel: SubscriptionsViewModel
    
    var body: some View {
        ZStack {
            Color(K.Colors.background)
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Divider()
                        .foregroundStyle(Color(K.Colors.secondaryGray))
                    MonthInfo(month: month, year: year, total: 23.45)
                        .padding(.vertical)
                    Divider()
                        .foregroundStyle(Color(K.Colors.secondaryGray))
                    HStack {
                        ForEach(SubscriptionTypes.allCases, id: \.self) { enumCase in
                            let type = enumCase.getType()
                            CalendarTrait(color: type.color, text: type.value)
                            Spacer()
                        }
                        Spacer()
                    }.padding(.vertical)
                    CalendarView(month: 10, year: 2024)
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
                            subsViewModel.addSamples()
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
