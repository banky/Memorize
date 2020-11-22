//
//  MemoryGame.swift
//  Memorize
//
//  Created by Bankole Adebajo on 2020-08-09.
//  Copyright © 2020 Banky. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var themeId: String
    private(set) var score: Int
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(themeId: String, numberOfPairsOfCards: Int, cardFactory: (Int) -> CardContent) {
        self.themeId = themeId
        self.score = 0
        cards = Array<Card>()
        
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(content: cardFactory(pairIndex), id: pairIndex * 2))
            cards.append(Card(content: cardFactory(pairIndex), id: pairIndex * 2 + 1))
        }
        
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        let matchBonus: Int = 2
        let previouslySeenPenalty: Int = 1
        
        if let chosenCardIndex = cards.firstIndex(of: card), !cards[chosenCardIndex].isFaceUp, !cards[chosenCardIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenCardIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenCardIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += matchBonus
                } else if cards[chosenCardIndex].isPreviouslySeen {
                    score -= cards[chosenCardIndex].isPreviouslySeen ? previouslySeenPenalty : 0
                    score -= cards[potentialMatchIndex].isPreviouslySeen ? previouslySeenPenalty : 0
                }
                self.cards[chosenCardIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenCardIndex
                cards[chosenCardIndex].isPreviouslySeen = true
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isPreviouslySeen: Bool = false
        var content: CardContent
        var id: Int
    }
}
