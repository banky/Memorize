//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bankole Adebajo on 2020-08-09.
//  Copyright © 2020 Banky. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(content: cardFactory(pairIndex), id: pairIndex * 2))
            cards.append(Card(content: cardFactory(pairIndex), id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    func choose(card: Card) {
        print("Chose card: \(card)")
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
