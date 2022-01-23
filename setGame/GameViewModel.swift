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
    
    struct CardPresent {
        var card : GameModel.Card
        var isSelected : Bool = false
        var isMatched : Bool = false
    }
    

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
            let oldSelectedCardIds = selectedCardIds
            model.replaceMachedCard(selectedCardIds)
            selectedCardIds.removeAll()
            if !oldSelectedCardIds.contains(card.id) {
                selectedCardIds.append(card.id)
            }
        } else {
            if selectedCardIds.contains(card.id) { // deselect card
                selectedCardIds = selectedCardIds.filter{$0 != card.id}
            } else {
                if selectedCardIds.count < 3 { // select card
                    selectedCardIds.append(card.id)
                } else if selectedCardIds.count == 3 {
                    if model.areThreeCardsInSet(selectedCardIds) {
                        model.replaceMachedCard(selectedCardIds)
                    } else {
                        selectedCardIds.removeAll()
                        selectedCardIds.append(card.id)
                    }
                }
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
