//
//  MemoryGame.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/16.
//

import Foundation

struct MemoryGame<CardContent> {
    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
    
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}
