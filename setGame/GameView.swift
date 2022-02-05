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
    @Namespace var dealingNamespace
    
    @State var dealtCards = Set<Int>()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom){
                gameBody
                deckBody
            }

            HStack {
                Text(hint)
            }
            HStack {
                if gameViewModel.isCardInDeck {
                    deal3MoreCards
                }
                matchCards
                Spacer()
                newGame
            }.padding(.horizontal)

        }
    }
    
    func isCardDealt(_ card: GameViewModel.Card) -> Bool {
        dealtCards.contains(card.id)
    }
    
//    func ZIndex(of card : GameViewModel.Card) -> Double {
//        let newZIndex = Double(gameViewModel.getDeckCards().firstIndex(where:{$0.id == card.id}) ?? 0)
//        gameViewModel.setZIndex(of: card, newZIndex)
//        return newZIndex
//    }
//
    func dealCard(_ card: GameViewModel.Card) {
        dealtCards.insert(card.id)
    }
    
    var gameBody : some View {
        AspectVGrid(items: gameViewModel.getDealtCards(), aspectRatio: 55/87) { item in
            if isCardDealt(item) {
                CardView(card: item, isInSet: gameViewModel.isCardInSet(card: item), isSelected: gameViewModel.isCardSelected(card: item))
                    .matchedGeometryEffect(id: item.id, in: dealingNamespace)
                    .padding(3)
                    .contentShape(Rectangle())
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(-Double(item.id))
                    .onTapGesture {
                        gameViewModel.selectCard(card: item)
                    }
            } else {
                Color.clear
            }
            
        }
//                .onAppear {
//            gameViewModel.dealCards()
//            for (index, card) in (gameViewModel.getDealtCards().enumerated()) {
//                withAnimation(.linear(duration: 2).delay(Double(Double(index) * 1))) {
//                    dealCard(card)
//                    //ZIndex(of: card)
//                }
//            }
//        }
    }
    
    struct GameConstants {
        static let undealtHeight : Double = 120
        static let undealWidth : Double = 120 * (2/3)
    }
    
    var deckBody : some View {
        ZStack {
            ForEach(gameViewModel.getDeckCards()) { card in
                CardView(card: card, isInSet: false, isSelected: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity ))
                    .zIndex(-Double(card.id))

            }
        }
        .frame(width: GameConstants.undealWidth,
               height: GameConstants.undealtHeight,
               alignment: .center)
        .onTapGesture {
                for (index, card) in (gameViewModel.dealMoreCards().enumerated()) {
                    withAnimation(.easeInOut(duration: 1).delay(Double(Double(index) * 0.5))) {
                            dealCard(card)
                        }
                }
        }
    }
    
    var deal3MoreCards : some View {
        VStack {
            Button(action: {
                // gameViewModel.dealMoreCards()
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel()
        GameView(gameViewModel: game)
    }
}
