//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by Muchen He on 2020-05-31.
//  Copyright © 2020 Muchen He. All rights reserved.
//

// MODEL

import Foundation

// Templating using <T>
struct MemoryGameModel<CardContentType> {
    var cards: [Card]
    
    init(numOfPairs: Int, cardContentFactory: (Int) -> CardContentType) {
        cards = [Card]()
        for pairIndex in 0..<numOfPairs {
            let cardContent: CardContentType = cardContentFactory(pairIndex)
            cards.append(Card(content: cardContent, id: pairIndex * 2))
            cards.append(Card(content: cardContent, id: pairIndex * 2 + 1))
        }
        
        // Shuffle the cards
        cards.shuffle()
    }
    
    // Function that changes self state should be mutating
    mutating func choose(card: Card) {
        print("Chosen \(card)")
        let chosenIndex: Int = self.cards.indexOf(matching: card)
        
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContentType
        var id: Int
    }
}
