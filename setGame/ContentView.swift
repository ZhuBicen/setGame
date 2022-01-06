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

struct Card : Identifiable {
    var id : Int
    var number : Int
    var fill  : Int
    var color : Int
    var shape = CardGeometry.diamond
}

struct ContentView: View {
    var contents : Array<Card> = [Card(id: 0, number: 1, fill:0, color: 0),
                             Card(id: 1, number: 2, fill:0, color: 0),
                             Card(id: 2, number: 3, fill:0, color: 0),
                             Card(id: 3, number: 1, fill:0, color: 0),
                             Card(id: 4, number: 2, fill:0, color: 0),
                             Card(id: 5, number: 3, fill:0, color: 0)]
    
    var body: some View {
        AspectVGrid(items: contents, aspectRatio: 2/3) { item in
            CardView(shape: item.shape).padding(3)
        }.foregroundColor(.red)
    }
}



struct CardView: View {
    var shape : CardGeometry
    var body : some View {
        switch shape {
        case .diamond:
            Diamond()
        case .rectangle:
            RoundedRectangle(cornerRadius: 5)
        case .curv:
            RoundedRectangle(cornerRadius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
