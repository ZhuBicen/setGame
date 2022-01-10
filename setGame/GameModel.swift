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
        
    }
    
    var cards : Array<Card> = []
    
    
    init() {
        var allCards : [Card] = []
        var i : Int = 0
        for number in CardNumber.allCases {
            for fill in CardFillStyle.allCases {
                for color in [Color.red, Color.green, Color.purple] {
                    for shape in CardGeometry.allCases {
                        allCards.append(Card(id: i, number: number, fill: fill, color: color, shape: shape))
                        i += 1
                    }
                }
            }
        }
        
        cards = allCards.shuffled()
    }
    
    mutating func selectCard(card: Card) {
        cards[card.id].isSelected = true
    }
    
    mutating func setCard(card1: Card, card2 : Card, card3 : Card) -> Bool {
        let colors : Set<Color> = [card1.color, card2.color, card3.color]
        let numbers : Set<CardNumber> = [card1.number, card2.number, card3.number]
        let fills: Set<CardFillStyle> = [card1.fill, card2.fill, card3.fill]
        let geometries: Set<CardGeometry> = [card1.shape, card2.shape, card3.shape]
        return (colors.count == 1 || colors.count == 3) && (numbers.count == 1 || numbers.count == 3) && (fills.count == 1 || fills.count == 3) && (geometries.count == 1 || geometries.count == 3)
    }
}
