//
//  MyCellWithDate.swift
//  ToDoList
//
//  Created by admin on 23.01.2022.
//

import UIKit

class MyCellWithDate: UITableViewCell {

    static let id = "MyCellWithDate"

    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var deadLine: UILabel!

    func configureWithCellViewMode(_ cellViewModel: CellViewModel) {
        self.accessoryType = .disclosureIndicator
        mainText.attributedText = cellViewModel.mainText
        deadLine.text = cellViewModel.deadLine
    }
}
