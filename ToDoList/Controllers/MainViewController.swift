//
//  ViewController.swift
//  ToDoList
//
//  Created by admin on 05.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    var itemsViewModel = ItemsViewModel()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: MyCell.id, bundle: nil), forCellReuseIdentifier: MyCell.id)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate {

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsViewModel.getItemsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.id, for: indexPath) as? MyCell else {
            return UITableViewCell()
        }

        let item = itemsViewModel.getItemByIndexPath(indexPath)
        let cellViewModel = itemsViewModel.getCellViewModelByItem(item)
        cell.configureWithCellViewMode(cellViewModel)

        return cell
    }
}
