//
//  setGameApp.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/6.
//

import SwiftUI

@main
struct setGameApp: App {
    var body: some Scene {
        WindowGroup {
            let gameViewModel = GameViewModel()
            GameView(gameViewModel: gameViewModel)
        }
    }
}
