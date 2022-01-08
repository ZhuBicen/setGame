//
//  ContentView.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/6.
//

import SwiftUI

enum CardGeometry {
    case diamond
    case roundedRectangle
    case curv
}

enum CardNumber {
    case one
    case two
    case three
}

enum CardFillStyle {
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
    
}

struct ContentView: View {
    var cards : Array<Card> = [Card(id: 0, number: CardNumber.one, fill:.solid, color: Color.red, shape: .diamond),
                               Card(id: 1, number: CardNumber.two, fill:.empty, color: Color.green, shape: .curv),
                               Card(id: 2, number: CardNumber.three, fill:.grid, color: Color.purple, shape:.roundedRectangle),
                               Card(id: 3, number: CardNumber.one, fill:.solid, color: Color.red, shape: .diamond),
                               Card(id: 4, number: CardNumber.two, fill:.empty, color: Color.green, shape: .curv),
                               Card(id: 5, number: CardNumber.three, fill:.grid, color: Color.purple, shape: .roundedRectangle)]
    
    var body: some View {
        AspectVGrid(items: cards, aspectRatio: 55/87) { item in
            CardView(card: item).padding(3)
        }
    }
}

// https://stackoverflow.com/questions/56786163/swiftui-how-to-draw-filled-and-stroked-shape


struct CardView: View {
    var card : Card
    
    @ViewBuilder
    func fillCard()  -> some View {
        switch card.fill {
        case .grid:
            CardShape(card: card)
        case .empty:
            CardShape(card: card).stroke(lineWidth: 3)
        case .solid:
            CardShape(card: card).fill()
        }

    }
    
    var body : some View {
        let cardEdge = RoundedRectangle(cornerRadius: 5).stroke(lineWidth: 2).foregroundColor(.red)
        

        
        GeometryReader { geometry in
            switch card.number {
            case .one:
                ZStack {
                    cardEdge
                    VStack {
                        Spacer(minLength: geometry.size.height * (34/85))
                        HStack {
                            Spacer(minLength: geometry.size.width * (7/55))
                            fillCard()
                            Spacer(minLength: geometry.size.width * (7/55))
                        }.foregroundColor(card.color)
                        Spacer(minLength: geometry.size.height * (35/87))
                    }
                }
            case .two:
                ZStack {
                    cardEdge
                    VStack {
                        Spacer(minLength: geometry.size.height * (21/85))
                        HStack {
                            Spacer(minLength: geometry.size.width * (7/55))
                            VStack {
                                fillCard()
                                Spacer(minLength: geometry.size.height * (5/85))
                                fillCard()
                            }.foregroundColor(card.color)
                            Spacer(minLength: geometry.size.width * (7/55))
                        }
                        Spacer(minLength: geometry.size.height * (21/87))
                    }
                }
                
            case .three:
                ZStack {
                    cardEdge
                    VStack {
                        Spacer(minLength: geometry.size.height * (10/85))
                        HStack {
                            Spacer(minLength: geometry.size.width * (7/55))
                            VStack {
                                fillCard()
                                Spacer(minLength: geometry.size.height * (5/85))
                                fillCard()
                                Spacer(minLength: geometry.size.height * (5/85))
                                fillCard()
                            }.foregroundColor(card.color)
                            Spacer(minLength: geometry.size.width * (7/55))
                        }
                        Spacer(minLength: geometry.size.height * (10/87))
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
