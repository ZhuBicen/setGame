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
    
//    var isInSet : Bool {
//        return selectedCardIds.count == 3 && model.areThreeCardsInSet(selectedCardIds)
//    }
    
    
    func isCardInSet(card : Card) -> Bool {
        selectedCardIds.count == 3 && selectedCardIds.contains(card.id) && model.areThreeCardsInSet(selectedCardIds)
    }
    
    func isCardSelected(card : Card) -> Bool {
        selectedCardIds.contains(card.id)
    }
    
    func selectCard(card: Card) {
        if selectedCardIds.count == 3 && model.areThreeCardsInSet(selectedCardIds) {
            model.dealThreeMoreCards()
            selectedCardIds.removeAll()
        }
        if selectedCardIds.count < 3 {
            selectedCardIds.append(card.id)
        } else if selectedCardIds.count > 3 {
            selectedCardIds.removeAll()
            selectedCardIds.append(card.id)
        } else {
            let cardIds = [selectedCardIds[0], selectedCardIds[1], selectedCardIds[2]]
            if model.areThreeCardsInSet(cardIds) {
                model.addMatchedCard(cardIds)
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
