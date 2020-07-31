//
//  Grid.swift
//  Memorize
//
//  Created by Elias Santa Rosa on 29/07/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }

}
