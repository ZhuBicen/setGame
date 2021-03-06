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
    @Namespace var discardNamespace
    
    @State var dealtCards = Set<Int>()
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                gameBody
                // newGameBody
                HStack {
                    discardPileBody
                    deckBody
                }
            }

            HStack {
                Text(hint)
            }
            HStack {
                matchCards
                newGame
            }.padding(.horizontal)

        }
    }
    
    func isCardDealt(_ card: GameViewModel.Card) -> Bool {
        dealtCards.contains(card.id)
    }
    
    func dealCard(_ card: GameViewModel.Card) {
        dealtCards.insert(card.id)
    }
    
    var gameBody : some View {
        AspectVGrid(items: gameViewModel.getDealtCards(), aspectRatio: 55/87) { item in
            if isCardDealt(item) {
                CardView(card: item)
                    .cardify(id: item.id, isFaceUp: true,
                             isInSet: gameViewModel.isCardInSet(card: item),
                             isSelected: gameViewModel.isCardSelected(card: item))
                    .matchedGeometryEffect(id: item.id, in: dealingNamespace)
                    .matchedGeometryEffect(id: item.id, in: discardNamespace)
                    .padding(3)
                    .contentShape(Rectangle())
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .identity))
                    .zIndex(Double(item.id))
                    .onTapGesture {
                        withAnimation {
                            gameViewModel.selectCard(card: item)
                            for (index, card) in gameViewModel.getDealtCards().filter({ !isCardDealt($0)}).enumerated() {
                                withAnimation(.linear(duration: 0.8).delay(Double(Double(index) * 0.2))) {
                                    dealCard(card)
                                }
                            }
                        }
                    }
            } else {
                Color.clear
            }
            
        }
        .onAppear {
            gameViewModel.dealCards()
            for (index, card) in (gameViewModel.getDealtCards().enumerated()) {
                withAnimation(.linear(duration: 1).delay(Double(Double(index) * 0.2))) {
                    dealCard(card)
                }
            }
        }
    }
    
    var newGameBody : some View {
        VStack {
            ForEach(gameViewModel.getDealtCards().reversed()) { card in
                 if isCardDealt(card) {
                     CardView(card: card)
                         .cardify(id: card.id, isFaceUp: true, isInSet: false, isSelected: false)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                        .zIndex(Double(card.id))
                } else {
                    Color.clear
                }
                
            }
        }
    }
    
    struct GameConstants {
        static let undealtHeight : Double = 120
        static let undealWidth : Double = 120 * (2/3)
    }
    
    var deckBody : some View {
        ZStack {
            ForEach(gameViewModel.getDeckCards().reversed()) { card in
                CardView(card: card)
                    .cardify(id: card.id, isFaceUp: false, isInSet: false, isSelected: false)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity ))
                    .zIndex(-Double(card.id))
                    .rotationEffect(Angle.degrees(card.angle))

            }
        }
        .frame(width: GameConstants.undealWidth,
               height: GameConstants.undealtHeight,
               alignment: .center)
        .onTapGesture {
            var cards : [GameViewModel.Card] = []
            withAnimation(.linear(duration: 1)){
                 cards = gameViewModel.dealMoreCards()
            }
            for card in (cards) {
                withAnimation(.linear(duration: 1).delay(0)) {
                    dealCard(card)
                }
            }
        }
    }
    
    var discardPileBody : some View {
        ZStack {
            ForEach(gameViewModel.getDiscardedCards()) { card in
                CardView(card: card)
                    .cardify(id: card.id, isFaceUp: true, isInSet: false, isSelected: false)
                    .matchedGeometryEffect(id: card.id, in: discardNamespace)
                    // .zIndex(Double(card.id))
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity ))
            }
        }
        .frame(width: GameConstants.undealWidth,
               height: GameConstants.undealtHeight,
               alignment: .center)
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
