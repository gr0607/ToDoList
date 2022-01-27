//
//  DetailViewModel.swift
//  ToDoList
//
//  Created by admin on 18.01.2022.
//

import Foundation
import UIKit

class DetailViewModel {

    var itemsViewModel: ItemsViewModel?

    func createToDoItemWith(text: String, priority: Int, date: Date?) {
        let prior = convertPriority(number: priority)

        let item = ToDoItem(text: text, priority: prior, deadLine: date)

        self.itemsViewModel?.items.value?.append(item)
    }

    func configureDetailWithItem(_ item: ToDoItem, _ detailVC: DetailViewController) {
        detailVC.itemTextField.text = item.text
        detailVC.prioritySegmentedControl.selectedSegmentIndex = convertPriorityReverse(priority: item.priority)
        detailVC.removeButton.isEnabled = true
        detailVC.removeButton.isHighlighted = false

        if item.deadLine != nil {
            detailVC.deadLineSwitch.isOn = true
            detailVC.deadLineDatePicker.date = item.deadLine!
            detailVC.deadLineDatePicker.isHidden = false
        }
    }

    func update(item: ToDoItem, with text: String, priority: Int, date: Date?) {
        if item.text != text
            || item.priority != convertPriority(number: priority)
            || item.deadLine != date {
            let id = item.id
            itemsViewModel?.remove(item)
            let prior = convertPriority(number: priority)

            let item = ToDoItem(id: id, text: text, priority: prior, deadLine: date)
            self.itemsViewModel?.items.value?.append(item)
        }
    }

    func delete(item: ToDoItem) {
        itemsViewModel?.remove(item)
    }

    func convertPriority(number: Int) -> Priority {
        switch number {
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

    func convertPriorityReverse(priority: Priority) -> Int {
        switch priority {
        case .hide:
            return 2
        case .meduim:
            return 1
        case .low:
            return 0
        }
    }
}
