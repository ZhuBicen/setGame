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
        
        init(_ id: Int, _ number : CardNumber, _ fillStyle : CardFillStyle, _ color : Color, _ shape : CardGeometry) {
            self.id = id
            self.number = number
            self.fill = fillStyle
            self.color = color
            self.shape = shape
        }
    }
    
    var cards : Array<Card> = []
    var isSelectedCardsInSet = false
    var showingCardsIds : [Int] = []
    
    
    init() {
        var i : Int = 0
        for number in CardNumber.allCases {
            for fill in CardFillStyle.allCases {
                for color in [Color.red, Color.green, Color.purple] {
                    for shape in CardGeometry.allCases {
                        cards.append(Card(i, number, fill, color, shape))
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
            showingCardsIds.append(index)
        }
    }
    mutating func showMoreCards() {
        for _ in 0...2 {
            let card = getToBeShownCard()
            if card != nil {
                showingCardsIds.append(card!.id)
            }
        }
    }
    fileprivate func isCardShowing(_ card : Card) -> Bool {
        self.showingCardsIds.contains(card.id)
    }
    
    func getToBeShownCard() -> Card? {
        for (index, _) in cards.enumerated() {
            if !isCardShowing(cards[index]) && !cards[index].isInSet {
                return cards[index]
            }
        }
        return nil
    }
    
    fileprivate mutating func replaceMatchedCards() {
        for (cardIdIndex, cardId) in showingCardsIds.enumerated() {
            let card = cards[cardId]
            if card.isInSet {
                cards[cardId].isSelected = false
                let card = getToBeShownCard()!
                showingCardsIds[cardIdIndex] = card.id
            }
        }
    }
    
    mutating func selectCard(card: Card) {
        if isSelectedCardsInSet {
            isSelectedCardsInSet = false
            replaceMatchedCards()
            return
        }

        let selectedCards = cards.filter{ $0.isSelected }
        if selectedCards.count >= 3 {
            for card in selectedCards {
                cards[card.id].isSelected = false
            }
        }
        print("Touch card id:", card.id)
        cards[card.id].isSelected = !cards[card.id].isSelected
        checkSelectedCards()
    }
    
    func getShowingCards() -> Array<Card>{
        var showingCards : [Card] = []
        for cardId in showingCardsIds {
            showingCards.append(cards[cardId])
        }
        for card in showingCards {
            print("Showing card:", card.id, card.isSelected)
        }
        print("=============")
        return showingCards
    }
    
    func isAllSameOrAllDifferent<T>(_ featureSet : Set<T>) -> Bool {
        return featureSet.count == 1 || featureSet.count == 3
    }
    
    func findMatchingCards() -> [Int] {
        let showingCards = getShowingCards()
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
    }
}

