//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Elias Santa Rosa on 27/07/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    // MARK: - Access to the model
    var cards: Array<MemoryGame<String>.Card> {
        memoryGame.cards
    }

    // MARK: - Intent(s)
    func chooseCard(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        memoryGame.choose(card)
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕷", "💀", "🧛‍♂️", "🧟", "🦇", "🕸", "🐀", "🐍", "🦉"]
//        return MemoryGame<String>(numberOfPairOfCards: emojis.count) { pairIndex in
        return MemoryGame<String>(numberOfPairOfCards: 3) { pairIndex in
            return emojis[pairIndex]
        }
    }
}

