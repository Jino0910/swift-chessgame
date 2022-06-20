//
//  User.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import Foundation

class User {
    enum Color {
        case white
        case black
    }
    
    let color: Color
    var chessmens: [Chessmen]
    
    init(color: Color,
         chessmens: [Chessmen]) {
        self.color = color
        self.chessmens = chessmens
    }
}

extension User {
    
    var score: Int {
        chessmens.map{ $0.score }.reduce(0, +)
    }
}
