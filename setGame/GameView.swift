//
//  ContentView.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/6.
//

import SwiftUI



struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        AspectVGrid(items: gameViewModel.cards, aspectRatio: 55/87) { item in
            CardView(card: item).padding(3).onTapGesture {
                print("Selected card id: .\(item.id)")
                gameViewModel.selectCard(card: item)
            }
        }
    }
}

// https://stackoverflow.com/questions/56786163/swiftui-how-to-draw-filled-and-stroked-shape


struct CardView: View {
    var card : GameViewModel.Card
    
    @ViewBuilder
    func fillCard()  -> some View {
        ZStack{
            switch card.fill {
            case .grid:
                ZStack {
                    GridRectangle().stroke(lineWidth: 1).clipShape(CardShape(card: card))
                    CardShape(card: card).stroke(lineWidth: 2)
                }
            case .empty:
                CardShape(card: card).stroke(lineWidth: 2)
            case .solid:
                CardShape(card: card).fill()
            }
        }

    }

    func getLineWidth(of card : GameViewModel.Card) -> CGFloat {
        if card.isSelected {
            return 4
        }
        return 2
    }
    
    func getColor(of card : GameViewModel.Card) -> Color {
        if card.isSelected {
            return .red
        }
        return .blue
    }
    
    var body : some View {

        let cardEdge = RoundedRectangle(cornerRadius: 5).stroke(lineWidth: getLineWidth(of: card)).foregroundColor(getColor(of: card))
        
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel()
        GameView(gameViewModel: game)
    }
}
