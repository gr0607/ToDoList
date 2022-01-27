//
//  DetailViewController.swift
//  ToDoList
//
//  Created by admin on 17.01.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var viewModel = DetailViewModel()
    var item: ToDoItem?

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var deadLineSwitch: UISwitch!
    @IBOutlet weak var deadLineDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = item {
            viewModel.configureDetailWithItem(item, self)
        }

        deadLineSwitch.addTarget(self, action: #selector(showDate), for: .allEvents)
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        var date: Date?

        if deadLineSwitch.isOn {
            date = deadLineDatePicker.date
        }

        guard let text = itemTextField.text else { return }
        let priority = prioritySegmentedControl.selectedSegmentIndex

        if let item = item {
            viewModel.update(item: item, with: text, priority: priority, date: date)
        } else {
            viewModel.createToDoItemWith(text: text, priority: priority, date: date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        guard let item = item else { return }
        viewModel.delete(item: item)
        self.navigationController?.popViewController(animated: true)
    }

    @objc func showDate() {
        if deadLineSwitch.isOn {
            deadLineDatePicker.isHidden = false
        } else {
            deadLineDatePicker.isHidden = true
        }
    }
}
