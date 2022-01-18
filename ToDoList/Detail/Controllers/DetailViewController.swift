//
//  DetailViewController.swift
//  ToDoList
//
//  Created by admin on 17.01.2022.
//

import UIKit

class DetailViewController: UIViewController {

    private var viewModel = DetailViewModel()

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let text = itemTextField.text else { return }
        let priority = prioritySegmentedControl.selectedSegmentIndex

        viewModel.createToDoItemWith(text: text, priority: priority)
    }
}
