//
//  Diamond.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/6.
//

import SwiftUI

struct CardShape: Shape {
    var card : GameViewModel.Card
    
    func path(in rect: CGRect) -> Path {
        var p : Path
        switch card.shape {
        case .diamond:
            p = createDiamond(rect)
        case .curv:
            p = createCurv(rect)
        case .roundedRectangle:
            p = createRoundedRectangle(rect)
        }
        return p
    }
    
    func createDiamond(_ rect: CGRect) -> Path {
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: bottom)
        p.addLine(to: right)
        p.addLine(to: top)
        p.closeSubpath()
        return p
    }
    
    func createCurv(_ rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.closeSubpath()
        return p
    }
    
    func createRoundedRectangle(_ rect: CGRect) -> Path {
        RoundedRectangle(cornerRadius: rect.height).path(in: rect)
    }
}


// https://stackoverflow.com/questions/62040461/swiftui-mask-a-rectangle-inside-a-rounded-rectangle
struct GridRectangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        if rect.isEmpty { // Don't know why
            return Path()
        }
        var p = Path()
        for x in stride(from: rect.minX, to: rect.maxX, by: (1/30) * rect.width) {
            p.move(to: CGPoint(x: x, y: rect.minY))
            p.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        return p
    }
}
