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
    
    private static let traffic: [String] = ArrayManager.trafficIcon
    private static let starSign: [String] = ArrayManager.starSignIcon
    private static var poker: [String] = ArrayManager.pokerIcon
    
    private var cardColor: Color = .black
    
    enum Topic {
        case traffic
        case starSign
        case poker
    }
    
    init(model: MemoryGame<String> = createMemoryGame(),
         number: Int = 10,
         topic: Topic = .traffic) {
        self.model = EmojiMemoryGame.createMemoryGame(number, topic)
        shuffle()
        chooseColor()
    }
    
    private static func createMemoryGame(_ number: Int = 10,
                                         _ topic: Topic = .traffic) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: number) { pairIndex in
            var card = [String]()
            switch topic {
            case .traffic:  card = traffic.shuffled()
            case .starSign: card = starSign.shuffled()
            case .poker:    card = poker.shuffled()
            }
            return card.indices.contains(pairIndex) ? card[pairIndex] : "⁉️"
        }
    }
    
    public var cards: Array<Card> {
        model.cards
    }
    
    public var color: Color {
        cardColor
    }
    
    public var score: Int {
        model.score
    }
    
    // MARK: - Intents
    public func choose(_ card: Card) {
        model.choose(card)
    }
    
    public func chooseColor() {
        cardColor = ArrayManager.colorArr[Int.random(in: 0..<ArrayManager.colorArr.count)]
    }
    
    public func shuffle() {
        model.shuffle()
    }
}

