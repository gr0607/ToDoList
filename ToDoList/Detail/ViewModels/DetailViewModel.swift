//
//  DetailViewModel.swift
//  ToDoList
//
//  Created by admin on 18.01.2022.
//

import Foundation

class DetailViewModel {

    func createToDoItemWith(text: String, priority: Int) {
        var prior: Priority {
            switch priority {
            case 0:
                return .low
            case 1:
                return .meduim
            case 2:
                return .hide
            default:
                return .meduim
            }
        }

        let item = ToDoItem(text: text, priority: prior, deadLine: nil)

    }
}
