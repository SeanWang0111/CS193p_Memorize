//
//  ContentView.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/8.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    @State private var lastScoreChange = (0, causedByCardId: "")
    @State private var dealt = Set<Card.ID>()
    @State private var showAlert: Bool = false
    
    typealias Card = MemoryGame<String>.Card
    
    private var unDealtCards: [Card] { viewModel.cards.filter { !isDealt($0) } }
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/3
        static let spacing: CGFloat = 5
        
        struct Deal {
            static let interval: TimeInterval = 0.15
            static let animation: Animation = .easeInOut(duration: 0.8)
        }
        
        struct Deck {
            static let width: CGFloat = 50
        }
    }
    
    public var returnAction: () -> Void
    
    var body: some View {
        Content
        .padding()
        .background(background)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.deal()
            }
        }
        .onDisappear() { returnAction() }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GameOver"))) { _ in
            showAlert.toggle()
        }
        .alert("!!! Success !!!", isPresented: $showAlert, actions: {
           Button("Cancel") { presentationMode.wrappedValue.dismiss() }
        })
    }
    
    // MARK: - Methods
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
            withAnimation(Constants.Deal.animation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += Constants.Deal.interval
        }
    }
    
    private func fraction(_ name: String) -> some View {
        var textName: String = "\(name): "
        switch name {
        case "Combo": textName.append("\(viewModel.combo)")
        case "Error": textName.append("\(viewModel.errorTime)")
        case "Score": textName.append("\(viewModel.score)")
        case "Pair":  textName.append("\(viewModel.completePair) / \(viewModel.totalPair)")
        default:      textName = ""
        }
        return Text(textName)
            .foregroundColor(.white)
            .font(.title)
            .animation(nil)
            .frame(maxWidth: 150, alignment: .leading)
            .shadow(color: .black, radius: 3)
    }
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardId: id) = lastScoreChange
        return card.id == id ? amount : 0
    }
}

// MARK: - Subviews
extension EmojiMemoryGameView {
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 3)
        }
    }
    
    private var background: some View {
        Image("bg_moon")
            .resizable()
            .edgesIgnoringSafeArea(.all)
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: Constants.aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(Constants.spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    private var Content: some View {
        VStack {
            cards.foregroundColor(viewModel.color)
            HStack {
                VStack {
                    fraction("Score")
                    fraction("Pair")
                }
                Spacer()
                deck.foregroundColor(viewModel.color)
                Spacer()
                VStack {
                    fraction("Combo")
                    fraction("Error")
                }
            }
            .font(.largeTitle)
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
        .frame(width:  Constants.Deck.width,
               height: Constants.Deck.width / Constants.aspectRatio)
    }
}

struct EmojiMemoryGameViewView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame(), returnAction: {})
    }
}
