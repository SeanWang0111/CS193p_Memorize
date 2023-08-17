//
//  ContentView.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/8.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Button("shuffle") {
                viewModel.shuffle()
            }
        }
        .padding(.horizontal)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70), spacing: 10)], spacing: 10) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.red)
    }
}

struct EmojiMemoryGameViewView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 5)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(color: .gray, radius: 3, x: 5, y: 5)
                    .opacity(0.8)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            shape.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
}
