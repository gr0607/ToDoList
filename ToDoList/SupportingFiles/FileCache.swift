//
//  FileCache.swift
//  ToDoList
//
//  Created by admin on 07.01.2022.
//

import Foundation

class FileCache {

    static let shared = FileCache()

    private var storage = [String: ToDoItem]()

    private init() {
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
        var medium = [ToDoItem]()
        var hide = [ToDoItem]()
        var low = [ToDoItem]()

        for item in storage.values {
            switch item.priority {
            case .hide:
                hide.append(item)
            case .meduim:
                medium.append(item)
            case .low:
                low.append(item)
            }
        }
        writeToFile(Priority.hide.textFileName, hide)
        writeToFile(Priority.meduim.textFileName, medium)
        writeToFile(Priority.low.textFileName, low)
    }

    func writeToFile(_ fileName: String, _ items: [ToDoItem]) {
        let fileName = getDocumentsDirectorty().appendingPathComponent(fileName)
        do {
            var data = Data()

            for item in items {
                data.append((item.json as? Data)!)
                var str = "\n"
                data.append(str.data(using: .utf8)!)
            }

            try data.write(to: fileName, options: [.atomicWrite])

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
        print(path)
        do {
            let data = try Data(contentsOf: path)
            guard let items = ToDoItem.parse(json: data) else { return }

            for item in items {
                storage[item.id] = item
            }



        } catch {
            print(error)
        }
    }
}
