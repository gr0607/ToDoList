//
//  ItemsViewModel.swift
//  ToDoList
//
//  Created by admin on 12.01.2022.
//

import Foundation

class ItemsViewModel {
    var items: [ToDoItem]
    let fileCache: FileCache

    init() {
        self.fileCache = FileCache()
        self.items = fileCache.getStorage()
    }

    func getItemsCount() -> Int {
        return items.count
    }

    func getItemByIndexPath(_ indexPath: IndexPath) -> ToDoItem {
        return items[indexPath.row]
    }

    func getCellViewModelByItem(_ item: ToDoItem) -> CellViewModel {
        return CellViewModel(item: item)
    }
}
