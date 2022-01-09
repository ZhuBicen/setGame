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
    
}
