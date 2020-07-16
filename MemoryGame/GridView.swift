//
//  GridView.swift
//  MemoryGame
//
//  Created by Muchen He on 2020-07-16.
//  Copyright © 2020 Muchen He. All rights reserved.
//

import SwiftUI

// This is a generic grid view
// So we are templating "Item" and "ItemView", where
// "Item" is the type of the data and
// "ItemView" is a function that returns the view of the item (such as VStack, etc)

// To be used in ForEach, the "Item" type must be "Identifiable"
// Also for body to return a View, ItemView must be a "View"
// Here we're using protocols to constrain the "don't care" template types
struct GridView<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var itemsView: (Item) -> ItemView
    
    // We need to add this @escaping because we passed in a function
    // that's only called later
    init(_ items: [Item], itemsView: @escaping (Item) -> ItemView) {
        self.items = items
        self.itemsView = itemsView
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridViewLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    func body(for layout: GridViewLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    func body(for item: Item, in layout: GridViewLayout) -> some View {
        
        let index = self.getIndex(of: item)
        
        // For each item, we can access gridlayout's itemSize property
        // to get the item size, and calling frame() allow us to resize it
        itemsView(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
    func getIndex(of item: Item) -> Int {
        for index in 0..<items.count {
            if items[index].id == item.id {
                return index
            }
        }
        
        // FIXME
        return -1
    }
}
