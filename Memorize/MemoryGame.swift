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
            isFaceUp ? startUsingBonusTime() : stopUsingBonusTime()
            guard oldValue && !isFaceUp else { return }
            hasBeenSeen = true
        }}
        
        var isMatched: Bool = false { didSet {
            guard isMatched else { return }
            stopUsingBonusTime()
        }}
        
        var isImage: Bool = false
        
        var content: CardContent
        
        var hasBeenSeen = false
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
        
        // MARK: - Bonus Time
        private mutating func startUsingBonusTime() {
            guard isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil else { return }
            lastFaceUpDate = Date()
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime) / bonusTimeLimit : 0
        }
        
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var bonusTimeLimit: TimeInterval = 6
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
    }
    
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue } }
    }
    
    init(isImage: Bool, numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(isImage: isImage, content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(isImage: isImage,content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        guard let chooseIndex = cards.firstIndex(where: { $0.id == card.id }),
              !cards[chooseIndex].isFaceUp && !cards[chooseIndex].isMatched else { return }
        
        if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
            if cards[potentialMatchIndex].content == cards[chooseIndex].content {
                cards[potentialMatchIndex].isMatched = true
                cards[chooseIndex].isMatched = true
                score += 2 + cards[chooseIndex].bonus + cards[potentialMatchIndex].bonus
            } else {
                if cards[chooseIndex].hasBeenSeen {
                    score -= 1
                }
                if cards[potentialMatchIndex].hasBeenSeen {
                    score -= 1
                }
            }
        } else {
            indexOfTheOneAndOnlyFaceUpCard = chooseIndex
        }
        cards[chooseIndex].isFaceUp = true
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
}
