//
//  ItemsViewModel.swift
//  ToDoList
//
//  Created by admin on 12.01.2022.
//

import Foundation
import UIKit

class ItemsViewModel {

    var items: Observable<[ToDoItem]> = Observable([])
    let fileCache: FileCache

    init() {
        self.fileCache = FileCache.shared
        self.items = Observable(fileCache.getStorage())
        for item in items.value! {
            print(item)
        }
    }

    func getItemsCount() -> Int? {
        return items.value?.count
    }

    func getItemByIndexPath(_ indexPath: IndexPath) -> ToDoItem? {
        return items.value?[indexPath.row]
    }

    func getCellViewModelByItem(_ item: ToDoItem) -> CellViewModel {
        return CellViewModel(item: item)
    }

    func reWrite(_ items: [ToDoItem]) {
        DispatchQueue.global().async {
            FileCache.shared.writeStorageToFiles(items)
        }

    }

    func remove(_ item: ToDoItem) {
        items.value?.removeAll { $0.id == item.id }
    }

    func getHeight(by indexPath: IndexPath) -> CGFloat{
        let item = items.value![indexPath.row]

        if item.deadLine != nil {
            return 60
        } else {
            return 44
        }
    }
}
