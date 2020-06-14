//
//  ContentView.swift
//  MemoryGame
//
//  Created by Muchen He on 2020-05-31.
//  Copyright © 2020 Muchen He. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // pointer to the EmojiMemoryGame view model class
    // we create this when the scene is created (up in sceneDelegate)
    var gameViewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ForEach(gameViewModel.cards) { card in
                CardView(card: card)
                    .shadow(color: .gray, radius: 10, x: 0, y: 7)
                    .onTapGesture(perform: {
                        self.gameViewModel.choose(card: card)
                    })
            }
            .foregroundColor(.blue)
            .font(.largeTitle)
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 3.0)
                    .fill(Color.white)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 3.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        return ContentView(gameViewModel: game)
    }
}
