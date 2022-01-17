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

    func getShowingCards() -> Array<Card> {
        model.getShowingCards()
    }
//    var cards: Array<Card> {
//        model.getShowingCards()
//    }
    
    var isInSet : Bool {
        model.isSelectedCardsInSet
    }
    
    func selectCard(card: Card) {
        model.selectCard(card: card)
        objectWillChange.send()

    }
    
    func findMatchingCards() -> [Int] {
        model.findMatchingCards()
    }
    
    func newGame() {
        model = GameModel()
        objectWillChange.send()

    }
    
    
}
