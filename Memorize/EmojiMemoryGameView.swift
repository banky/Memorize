//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Bankole Adebajo on 2020-08-09.
//  Copyright © 2020 Banky. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemoryGame: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack{
                NewGameButtonView()
                    .onTapGesture {
                        emojiMemoryGame.newGame()
                    }
                    .padding()
                    .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                Text(emojiMemoryGame.themeName)
                Text("Score: \(emojiMemoryGame.score)")
            }
            Grid(emojiMemoryGame.cards) { card in
                CardView(card: card).onTapGesture(perform: {
                    self.emojiMemoryGame.choose(card: card)
                })
                .padding()
            }
            .foregroundColor(emojiMemoryGame.color)
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110 - 90), clockwise: true).padding(5).opacity(0.4)
                Text(card.content)
                    .font(fontSize(for: size))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // MARK: Drawing Constants
    private func fontSize(for size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.7)
    }
}

struct NewGameButtonView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
            Text("New Game")
        }
    }
    
    private let cornerRadius: CGFloat = 10
    private let lineWidth: CGFloat = 3
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return Group {
            EmojiMemoryGameView(emojiMemoryGame: game)
        }
    }
}
