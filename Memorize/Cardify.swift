//
//  Cardify.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/19.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    let isFaceUp: Bool
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            shape.strokeBorder(lineWidth: Constants.lineWidth)
                .background(shape.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            
            shape.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
