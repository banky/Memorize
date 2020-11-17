//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bankole Adebajo on 2020-08-09.
//  Copyright © 2020 Banky. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.first }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, cardFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(content: cardFactory(pairIndex), id: pairIndex * 2))
            cards.append(Card(content: cardFactory(pairIndex), id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        if let chosenCardIndex = cards.index(of: card), !cards[chosenCardIndex].isFaceUp, !cards[chosenCardIndex].isMatched { 
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenCardIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenCardIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenCardIndex
            }

            self.cards[chosenCardIndex].isFaceUp = true
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
