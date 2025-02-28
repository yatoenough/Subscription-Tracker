//
//  NotificationManager.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 19/02/2025.
//

import UserNotifications

enum NotificationFrequency {
    case weekly
    case monthly
    case yearly
    case daily
}

class NotificationManager {
    static let instance = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { _, error in
            if let error {
                print("Error requesting authorization: \(error)")
            } else {
                print("success")
            }
        }
    }
    
    func scheduleNotification(frequency: NotificationFrequency, identifier: String, title: String, body: String, date: Date, repeats: Bool) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1
        
        var components: Set<Calendar.Component> = []
        
        switch frequency {
        case .weekly:
            components = [.weekday]
        case .monthly:
            components = [.day]
        case .yearly:
            components = [.month, .day]
        case .daily:
            components = [.hour, .minute]
        }
        
        var triggerDateComponents = Calendar.current.dateComponents(components, from: date)
        
        triggerDateComponents.hour = 12
        triggerDateComponents.minute = 0
        triggerDateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: repeats)
        
        UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: identifier, content: content, trigger: trigger))
    }
    
    func deleteNotification(identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
