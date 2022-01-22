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
//        if selectedCardIds.contains(card.id) {
//            selectedCardIds = selectedCardIds.filter{$0 != card.id}
//            objectWillChange.send()
//            return
//        }
//        if selectedCardIds.count == 3 && model.areThreeCardsInSet(selectedCardIds) {
//            if !selectedCardIds.contains(card.id) {
//
//            }
//            model.replaceMachedCard(selectedCardIds)
//            selectedCardIds.removeAll()
//            objectWillChange.send()
//            return
//        }
        if selectedCardIds.count < 3 {
            selectedCardIds.append(card.id)
        } else if selectedCardIds.count > 3 {
            selectedCardIds.removeAll()
            selectedCardIds.append(card.id)
        } else { // == 3
            
            let cardIds = [selectedCardIds[0], selectedCardIds[1], selectedCardIds[2]]
            if model.areThreeCardsInSet(cardIds) {
                model.addMatchedCard(cardIds)
            } else {
                selectedCardIds.removeAll()
                selectedCardIds.append(card.id)
            }
        }
        objectWillChange.send()
    }
    
    func hint() -> String {
        model.findMatchingCards().description
    }
    
    func newGame() {
        model = GameModel()
        selectedCardIds.removeAll()
        objectWillChange.send()

    }
    
    
}
