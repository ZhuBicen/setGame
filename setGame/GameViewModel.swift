//
//  GameViewModel.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/9.
//

import Foundation

class GameViewModel: ObservableObject {
    typealias Card = GameModel.Card
    

    
    @Published private(set) var model = GameModel()

    var cards: Array<Card> {
        model.showingCards
    }
    
    var isInSet : Bool {
        model.isSelectedCardsInSet
    }
    
    func selectCard(card: Card) {
        model.selectCard(card: card)
    }
    
    func findMatchingCards() -> [Int] {
        model.findMatchingCards()
    }
    
    func newGame() {
        model = GameModel()
    }
    
    
}
