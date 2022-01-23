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

    struct Card : Identifiable {
        var id : Int
        var number : CardNumber
        var fill  : CardFillStyle
        var color : Color
        var shape : CardGeometry
        
        init(_ id: Int, _ number : CardNumber, _ fillStyle : CardFillStyle, _ color : Color, _ shape : CardGeometry) {
            self.id = id
            self.number = number
            self.fill = fillStyle
            self.color = color
            self.shape = shape
        }
    }
    
    var deckCards : [Card] = []
    var showingCards : [Card] = []
    var matchedCards : [Card] = []
    
    
    init() {
        var i : Int = 0
        var cards : [Card] = []
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
        for index in 0...11 {
            showingCards.append(cards[index])
        }
        for index in 12..<cards.count {
            deckCards.append(cards[index])
        }
    }
    mutating func showMoreCards() {
        for _ in 0...2 {
            let card = getToBeShownCard()
            if card != nil {
                showingCards.append(card!)
            }
        }
    }
    mutating func replaceMachedCard(_ matchedCard : [Card]) {
        addMatchedCard(matchedCard)
        
        for (index, card) in showingCards.enumerated() {
            if isCardMatched(card) {
                let card = getToBeShownCard()
                if card != nil {
                    showingCards[index] = card!
                }
            }
        }
    }
    
    fileprivate func isCardShowing(_ card : Card) -> Bool {
        showingCards.contains{$0.id == card.id}
    }
    
    fileprivate func isCardMatched(_ card : Card) -> Bool {
        matchedCards.contains{$0.id == card.id}
    }
    
    mutating func getToBeShownCard() -> Card? {
        if deckCards.count != 0 {
            let card = deckCards.first
            deckCards.removeFirst()
            return card
        }
        return nil
    }
    
    mutating func dealThreeMoreCards() -> [Card?] {
        [getToBeShownCard(), getToBeShownCard(), getToBeShownCard()]
    }

    
    mutating func addMatchedCard(_ cards : [Card]) {
        matchedCards += cards
    }
    
    func getShowingCards() -> Array<Card>{
       showingCards
    }
    
    func isAllSameOrAllDifferent<T>(_ featureSet : Set<T>) -> Bool {
        return featureSet.count == 1 || featureSet.count == 3
    }
    
    func findMatchingCards() -> [Int] {
        for i in 0..<showingCards.count {
            for j in i+1..<showingCards.count {
                for k in j+1..<showingCards.count {
                    if areThreeCardsInSet([showingCards[i], showingCards[j], showingCards[k]]) {
                        return [i, j, k]
                    }
                }
            }
        }
        return []
    }
    
    func areThreeCardsInSet(_ cards : [Card]) -> Bool {
        let card1 = cards[0]
        let card2 = cards[1]
        let card3 = cards[2]
        
        let colors : Set<Color> = [card1.color, card2.color, card3.color]
        let numbers : Set<CardNumber> = [card1.number, card2.number, card3.number]
        let fills: Set<CardFillStyle> = [card1.fill, card2.fill, card3.fill]
        let geometries: Set<CardGeometry> = [card1.shape, card2.shape, card3.shape]
        return isAllSameOrAllDifferent(colors) &&
                isAllSameOrAllDifferent(numbers) &&
                isAllSameOrAllDifferent(fills) &&
                isAllSameOrAllDifferent(geometries)
    }
}

