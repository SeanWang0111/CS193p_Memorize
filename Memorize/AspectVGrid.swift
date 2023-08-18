//
//  AspectVGrid.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/18.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    
    var items: [Item]
    var aspectRatio: CGFloat = 1.0
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.content = content
        self.items = items
        self.aspectRatio = aspectRatio
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWithThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func gridItemWithThatFits(count: Int,
                                      size: CGSize,
                                      atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let count: CGFloat = CGFloat(count)
        var columnCount: Double = 1.0
        
        repeat {
            let width: Double = size.width / columnCount
            let height: Double = width / aspectRatio
            let rowCount: Double = (count / columnCount).rounded(.up)
            
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
