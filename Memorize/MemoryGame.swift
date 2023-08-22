//
//  MemoryGame.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/16.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false { didSet {
                guard oldValue && !isFaceUp else { return }
                hasBeenSeen = true
            }
        }
        
        var isMatched: Bool = false
        var content: CardContent
        
        var hasBeenSeen = false
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
    
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue } }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        guard let chooseIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chooseIndex].isFaceUp && !cards[chooseIndex].isMatched else { return }
        
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[potentialMatchIndex].content == cards[chooseIndex].content {
                cards[potentialMatchIndex].isMatched = true
                cards[chooseIndex].isMatched = true
                score += 2
            } else {
                
            }
        } else {
            indexOfTheOneAndOnlyFaceUpCard = chooseIndex
        }
        cards[chooseIndex].isFaceUp = true
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
