//
//  Array+Extensions.swift
//  Memorize
//
//  Created by Elias Santa Rosa on 29/07/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {

    /// Returns the first index from a Array with Identifiable <Element> or returns nil
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        
        return nil
    }

}

extension Array {
    /// Returns the unique <Element> in Array or returns nil
    var only: Element? {
        count == 1 ? first : nil
    }
 }
