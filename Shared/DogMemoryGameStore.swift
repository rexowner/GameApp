//
//  DogMemoryGameStore.swift
//  GameApp
//
//  CIS 137
//  Lab #4
//  Conrad Boucher & Les Poltrack
//  Nov 10, 2021
//
//
//

// This file is the ViewModel for the game


import SwiftUI

class DogMemoryGameStore: ObservableObject {
    
    static let numPairs = 6
    
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
    
    var cards: Array<MemoryGame.Card> { get {
        model.cards
    }}
    
    var totalPairs: Int { get {
        model.numberOfPairs
    }}
    
    var pairsMatched: Int { get {
        model.pairsMatched
    }}
    
    var foundMatch: Bool { get{
        model.foundMatch
    }}
    var isRunning: Bool { get {
        model.isRunning
    }}
    var gameOver: Bool { get {
        model.gameOver
    }}
    
    func choose(_ card: MemoryGame.Card) {
       model.chooseCard(card)
    }
    
    func resetGame() {
        model.rebuildModel()
    }
    func startTimer() {
        model.startTimer()
    }
    func pauseGame() {
        model.pauseGame()
    }
}
