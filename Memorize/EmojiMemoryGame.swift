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
    
    private static let trafficIcon: [String] = ["✈️", "🚅", "🛰️", "🚀", "🚑", "🛻", "🚝", "🚁", "🛳️", "🚤", "🚔", "🚍", "🚘", "🚖", "🚢", "🛥️", "⛵️", "🛶", "🛸", "🚂", "🚆", "🛩️", "🚈", "🚞"]
    
    private var cardColor: Color = .black
    
    init(model: MemoryGame<String> = createMemoryGame(), number: Int = 10) {
        self.model = EmojiMemoryGame.createMemoryGame(number)
        shuffle()
        chooseColor()
    }
    
    private static func createMemoryGame(_ number: Int = 10) -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: number) { pairIndex in
            return trafficIcon.indices.contains(pairIndex) ? trafficIcon[pairIndex] : "⁉️"
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
        let colorArr: [Color] = [.black, .blue, .brown, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red, .teal, .yellow]
        cardColor = colorArr[Int.random(in: 0..<colorArr.count)]
    }
    
    public func shuffle() {
        model.shuffle()
    }
}

