//
//  Task.swift
//  WorkList
//
//  Created by CuongVX-D1 on 6/26/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import Foundation

struct DayTask {
    var sectionTitle: String
    var task: [Task]
}

struct Task {
    let id: String
    var isDone: Bool
    var todo: String
    var description: String
    let timeInterval: Double
<<<<<<< HEAD
=======
    
    init(item: (key: String, value: Any)) {
        let id = item.key
        let arrayValue = item.value as? [String : Any] ?? [:]
        let isDone = arrayValue["isDone"] as? Bool ?? false
        let todo = arrayValue["todo"] as? String ?? ""
        let description = arrayValue["description"] as? String ?? ""
        let timeInterval = arrayValue["timeInterval"] as? Double ?? 0
        
        self.id = id
        self.isDone = isDone
        self.todo = todo
        self.description = description
        self.timeInterval = timeInterval
    }
    
    func setupNotification() {
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second],
                                                             from: date)
        let triggerTime = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = todo
        content.body  = description
        content.sound = UNNotificationSound.default
        let requets = UNNotificationRequest(identifier: id, content: content, trigger: triggerTime)
        UNUserNotificationCenter.current().add(requets, withCompletionHandler: nil)
    }
>>>>>>> Complete Push Pull FireBase
}
