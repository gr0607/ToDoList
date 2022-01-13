//
//  FileCache.swift
//  ToDoList
//
//  Created by admin on 07.01.2022.
//

import Foundation

class FileCache {

    private var storage = [String: ToDoItem]()

    init() {
        loadFromFiles()
    }

    func getStorage() -> [ToDoItem] {
        return Array(storage.values)
    }

    func addItem(_ item: ToDoItem) {
        storage[item.id] = item
    }

    func removeItem(with id: String) {
        storage[id] = nil
    }

    func writeStorageToFiles() {
        for item in storage.values {
            writeToFile(item.priority.textFileName, item)
        }
    }

    func writeToFile(_ fileName: String, _ item: ToDoItem) {
        let fileName = getDocumentsDirectorty().appendingPathComponent(fileName)
        print(fileName)
        do {
            guard let data = item.json as? Data else { return }
            try data.write(to: fileName, options: [])
        } catch {
            print(error)
        }
    }

    func getDocumentsDirectorty() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func loadFromFiles() {
        for type in Priority.allCases {
            loadFromOneFile(type.textFileName)
        }
    }

    func loadFromOneFile(_ fileName: String) {
        let path = getDocumentsDirectorty().appendingPathComponent(fileName)

        do {
            let data = try Data(contentsOf: path)

            guard let item = ToDoItem.parse(json: data) else { return }

            storage[item.id] = item

        } catch {
            print(error)
        }
    }
}
