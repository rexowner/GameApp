//
//  DogMemoryGameStore.swift
//  GameApp
//
//  Created by Les Poltrack on 10/24/21.
//

import SwiftUI

class DogMemoryGameStore: ObservableObject {
    @Published private var model: MemoryGame = CreateMemoryGame()
    
    static func CreateMemoryGame() -> MemoryGame {
        return MemoryGame(numberOfPairsOfCards: 4, contentFactory: makeContent)
    }
    
    static func makeContent(index: Int) -> String {
        let dogImages = ["airedale_terrier", "american_foxhound","dutch_shepherd",
                       "havanese", "labrador_puppy", "leonberger",
                       "mudi", "norwegian_lundehund", "old_labrador",
                       "pharaoh_hound", "scottish_terrier", "tosa"
                        ]
        return dogImages[index]
    }
    
    var cards: Array<MemoryGame.Card> {
        model.cards
    }
    
    var pairs: Int {
        model.numberOfPairs
    }
}
