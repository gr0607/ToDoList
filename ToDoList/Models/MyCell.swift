//
//  MyCell.swift
//  ToDoList
//
//  Created by admin on 12.01.2022.
//

import UIKit

class MyCell: UITableViewCell {
    static let id = "MyCell"

    @IBOutlet weak var mainTextLabel: UILabel!

    func configureWithCellViewMode(_ cellViewModel: CellViewModel) {
        self.accessoryType = .disclosureIndicator
        mainTextLabel.attributedText = cellViewModel.mainText
    }
}
