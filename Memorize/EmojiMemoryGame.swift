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
    
    private static func createMemoryGame(_ number: Int = 10) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: number) { pairIndex in
            return emojis.indices.contains(pairIndex) ? emojis[pairIndex] : "⁉️"
        }
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .blue
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    func change(_ number: Int) {
        model = EmojiMemoryGame.createMemoryGame(number)
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}

