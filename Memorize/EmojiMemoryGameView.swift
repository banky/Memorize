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
        Grid(emojiMemoryGame.cards) { card in
            CardView(card: card).onTapGesture(perform: {
                self.emojiMemoryGame.choose(card: card)
                })
            .padding()
        }
        .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if !card.isMatched {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: lineWidth)
                    Text(card.content)
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            
        }
//        .aspectRatio(2/3, contentMode: .fit)
        .font(fontSize(for: size))
    }
        
    // MARK: Drawing Constants
    let cornerRadius: CGFloat = 10
    let lineWidth: CGFloat = 3
    func fontSize(for size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.6)
    }
}











struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiMemoryGame: EmojiMemoryGame())
    }
}
