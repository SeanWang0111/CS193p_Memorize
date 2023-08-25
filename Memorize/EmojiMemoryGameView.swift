//
//  ContentView.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/8.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    @State private var dealt = Set<Card.ID>()
    
    typealias Card = MemoryGame<String>.Card
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 5
    
    private let deckWidth: CGFloat = 50
    private let dealAnimation: Animation = .easeOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    
    private var unDealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    public var returnAction: () -> Void
    
    var body: some View {
        VStack {
            cards.foregroundColor(viewModel.color)
            
            HStack {
                score
                Spacer()
                deck.foregroundColor(viewModel.color)
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding()
        .background() {
            background
        }
        .onDisappear() {
            returnAction()
        }
    }
    
    // MARK: - View Layout
    private var background: some View {
        Image("bg_moon")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    private var deck: some View {
        ZStack {
            ForEach(unDealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal() 
        }
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation() {
                viewModel.shuffle()
            }
        }
    }
    
    // MARK: - Function
    private func choose(_ card: Card) {
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    
    private func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: 0.8).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardId: id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}

struct EmojiMemoryGameViewView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame(), returnAction: {})
    }
}
