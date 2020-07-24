//
//  Array+Identifiable.swift
//  MemoryGame
//
//  Created by Muchen He on 2020-07-16.
//  Copyright © 2020 Muchen He. All rights reserved.
//

import Foundation

// This extends the Array such that we can invoke "firstIndex"
// to retrieve the first index of a matching element

// Note that the protocol constrains only makes this extension available
// for Array Don't-Care Element type that complies with Identifiable protocol
extension Array where Element: Identifiable {
    func indexOf(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }

        return nil
    }
}
