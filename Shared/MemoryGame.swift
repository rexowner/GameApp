//
//  MemoryGame.swift
//  GameApp
//
//  Created by Les Poltrack on 10/24/21.
//

import Foundation

struct MemoryGame {
    private var cards: Array<Card>
    private var numberOfPairs: Int
    
    struct Card {
        var content: String
        var isFaceUp: Bool = false
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
    }
}
