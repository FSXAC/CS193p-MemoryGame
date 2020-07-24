//
//  ContentView.swift
//  MemoryGame
//
//  Created by Muchen He on 2020-05-31.
//  Copyright © 2020 Muchen He. All rights reserved.
//

import SwiftUI

struct MemoryGameView: View {
    
    // pointer to the EmojiMemoryGame view model class
    // we create this when the scene is created (up in sceneDelegate)
    
    // @ObservedObject wrapper will see that the viewmodel has a published
    // object inside it, and every time a "objectWillChange.send()" occurs,
    // the view will redraw.
    
    // Note that not everything will redraw on screen, Swift is smart enough
    // to know which property has changed (hence the Identifiable property
    // required for ForEach etc.)
    @ObservedObject var gameViewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        
        // We want to replace this VStack with a GridView custom SwiftUIView
        GridView(gameViewModel.cards) { card in
            CardView(card: card)
                .shadow(color: .gray, radius: self.shadowSize, x: self.shadowOffsetX, y: self.shadowOffsetY)
                .onTapGesture(perform: {
                    
                    // Need explicit self. because this function happens
                    // some time in the future and we need to capture self
                    // And this self. isn't allocated in the heap.
                    self.gameViewModel.choose(card: card)
                })
                .padding()
        }
        .foregroundColor(.blue)
    }
    
    // MARK: - Drawing constants
    let shadowSize: CGFloat = 10.0
    let shadowOffsetX: CGFloat = 0.0
    let shadowOffsetY: CGFloat = 6.0
}

struct CardView: View {
    
    var card: MemoryGameModel<String>.Card
    
    var body: some View {
        
        // NOTE: Use Geometry reader to obtain the geometry of the container
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for geomSize: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: self.cardRadius)
                    .fill(Color.white)
                Text(self.card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: self.cardRadius).fill()
                }
            }
        }
        .font(.system(size: getFontSize(for: geomSize)))
    }
    
    // MARK: - Drawing constants
    let cardRadius: CGFloat = 8.0
    let fontSizeScale: CGFloat = 0.8
    func getFontSize(for geomSize: CGSize) -> CGFloat {
        min(geomSize.width, geomSize.height) * self.fontSizeScale
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGameViewModel()
        return MemoryGameView(gameViewModel: game)
    }
}
