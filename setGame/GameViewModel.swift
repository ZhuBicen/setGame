//
//  GameViewModel.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/9.
//

import Foundation
import SwiftUI

//struct CardPresent {
//    var internalCard : GameModel.Card
//    var isSelected : Bool = false
//    var isCardMatched : Bool = false
//}

class GameViewModel: ObservableObject {
    
    typealias Card = GameModel.Card
    

    @Published private(set) var model = GameModel()
    
    var selectedCardIds : [Int] = []

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
        if selectedCardIds.count < 3 {
            selectedCardIds.append(card.id)
        }
        if selectedCardIds.count == 3 {
            let cardIds = [selectedCardIds[0], selectedCardIds[1], selectedCardIds[2]]
            if model.areThreeCardsInSet(cardIds) {
                model.addMatchedCard(cardIds)
                selectedCardIds.removeAll()
            }
        }
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
