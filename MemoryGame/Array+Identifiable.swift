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

extension Array where Element: Identifiable {
    func indexOf(matching: Element) -> Int {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        
        // FIXME
        return -1
    }
}
