//
//  ContentView.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/8.
//

import SwiftUI

struct ContentView: View {
    @State var emojiCount = 10
    var emojis: [String] = ["✈️", "🚅", "🛰️", "🚀", "🚑", "🛻", "🚝", "🚁", "🛳️", "🚤", "🚔", "🚍", "🚘", "🚖", "🚢", "🛥️", "⛵️", "🛶", "🛸", "🚂", "🚆", "🛩️", "🚈", "🚞"]
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding(.horizontal)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
            ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                CardView(content: emoji)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.red)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            remove
            Spacer()
            add
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var remove: some View {
        cardCountAdjuster(by: -1, symbol: "minus.circle")
    }
    
    var add: some View {
        cardCountAdjuster(by: 1, symbol: "plus.circle")
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            emojiCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(emojiCount + offset < 1 || emojiCount + offset > emojis.count)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 5)
                Text(content).font(.largeTitle)
                    .shadow(color: .gray, radius: 3, x: 5, y: 5)
                    .opacity(0.8)
            }
            .opacity(isFaceUp ? 1 : 0)
            shape.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
