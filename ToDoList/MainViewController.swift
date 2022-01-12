//
//  ViewController.swift
//  ToDoList
//
//  Created by admin on 05.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    var storage = [String: ToDoItem]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fileCahe = FileCache()
        fileCahe.load()
        storage = fileCahe.storage

        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDelegate {

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var test = Array(storage.values)
        cell.textLabel?.text = test[indexPath.row].text

        return cell
    }
}
