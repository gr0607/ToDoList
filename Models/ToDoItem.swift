//
//  ToDoItem.swift
//  ToDoList
//
//  Created by admin on 06.01.2022.
//

import Foundation

enum Priority: String {
    case hide, meduim, low
}

struct ToDoItem {
    let id: String
    let text: String
    let priority: Priority
    let deadLine: Date?

    init(id: String, text: String, priority: Priority, deadLine: Date?) {
        self.id = id
        self.text = text
        self.priority = priority
        self.deadLine = deadLine
    }

     init (text: String, priority: Priority, deadLine: Date?) {
        self.init(id: UUID().uuidString, text: text, priority: priority, deadLine: deadLine)
    }
}

extension ToDoItem {
    var json: Any {
        var dictionary = [String: Any]()
        dictionary["id"] = self.id
        dictionary["text"] = self.text

        switch priority {
        case .hide, .low:
                dictionary["priority"] = self.priority.rawValue
        case .meduim:
                break
            }
        
        if let deadLine = deadLine {
            dictionary["deadLine"] = Double(deadLine.timeIntervalSince1970)
        }

        return dictionary
    }

    static func parse(json: Any) -> ToDoItem? {
        guard let data = json as? Data,
              let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return nil
                }

        guard let id = json["id"] as? String,
              let text = json["text"] as? String
                else {
            return nil
        }

        var myDate: Date?
        var priority: Priority?

        if let date = json["deadLine"] as? Double {
            myDate = Date(timeIntervalSince1970: TimeInterval(date))
        }

        if let priorityRawValue = json["priority"] as? String {
            priority = Priority(rawValue: priorityRawValue)
        }

        return ToDoItem(id: id, text: text, priority: priority ?? .meduim, deadLine: myDate)
    }
}
