//
//  GameViewModel.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/9.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    
    typealias Card = GameModel.Card
    
    struct CardPresent {
        var card : GameModel.Card
        var isSelected : Bool = false
        var isMatched : Bool = false
    }
    
    var zIndexOfCards : [Int:Double] = [:]

    @Published private(set) var model = GameModel()
    
    @Published var selectedCards : [Card] = []

    func getDealtCards() -> Array<Card> {
        model.getDealtCards()
    }
    
    func getDiscardedCards() -> Array<Card> {
        model.getDiscaredCards()
    }
    
    func setZIndex(of card : GameModel.Card, _ zIndex : Double) {
        zIndexOfCards[card.id] = zIndex
    }
    
    func getZIndex(of card : Card) -> Double {
        zIndexOfCards[card.id] ?? 0
    }
    
    func getDeckCards() -> Array<Card> {
        model.getDeckCards()
    }
    
    var isCardInDeck : Bool {
        model.isCardInDeck()
    }
    
    func dealMoreCards() -> [Card] {
        let cards = model.dealMoreCards()
        objectWillChange.send()
        return cards
    }
    
    func isCardInSet(card : Card) -> Bool {
        selectedCards.count == 3 && selectedCards.contains{$0.id == card.id} && model.areThreeCardsInSet(selectedCards)
    }
    
    func isCardSelected(card : Card) -> Bool {
        selectedCards.contains{$0.id == card.id}
    }
    
    func selectCard(card: Card) {
        if selectedCards.count == 3 && model.areThreeCardsInSet(selectedCards) {
            let oldSelectedCardIds = selectedCards
            model.replaceMachedCard(selectedCards)
            selectedCards.removeAll()
            if !oldSelectedCardIds.contains(where:{$0.id == card.id}) {
                selectedCards.append(card)
            }
        } else {
            if selectedCards.contains(where: {$0.id == card.id}) { // deselect card
                selectedCards = selectedCards.filter{$0.id != card.id}
            } else {
                if selectedCards.count < 3 { // select card
                    selectedCards.append(card)
                } else if selectedCards.count == 3 {
                    if model.areThreeCardsInSet(selectedCards) {
                        model.replaceMachedCard(selectedCards)
                    } else {
                        selectedCards.removeAll()
                        selectedCards.append(card)
                    }
                }
            }
        }
    }
    
    func dealCards() {
        model.dealCards()
        objectWillChange.send()
    }
    
    func hint() -> String {
        model.findMatchingCards().description
    }
    
    func newGame() {
        model = GameModel()
        selectedCards.removeAll()
    }
    
    
}
