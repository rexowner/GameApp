//
//  MemoryGame.swift
//  GameApp
//
//  CIS 137
//  Lab #4
//  Conrad Boucher & Les Poltrack
//  Nov 10, 2021
//
//
//

// This file is the Model for the game

import Foundation

struct  MemoryGame {
    private(set) var cards: Array<Card>
    private(set) var numberOfPairs: Int
    private(set) var pairsMatched: Int
    private var numberUnMatchedFaceUp: Int
    private(set) var foundMatch: Bool

    struct Card: Identifiable { // Struct
        var content: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var id: Int
    }
    
    mutating func chooseCard(_ card: Card) {
        foundMatch = false
        numberUnMatchedFaceUp += 1
        if numberUnMatchedFaceUp == 3 {
            for index in cards.indices { // Put all unmatched cards face down
                if !cards[index].isMatched {
                    cards[index].isFaceUp = false
                }
            }
            numberUnMatchedFaceUp = 1
        }
        for index in cards.indices {
            if cards[index].id == card.id {
                cards[index].isFaceUp.toggle() // Flip The card
            }
            // Check for match
            if (card.content  == cards[index].content) && (cards[index].isFaceUp) && (cards[index].id != card.id) {
                cards[index].isMatched = true //Found a match -- match other card
                foundMatch = true
                pairsMatched += 1
                
                // Can't use "card.isMatched = true" since it's a let constant,
                // so just look through array and match first card anyway - kind of a hack, but it works
                for anotherindex in cards.indices {
                    if cards[anotherindex].content == cards[index].content {
                        cards[anotherindex].isMatched = true
                    }
                }
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, contentFactory: (Int)->String) {
        cards = []
        numberOfPairs = numberOfPairsOfCards
        pairsMatched = 0
        numberUnMatchedFaceUp = 0
        
        for index in 0..<numberOfPairsOfCards {
            let content = contentFactory(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1 ))
        }
        cards.shuffle()
        foundMatch = false
    }
}
