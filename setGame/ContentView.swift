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

struct Card : Identifiable {
    var id : Int
    var number : CardNumber
    var fill  : Int
    var color : Color
    var shape : CardGeometry
    
}

struct ContentView: View {
    var cards : Array<Card> = [Card(id: 0, number: CardNumber.one, fill:0, color: Color.red, shape: .diamond),
                               Card(id: 1, number: CardNumber.two, fill:0, color: Color.green, shape: .curv),
                               Card(id: 2, number: CardNumber.three, fill:0, color: Color.purple, shape: .roundedRectangle),
                               Card(id: 3, number: CardNumber.one, fill:0, color: Color.red, shape: .diamond),
                               Card(id: 4, number: CardNumber.two, fill:0, color: Color.green, shape: .curv),
                               Card(id: 5, number: CardNumber.three, fill:0, color: Color.purple, shape: .roundedRectangle)]
    
    var body: some View {
        AspectVGrid(items: cards, aspectRatio: 55/87) { item in
            CardView(card: item).padding(3)
        }
    }
}



struct CardView: View {
    var card : Card
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
                            // foregroundColor not working???
                            CardShape(card : card)
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
                                CardShape(card : card).stroke(lineWidth: 4)
                                Spacer(minLength: geometry.size.height * (5/85))
                                CardShape(card : card).stroke(lineWidth: 4)
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
                                CardShape(card : card).stroke(lineWidth: 4)
                                Spacer(minLength: geometry.size.height * (5/85))
                                CardShape(card : card).stroke(lineWidth: 4)
                                Spacer(minLength: geometry.size.height * (5/85))
                                CardShape(card : card).stroke(lineWidth: 4)
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
