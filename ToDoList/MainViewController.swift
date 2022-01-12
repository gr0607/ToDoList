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

        let fileCahe = FileCache()
        fileCahe.loadFromFiles()
       // storage = fileCahe.storage

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = itemsViewModel.getItemByIndexPath(indexPath)
        cell.textLabel?.text = item.text

        return cell
    }
}
