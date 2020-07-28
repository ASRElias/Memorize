//
//  MemoryGame.swift
//  Memorize
//
//  Created by Elias Santa Rosa on 27/07/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: Array<Card>
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = true
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
        print("card chosen: \(card)")
        let choosenIndex: Int = index(of: card)
        cards[choosenIndex].isFaceUp = !cards[choosenIndex].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        
        return 0 // TODO: bogus
    }

}
