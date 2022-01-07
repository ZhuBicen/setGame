//
//  ContentView.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/6.
//

import SwiftUI

enum CardGeometry {
    case diamond
    case rectangle
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
    var shape = CardGeometry.diamond
}

struct ContentView: View {
    var contents : Array<Card> = [Card(id: 0, number: CardNumber.one, fill:0, color: Color.red),
                                  Card(id: 1, number: CardNumber.two, fill:0, color: Color.green),
                                  Card(id: 2, number: CardNumber.three, fill:0, color: Color.purple),
                                  Card(id: 3, number: CardNumber.one, fill:0, color: Color.red),
                                  Card(id: 4, number: CardNumber.two, fill:0, color: Color.green),
                                  Card(id: 5, number: CardNumber.three, fill:0, color: Color.purple)]
    
    var body: some View {
        AspectVGrid(items: contents, aspectRatio: 55/87) { item in
            CardView(card: item).padding(3)
        }.foregroundColor(.red)
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
                            Diamond(card : card).foregroundColor(card.color)
                            Spacer(minLength: geometry.size.width * (7/55))
                        }
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
                                Diamond(card : card).stroke(lineWidth: 4)
                                Spacer(minLength: geometry.size.height * (5/85))
                                Diamond(card : card).stroke(lineWidth: 4)
                            }
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
                                Diamond(card : card).stroke(lineWidth: 4)
                                Spacer(minLength: geometry.size.height * (5/85))
                                Diamond(card : card).stroke(lineWidth: 4)
                                Spacer(minLength: geometry.size.height * (5/85))
                                Diamond(card : card).stroke(lineWidth: 4)
                            }
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
