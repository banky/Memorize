//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bankole Adebajo on 2020-08-09.
//  Copyright © 2020 Banky. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGameModel: MemoryGame<String> = createEmojiMemoryGame()
    
    static func createEmojiMemoryGame() -> MemoryGame<String> {
//        let numberOfPairsOfCards = Int.random(in: 2...5)
        let numberOfPairsOfCards = 3
        
        var allPossibleCardContent = ["👻", "🎃", "🕷", "☠️", "👹", "🙀", "🥴", "🤑", "🚀", "💲", "🐌", "🤯"];
        allPossibleCardContent.shuffle()
        let cardsContent = Array(allPossibleCardContent[..<numberOfPairsOfCards])
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            cardsContent[pairIndex]
        }
    }
        
    // MARK: Access
    var cards: Array<MemoryGame<String>.Card> {
        memoryGameModel.cards
    }
    
    // MARK: Intents
    func choose(card: MemoryGame<String>.Card) {
        memoryGameModel.choose(card: card)
    }
}
