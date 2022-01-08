//
//  Diamond.swift
//  setGame
//
//  Created by Bicen Zhu on 2022/1/6.
//

import SwiftUI

struct CardShape: Shape {
    var card : Card
    
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



struct GridRectangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        return p
    }
}
