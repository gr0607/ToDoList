//
//  Observable.swift
//  ToDoList
//
//  Created by admin on 19.01.2022.
//

import Foundation
import UIKit

class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T?) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
