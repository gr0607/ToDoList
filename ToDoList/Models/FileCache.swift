//
//  FileCache.swift
//  ToDoList
//
//  Created by admin on 07.01.2022.
//

import Foundation

class FileCache {

    var storage = [String: ToDoItem]()

    func addItem(_ item: ToDoItem) {
        storage[item.id] = item
    }

    func removeItem(with id: String) {
        storage[id] = nil
    }

    func write() {
        for item in storage.values {
            switch item.priority {
            case .hide:
                writeToFile("hide.txt", item)
            case .meduim:
                writeToFile("medium.txt", item)
            case .low:
                writeToFile("low.txt", item)
            }
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

    func load() {
        let firstFile = getDocumentsDirectorty().appendingPathComponent("hide.txt")
        let secondFile = getDocumentsDirectorty().appendingPathComponent("medium.txt")
        let thirdFile = getDocumentsDirectorty().appendingPathComponent("low.txt")

        do {
            let dataOne = try Data(contentsOf: firstFile)
            let dataTwo = try Data(contentsOf: secondFile)
            let dataThree = try Data(contentsOf: thirdFile)

            guard let item = ToDoItem.parse(json: dataOne),
                  let item2 = ToDoItem.parse(json: dataTwo),
                  let item3 = ToDoItem.parse(json: dataThree) else { return }

            storage[item.id] = item
            storage[item2.id] = item2
            storage[item3.id] = item3

        } catch {

        }
    }
}
