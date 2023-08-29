//
//  CardView.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/19.
//

import SwiftUI

struct CardView: View {
    
    typealias Card = MemoryGame<String>.Card
    
    private var card: Card
    
    private struct Constants {
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView(.animation) { timeline in
            if card.isFaceUp || !card.isMatched  {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay {
                        if card.isImage {
                            imageContents
                        } else {
                            cardContents.padding(Constants.Pie.inset)
                        }
                    }
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .foregroundColor(.black)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .shadow(color: .gray, radius: 3, x: 5, y: 5)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    var imageContents: some View {
        Image(card.content)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .shadow(color: .black, radius: 5)
    }
}

struct CardView_Previews: PreviewProvider {
    
    typealias Card = CardView.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(isFaceUp: true, content: "X", id: "test1"))
                    .aspectRatio(4/3, contentMode: .fit)
                CardView(Card(content: "X", id: "test1"))
            }
            HStack {
                CardView(Card(isFaceUp: true, isImage: true, content: ArrayManager.dogImageArr[23], id: "test1"))
                CardView(Card(isMatched: true, content: "X", id: "test1"))
            }
        }
        .padding()
        .foregroundColor(.yellow)
    }
}
