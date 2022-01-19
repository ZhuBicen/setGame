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
    
    func showMoreCards() {
        model.showMoreCards()
        objectWillChange.send()
    }
    
    var isInSet : Bool {
        model.isSelectedCardsInSet
    }
        
    func selectCard(card: Card) {
        model.selectCard(card: card)
        objectWillChange.send()
    }
    
    func hint() -> String {
        model.findMatchingCards().description
    }
    
    func newGame() {
        model = GameModel()
        objectWillChange.send()

    }
    
    
}
