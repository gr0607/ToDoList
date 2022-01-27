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
        tableView.register(UINib(nibName: MyCellWithDate.id, bundle: nil), forCellReuseIdentifier: MyCellWithDate.id)
        tableView.delegate = self
        tableView.dataSource = self

        itemsViewModel.items.bind { [weak self] items in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            self?.itemsViewModel.reWrite(items!)
        }

    }

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? DetailViewController else { return }
        vc.viewModel.itemsViewModel = self.itemsViewModel
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {
            return
        }
        let item = itemsViewModel.getItemByIndexPath(indexPath)
        vc.item = item
        vc.viewModel.itemsViewModel = self.itemsViewModel
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemsViewModel.getHeight(by: indexPath)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsViewModel.getItemsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        guard let item = itemsViewModel.getItemByIndexPath(indexPath) else { return UITableViewCell()}
        let cellViewModel = itemsViewModel.getCellViewModelByItem(item)

        switch item.deadLine {
        case .none:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCell.id, for: indexPath) as? MyCell else {
                return UITableViewCell() }
                cell.configureWithCellViewMode(cellViewModel)
                return cell
        case .some(_):
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyCellWithDate.id, for: indexPath) as? MyCellWithDate else {
            return UITableViewCell() }
            cell.configureWithCellViewMode(cellViewModel)
            return cell
        }

        

        return UITableViewCell()
    }
}
