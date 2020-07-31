//
//  MemoryGame.swift
//  Memorize
//
//  Created by Elias Santa Rosa on 27/07/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {

        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }

    }

    struct Card: Identifiable {

        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent

    }
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {

        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairOfCards {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }

    }
    
    mutating func choose(_ card: Card) {

        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }

    }

}
