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

// We need to add observedObject protocol
// for this viewmodel to participate and anticipate a change
// in the model
class EmojiMemoryGameViewModel: ObservableObject {
    
    // private(set) makes the model is read-only and can only be mutated by EmojiMemoryGame view model itself
    // private makes it so no view can have access to this model
    
    // "@Published" property wrapper will automatically call
    // objectWillChange.send()
    @Published private var model: MemoryGameModel<String> = createMemoryGame()
    
    // Static function is not defined after initialization
    static func createMemoryGame() -> MemoryGameModel<String> {
        let availEmojis = Array("😂🏳️‍🌈🗿😎⚰️👅💎♠️♣️♥️♦️")
        
        // Have the game start up with random number of pairs (between 2 to 5)
        let numPairs = Int.random(in: 3...5)
        
        // If a function call's last parameter has {}
        // then it can be put outside of the () and ignore
        // parameter name
        return MemoryGameModel<String>(numOfPairs: numPairs) { index in
            
            // Select a random item in the available emojis array and use that
            return String(availEmojis.shuffled()[index])
        }
    }
    
    // MARK: - Access to the model
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
        
        // This make observable object primed for change
        // objectWillChange.send()
        // But our model is @Published, so we don't need to do that

        self.model.choose(card: card)
    }
}
