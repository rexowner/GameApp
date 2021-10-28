//
//  MemoryGame.swift
//  GameApp
//
//  CIS 137
//  Partner Lab 3
//  Conrad Boucher & Les Poltrack
//  Oct 27, 2021
//
//

import Foundation

struct MemoryGame {
    private(set) var cards: Array<Card>
    private(set) var numberOfPairs: Int
    
    struct Card: Identifiable {
        var content: String
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var id: Int
    }
    
    func chooseCard(card: Card) {
    }
    
    init(numberOfPairsOfCards: Int, contentFactory: (Int)->String) {
        cards = []
        numberOfPairs = numberOfPairsOfCards
        
        for index in 0..<numberOfPairsOfCards {
            let content = contentFactory(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1 ))
        }
        cards.shuffle()
    }
}
