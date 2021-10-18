//
//  Sequence-Sorting.swift
//  PortfolioApp
//
//  Created by Rohini Vaidya on 30/05/21.
//

import Foundation

extension Sequence {
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted {
            $0[keyPath: keyPath] < $1[keyPath: keyPath]
        }
    }
}
