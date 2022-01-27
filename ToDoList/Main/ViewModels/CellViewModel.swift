//
//  CellViewModel.swift
//  ToDoList
//
//  Created by admin on 12.01.2022.
//

import Foundation
import UIKit

class CellViewModel {
    let item: ToDoItem

    init(item: ToDoItem) {
        self.item = item
    }

    var mainText: NSMutableAttributedString {
        let fullString = NSMutableAttributedString()
        let imageAttachments = NSTextAttachment()

        switch item.priority {
        case .hide:
            imageAttachments.image = UIImage(systemName: "arrow.up")
            imageAttachments.image =
                imageAttachments.image?.withTintColor(UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1.00))

            let imageString = NSAttributedString(attachment: imageAttachments)

            fullString.append(imageString)
            fullString.append(imageString)
            fullString.append(NSAttributedString(string: item.text))
            return fullString
        case .meduim:
            fullString.append(NSAttributedString(string: item.text))
            return fullString
        case .low:
            imageAttachments.image = UIImage(systemName: "arrow.down")
            imageAttachments.image =
                imageAttachments.image?.withTintColor(UIColor(red: 1.00, green: 1.00, blue: 0.00, alpha: 1.00))

            let imageStrng = NSAttributedString(attachment: imageAttachments)

            fullString.append(imageStrng)
            fullString.append(NSAttributedString(string: item.text))

            return fullString
        }
    }

    var deadLine: String? {
        guard  let date = item.deadLine else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"

        let dateString = formatter.string(from: date)

        return "DeadLine: \(dateString)"
    }
}

