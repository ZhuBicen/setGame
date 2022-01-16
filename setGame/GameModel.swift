//
//  GameModel.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/9.
//

import Foundation
import SwiftUI

struct GameModel {
    
    
    enum CardGeometry : CaseIterable{
        case diamond
        case roundedRectangle
        case curv
    }
    
    enum CardNumber : CaseIterable{
        case one
        case two
        case three
    }
    
    enum CardFillStyle : CaseIterable{
        case solid
        case empty
        case grid
    }
    
    //    enum CardColor : CaseIterable {
    //        case red = Color.red
    //        case green = Color.green
    //        case purple = Color.purple
    //    }
    
    struct Card : Identifiable {
        var id : Int
        var number : CardNumber
        var fill  : CardFillStyle
        var color : Color
        var shape : CardGeometry
        var isSelected: Bool = false
        var isInSet: Bool = false
        var isShowing: Bool = false
        
    }
    
    var cards : Array<Card> = []
    var showingCards :Array<Card> = []
    var isSelectedCardsInSet = false
    
    
    init() {
        var i : Int = 0
        for number in CardNumber.allCases {
            for fill in CardFillStyle.allCases {
                for color in [Color.red, Color.green, Color.purple] {
                    for shape in CardGeometry.allCases {
                        cards.append(Card(id: i, number: number, fill: fill, color: color, shape: shape))
                        i += 1
                    }
                }
            }
        }
        cards = cards.shuffled()
        for index in 0..<cards.count {
            cards[index].id = index
        }
        for index in 0...11 {
            cards[index].isShowing = true
            showingCards.append(cards[index])
        }
    }
    
    
    func getToBeShownCard() -> Card? {
        for (index, _) in cards.enumerated() {
            if !cards[index].isShowing && !cards[index].isInSet {
                return cards[index]
            }
        }
        return nil
    }
    
    fileprivate mutating func replaceMatchedCards() {
        for (index, card) in showingCards.enumerated() {
            if card.isInSet {
                cards[showingCards[index].id].isShowing = false
                showingCards[index] = getToBeShownCard()!
                cards[showingCards[index].id].isShowing = true
            }
        }
    }
    
    mutating func selectCard(card: Card) {
        if isSelectedCardsInSet {
            isSelectedCardsInSet = false
            replaceMatchedCards()
            return
        }

        let selectedCards = showingCards.filter{ $0.isSelected }
        if selectedCards.count >= 3 {
            return
        }
        for index in 0..<showingCards.count {
            if showingCards[index].id == card.id {
                showingCards[index].isSelected = !showingCards[index].isSelected
                break
            }
        }
        cards[card.id].isSelected = !cards[card.id].isSelected
        checkSelectedCards()
    }
    
    mutating func updateShowingCards() {
        for(index, card) in showingCards.enumerated() {
            showingCards[index] = cards[card.id]
        }
    }
    
    func isAllSameOrAllDifferent<T>(_ featureSet : Set<T>) -> Bool {
        return featureSet.count == 1 || featureSet.count == 3
    }
    
    func findMatchingCards() -> [Int] {
        for i in 0..<showingCards.count {
            for j in i+1..<showingCards.count {
                for k in j+1..<showingCards.count {
                    if areThreeCardsInSet(showingCards[i], showingCards[j], showingCards[k]) {
                        return [i, j, k]
                    }
                }
            }
        }
        return []
    }
    
    fileprivate func areThreeCardsInSet(_ card1: GameModel.Card, _ card2: GameModel.Card, _ card3: GameModel.Card) -> Bool {
        let colors : Set<Color> = [card1.color, card2.color, card3.color]
        let numbers : Set<CardNumber> = [card1.number, card2.number, card3.number]
        let fills: Set<CardFillStyle> = [card1.fill, card2.fill, card3.fill]
        let geometries: Set<CardGeometry> = [card1.shape, card2.shape, card3.shape]
        return isAllSameOrAllDifferent(colors) &&
                isAllSameOrAllDifferent(numbers) &&
                isAllSameOrAllDifferent(fills) &&
                isAllSameOrAllDifferent(geometries)
    }
    
    mutating func checkSelectedCards() {
        let selectedCards = cards.filter { $0.isSelected }
        if selectedCards.count != 3 {
            isSelectedCardsInSet = false
            return
        }
        let card1 = selectedCards[0]
        let card2 = selectedCards[1]
        let card3 = selectedCards[2]
        
        isSelectedCardsInSet = areThreeCardsInSet(card1, card2, card3)
        cards[card1.id].isInSet = isSelectedCardsInSet
        cards[card2.id].isInSet = isSelectedCardsInSet
        cards[card3.id].isInSet = isSelectedCardsInSet
        updateShowingCards()
    }
}

