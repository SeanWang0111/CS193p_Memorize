//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/16.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model = createMemoryGame()
    
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["✈️", "🚅", "🛰️", "🚀", "🚑", "🛻", "🚝", "🚁", "🛳️", "🚤", "🚔", "🚍", "🚘", "🚖", "🚢", "🛥️", "⛵️", "🛶", "🛸", "🚂", "🚆", "🛩️", "🚈", "🚞"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 20) { pairIndex in
            return emojis.indices.contains(pairIndex) ? emojis[pairIndex] : "⁉️"
        }
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .red
    }
    
    // MARK: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}

