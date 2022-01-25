//
//  ContentView.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/6.
//

import SwiftUI



struct GameView: View {
    @ObservedObject var gameViewModel: GameViewModel
    @State var hint : String = ""
    
    var body: some View {
        VStack {
            AspectVGrid(items: gameViewModel.getShowingCards(), aspectRatio: 55/87) { item in
                CardView(card: item, isInSet: gameViewModel.isCardInSet(card: item), isSelected: gameViewModel.isCardSelected(card: item))
                    .padding(3)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        gameViewModel.selectCard(card: item)
                    }
            }
            HStack {
                Text(hint)
            }
            HStack {
                if gameViewModel.isCardInDeck {
                    deal3MoreCards
                }
                Spacer()
                matchCards
                Spacer()
                newGame
                Spacer()
            }

        }
    }
    var deal3MoreCards : some View {
        VStack {
            Button(action: {
                gameViewModel.showMoreCards()
            }, label:{
               Image(systemName: "plus.circle.fill")
        })
            Text("Deal 3 more cards").font(.subheadline)
        }
    }
    var newGame : some View {
        VStack {
            Button(action: {
                gameViewModel.newGame()
                hint = ""
            }, label:{
               Image(systemName: "plus.circle.fill")
        })
            Text("New Game").font(.subheadline)
        }
    }
    var matchCards : some View {

        VStack {
            Button(action: {
                hint = gameViewModel.hint()
            }, label:{
               Image(systemName: "s.circle.fill")
        })
            Text("Match Cards").font(.subheadline)
        }
    }
}
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-control-the-tappable-area-of-a-view-using-contentshape
// https://stackoverflow.com/questions/63154815/why-doesnt-swiftui-ontapgesture-always-work
// https://stackoverflow.com/questions/56786163/swiftui-how-to-draw-filled-and-stroked-shape

// https://zhuanlan.zhihu.com/p/147475930

// https://stackoverflow.com/questions/43815549/ios-how-to-pass-a-model-from-view-model-to-view-model-using-mvvm/43820233
struct CardView: View {
    var card : GameViewModel.Card
    var isInSet : Bool
    var isSelected : Bool
    
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
        if isSelected {
            return 4
        }
        return 2
    }
    
    func getColor(of card : GameViewModel.Card) -> Color {
        if isInSet {
            return .orange
        }
        if isSelected {
            return .red
        }
        return .blue
    }
    
    @ViewBuilder
    func buildCardBackground(of card : GameViewModel.Card) -> some View {
        if isInSet {
            RoundedRectangle(cornerRadius: 5).fill().foregroundColor(.green).opacity(0.3)
        } else {
            RoundedRectangle(cornerRadius: 5).stroke(lineWidth: getLineWidth(of: card)).foregroundColor(getColor(of: card)).opacity(0.3)
        }
    }
    
    var body : some View {

        let cardBackground = buildCardBackground(of: card)
        GeometryReader { geometry in
            switch card.number {
            case .one:
                ZStack {
                    cardBackground
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
                    cardBackground
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
                    cardBackground
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
