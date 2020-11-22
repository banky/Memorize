//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Bankole Adebajo on 2020-08-09.
//  Copyright © 2020 Banky. All rights reserved.
//

import Foundation
import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGameModel = createEmojiMemoryGame()
    
    private static func createEmojiMemoryGame() -> MemoryGame<String> {
        let shuffledThemes = getThemes().shuffled()
        let theme = shuffledThemes.first!
        
        let numberOfPairsOfCards = theme.numberOfPairsOfCards ?? Int.random(in: 2...theme.emojis.count)
        let cardsContent = Array(theme.emojis[..<numberOfPairsOfCards])
        return MemoryGame<String>(themeId: theme.id, numberOfPairsOfCards: numberOfPairsOfCards) { pairIndex in
            cardsContent[pairIndex]
        }
    }
    
    private static func getThemes() -> Array<Theme> {
        [
            Theme(id: "Halloween", emojis: ["🐧", "👻", "✏️", "🏀", "🐼"], numberOfPairsOfCards: 4, color: .orange),
            Theme(id: "Birds", emojis: ["🦚", "🦜", "🦆", "🦉"], numberOfPairsOfCards: 3, color: .blue),
            Theme(id: "Dogs", emojis: ["🦮", "🐕‍🦺", "🐕", "🐶"], numberOfPairsOfCards: 3, color: .yellow),
            Theme(id: "Sports", emojis: ["🏄‍♀️", "🤽‍♀️", "🚴‍♀️", "⛹️‍♀️", "🚵‍♀️"], color: .red),
            Theme(id: "Countries", emojis: ["🇨🇦", "🇺🇸", "🇬🇧", "🇳🇬", "🇲🇹"], numberOfPairsOfCards: 3, color: .purple),
            Theme(id: "Weather", emojis: ["☔️", "🌧", "⛈", "🌪", "☀️", "⛅️"], numberOfPairsOfCards: 4, color: .gray),
        ]
    }

    // MARK: Access
    var cards: Array<MemoryGame<String>.Card> {
        memoryGameModel.cards
    }
    
    var color: Color {
        EmojiMemoryGame.getThemes().first() { theme in
            theme.id == memoryGameModel.themeId
        }!.color
    }
    
    var themeName: String {
        memoryGameModel.themeId
    }
    
    var score: Int {
        memoryGameModel.score
    }
    
    // MARK: Intents
    func choose(card: MemoryGame<String>.Card) {
        memoryGameModel.choose(card: card)
    }
    
    func newGame() {
        memoryGameModel = EmojiMemoryGame.createEmojiMemoryGame()
    }
    
    struct Theme: Identifiable {
        var id: String
        var emojis: Array<String>
        var numberOfPairsOfCards: Int?
        var color: Color
    }
}
