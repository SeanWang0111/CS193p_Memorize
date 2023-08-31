//
//  Cardify.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/19.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    private var isFaceUp: Bool { rotation < 90 }
    private var rotation: Double
    
    public var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 5
        static let lineWidth: CGFloat = 2
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            shape.strokeBorder(lineWidth: Constants.lineWidth)
                .background(shape.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            
            shape
                .foregroundColor(.clear)
                .background() {
                    Image("cardCover")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .cornerRadius(Constants.cornerRadius)
                }
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
