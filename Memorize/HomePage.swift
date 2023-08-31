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
        switch topicType {
        case 0:  topicMode = .traffic
        case 1:  topicMode = .starSign
        case 2:  topicMode = .poker
        case 3:  topicMode = .dog
        default: topicMode = .traffic
        }
    }}
    @State var topicMode: EmojiMemoryGame.Topic = .traffic
    
    private struct Constants {
        struct Gif {
            static let width: CGFloat = UIScreen.main.bounds.width
        }
        
        struct Select {
            static let titleWidth: CGFloat = 80
            static let shadowRadius: CGFloat = 5
            static let width: CGFloat = 50
            static let cornerRadius: CGFloat = 20
        }
        
        struct Start {
            static let insideRadius: CGFloat = 30
            static let spacing: CGFloat = 10
            static let outsideRadius: CGFloat = insideRadius + spacing
        }
        
        struct Title {
            static let fontSize: CGFloat = 50
            static let shadowRadius: CGFloat = 10
        }
    }
    
    var body: some View {
        NavigationView {
            Content
            .background(background)
        }
    }
    
    // MARK: - Methods
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
                .frame(width: Constants.Select.titleWidth)
                .shadow(radius: Constants.Select.shadowRadius)
                .padding(.leading, 20)
            
            if title == "Topic" {
                topicTypeAdjuster(-1).padding(.leading, 40)
                
                Text("\(ArrayManager.topic[topicType])")
                    .frame(width: Constants.Select.width)
                    .shadow(radius: Constants.Select.shadowRadius)
                    .padding(.horizontal, 20)
                
                topicTypeAdjuster(1).padding(.trailing, 20)
                
            } else if title == "Pair" {
                cardCountAdjuster(-1).padding(.leading, 40)
                
                Text("\(cardCount)")
                    .frame(width: Constants.Select.width)
                    .shadow(radius: Constants.Select.shadowRadius)
                    .padding(.horizontal, 20)
                
                cardCountAdjuster(1).padding(.trailing, 20)
            }
        }
        .padding(.vertical, 5)
        .fontWeight(.bold)
        .foregroundColor(.white)
        .background(Color("4D4D4D_25"))
        .font(.title)
        .cornerRadius(Constants.Select.cornerRadius)
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

// MARK: - Subviews
extension HomePage {
    
    private var background: some View {
        ZStack {
            Image("bg_wind")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            AnimatedImage(name: "GAME.gif")
                .opacity(1.0)
                .frame(width: Constants.Gif.width, height: Constants.Gif.width)
                .padding(.top, -150)
        }
    }
    
    private var Content: some View {
        VStack {
            title.padding(.top, 20)
            Spacer()
            select("Topic")
            select("Pair").padding(.bottom, 20)
            NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(number: cardCount, topic: topicMode),
                                                            returnAction: updated)) {
                start.padding(.bottom, 20)
            }
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
        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                   startPoint: .leading,
                                   endPoint: .trailing))
        .cornerRadius(Constants.Start.insideRadius)
        .padding(Constants.Start.spacing)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.Start.outsideRadius)
                .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                                       startPoint: .leading,
                                       endPoint: .trailing), lineWidth: 5)
        )
        .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    private var title: some View {
        Text("Memory\nGame")
            .font(.system(size: Constants.Title.fontSize))
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .shadow(color: .black, radius: Constants.Title.shadowRadius, y: 2)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
