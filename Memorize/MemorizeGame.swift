//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/16.
//

import Foundation

struct MemorizeGame<CardContent> {
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
    
    var card: Array<Card>
    
    func choose(card: Card) {
    }
}
