//
//  NotificationManager.swift
//  Subscription Tracker
//
//  Created by Nikita Shyshkin on 19/02/2025.
//

import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error {
                print("Error requesting authorization: \(error)")
            } else {
                print("success")
            }
        }
    }
    
    func scheduleNotification(identifier: String, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        UNUserNotificationCenter.current().add(UNNotificationRequest(identifier: identifier, content: content, trigger: trigger))
    }
}
