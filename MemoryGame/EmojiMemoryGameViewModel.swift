//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by Muchen He on 2020-05-31.
//  Copyright © 2020 Muchen He. All rights reserved.
//

// VIEW MODEL

import Foundation
import SwiftUI


class EmojiMemoryGameViewModel {
    
    // private(set) makes the model is read-only and can only be mutated by EmojiMemoryGame view model itself
    // private makes it so no view can have access to this model
    private var model: MemoryGameModel<String> = createMemoryGame()
    
    // Static function is not defined after initialization
    static func createMemoryGame() -> MemoryGameModel<String> {
        let availEmojis = Array("😂🏳️‍🌈🗿😎⚰️👅💎♠️♣️♥️♦️")
        
        // Have the game start up with random number of pairs (between 2 to 5)
        let numPairs = Int.random(in: 2...5)
        
        // If a function call's last parameter has {}
        // then it can be put outside of the () and ignore
        // parameter name
        return MemoryGameModel<String>(numOfPairs: numPairs) { index in
            
            // Select a random item in the available emojis array and use that
            return String(availEmojis.shuffled()[index])
        }
    }
    
    // Like "getters"
    var cards: [MemoryGameModel<String>.Card] {
        self.model.cards
    }
    
    var numOfPair: Int {
        Int(self.model.cards.count / 2)
    }
    
    // MARK: - Intents
    // User interacts with model with "intents"
    
    func choose(card: MemoryGameModel<String>.Card) {
        self.model.choose(card: card)
    }
}
