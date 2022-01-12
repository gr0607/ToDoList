//
//  Constants.swift
//  ToDoList
//
//  Created by admin on 12.01.2022.
//

import Foundation

enum Priority: String, CaseIterable {
    case hide, meduim, low

    var textFileName: String {
        switch self {
        case .hide:
            return "hide.txt"
        case .meduim:
            return "medium.txt"
        case .low:
            return "low.txt"
        }
    }
}

struct K {
    static let id = "id"
    static let text = "text"
    static let priority = "priority"
    static let deadLine = "deadLine"
}
