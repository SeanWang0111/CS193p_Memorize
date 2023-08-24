//
//  HomePage.swift
//  Memorize
//
//  Created by 王奕翔 on 2023/8/24.
//

import SwiftUI

struct HomePage: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var cardCount: Int = 10
    
    private let AppWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Memory\nGame")
                    .font(.system(size: 50))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, y: 2)
                    .lineSpacing(10)
                    .padding(.top, 50)
                
                Spacer()
                
                HStack {
                    Button {
                        cardCount -= 1
                        viewModel.change(cardCount)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .disabled(cardCount < 3)
                    
                    Text("\(cardCount)")
                    
                    Button {
                        cardCount += 1
                        viewModel.change(cardCount)
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .disabled(cardCount > 23)
                }
                
                Spacer()
                
                NavigationLink(destination: EmojiMemoryGameView(viewModel: viewModel)) {
                    HStack {
                        Image(systemName: "gamecontroller")
                            .padding(.trailing, 20)
                        Text("Start")
                    }
                    .padding(20)
                    .fontWeight(.bold)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                    )
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.bottom, 50)
                }
            }
            .background(
                ZStack {
                    Image("bg_wind")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                    
                    GifImage(name: "BIRD")
                        .opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: AppWidth, height: AppWidth)
                }
            )
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(viewModel: EmojiMemoryGame())
    }
}
