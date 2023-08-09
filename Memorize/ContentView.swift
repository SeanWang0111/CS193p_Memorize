//
//  ContentView.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/8.
//

import SwiftUI

struct ContentView: View {
    @State var emojiCount = 20
    var emojis: [String] = ["✈️", "🚅", "🛰️", "🚀", "🚑", "🛻", "🚝", "🚁", "🛳️", "🚤", "🚔", "🚍", "🚘", "🚖", "🚢", "🛥️", "⛵️", "🛶", "🛸", "🚂", "🚆", "🛩️", "🚈", "🚞"]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            
            Spacer()
            
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
        }
        .padding(.horizontal)
    }
    
    var remove: some View {
        Button(action: {
            emojiCount = emojiCount > 1 ? emojiCount - 1 : 1
        }, label: {
            Image(systemName: "minus.circle")
        })
    }
    
    var add: some View {
        Button(action: {
            emojiCount = emojiCount < emojis.count ? emojiCount + 1 : emojiCount
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    var content: String
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 5)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
