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
struct MemoryGameModel<CardContentType> where CardContentType: Equatable {
    var cards: [Card]
    
    // keep track of card index that is currently flipped over
    var indexOfCurrentFaceUpCard: Int?
    
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
        
        // Condition if the optional is not nil
        if let chosenIndex: Int = self.cards.indexOf(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            // Do some matching
            if let potentialMatchIndex = indexOfCurrentFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // MATCH!
                    
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                
                // Reset card index var
                indexOfCurrentFaceUpCard = nil
            } else {
                
                // If indexOfCurrentFaceUpCard is nil
                // then we set all the cards to be face down fist
                // this shouldn't affect the cards that's already matched
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                // Set current selected card
                indexOfCurrentFaceUpCard = chosenIndex
            }
            
            // Flip over the card state
            self.cards[chosenIndex].isFaceUp = true
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContentType
        var id: Int
    }
}
