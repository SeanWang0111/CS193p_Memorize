//
//  HomePage.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/24.
//

import SDWebImageSwiftUI
import SwiftUI

struct HomePage: View {
    
    @State var cardCount: Int = 10
    @State var topicType: Int = 0 { didSet {
        topicMode = topicType == 0 ? .traffic : topicType == 1 ? .starSign : .poker
    }}
    @State var topicMode: EmojiMemoryGame.Topic = .traffic
    
    private let AppWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationView {
            VStack {
                title.padding(.top, 20)
                
                Spacer()
                select("Topic")
                select("Pair").padding(.bottom, 20)
                
                NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(number: cardCount,
                                                                                           topic: topicMode),
                                                                returnAction: updated)) {
                    start.padding(.bottom, 20)
                }
            }
            .background(background)
        }
    }
    
    // MARK: - View Layout
    private var background: some View {
        ZStack {
            Image("bg_wind")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            AnimatedImage(name: "GAME.gif")
                .opacity(1.0)
                .frame(width: AppWidth, height: AppWidth)
                .padding(.top, -150)
        }
    }
    
    private var start: some View {
        HStack {
            Image(systemName: "gamecontroller")
            Text("Start").padding(.leading, 20)
        }
        .padding(15)
        .padding(.horizontal, 10)
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundColor(.white)
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(30)
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 5)
        )
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    private var title: some View {
        Text("Memory\nGame")
            .font(.system(size: 50))
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .shadow(color: .black, radius: 10, y: 2)
    }
    
    // MARK: - Function
    private func cardCountAdjuster(_ offset: Int) -> some View {
        let isClose: Bool = cardCount + offset < 2 || cardCount + offset > 24
        
        return Button {
            cardCount += offset
        } label: {
            Image(systemName: "triangle.fill")
                .rotationEffect(.degrees(offset == 1 ? 90 : -90))
                .foregroundColor(isClose ? .gray : .black)
        }
        .disabled(isClose)
    }
    
    private func select(_ title: String) -> some View {
        HStack {
            Text(title)
                .frame(width: 80)
                .shadow(radius: 5)
                .padding(.leading, 20)
            
            if title == "Topic" {
                topicTypeAdjuster(-1).padding(.leading, 40)
                
                Text("\(ArrayManager.topic[topicType])")
                    .frame(width: 50)
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)
                
                topicTypeAdjuster(1).padding(.trailing, 20)
                
            } else if title == "Pair" {
                cardCountAdjuster(-1).padding(.leading, 40)
                
                Text("\(cardCount)")
                    .frame(width: 50)
                    .shadow(radius: 5)
                    .padding(.horizontal, 20)
                
                cardCountAdjuster(1).padding(.trailing, 20)
            }
        }
        .padding(.vertical, 5)
        .fontWeight(.bold)
        .foregroundColor(.white)
        .background(Color("4D4D4D_25"))
        .font(.title)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 2, x: 5, y: 5)
    }
    
    private func topicTypeAdjuster(_ offset: Int) -> some View {
        Button {
            let count = ArrayManager.topic.count
            topicType += offset
            topicType = topicType < 0 ? count - 1 : topicType >= count ? 0 : topicType
        } label: {
            Image(systemName: "triangle.fill")
                .rotationEffect(.degrees(offset == 1 ? 90 : -90))
                .foregroundColor(.black)
        }
    }
    
    private func updated() {
        cardCount += 1
        cardCount -= 1
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
