//
//  DogMemoryGameStore.swift
//  GameApp
//
//  CIS 137
//  Partner Lab 4
//  Conrad Boucher & Les Poltrack
//  Nov 11, 2021
//
//

// This file is the ViewModel for the game


import SwiftUI

class DogMemoryGameStore: ObservableObject {
    
    static let numPairs = 9
    
    @Published private var model: MemoryGame = CreateMemoryGame()
    
    static func CreateMemoryGame() -> MemoryGame {
        return MemoryGame(numberOfPairsOfCards: numPairs, contentFactory: makeContent)
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
    
    var foundMatch: Bool {
        model.foundMatch
    }
    
    func choose(_ card: MemoryGame.Card) {
       model.chooseCard(card)
    }
}
