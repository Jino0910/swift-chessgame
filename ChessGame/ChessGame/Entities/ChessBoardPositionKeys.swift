//
//  ChessBoardPositionKeys.swift
//  ChessGame
//
//  Created by jinho on 2022/06/25.
//

import Foundation

enum ChessBoardPositionKeys: Int, Hashable {
    
    case a1 = 11
    case a2 = 12
    case a3 = 13
    case a4 = 14
    case a5 = 15
    case a6 = 16
    case a7 = 17
    case a8 = 18
    
    case b1 = 21
    case b2 = 22
    case b3 = 23
    case b4 = 24
    case b5 = 25
    case b6 = 26
    case b7 = 27
    case b8 = 28
    
    case c1 = 31
    case c2 = 32
    case c3 = 33
    case c4 = 34
    case c5 = 35
    case c6 = 36
    case c7 = 37
    case c8 = 38
    
    case d1 = 41
    case d2 = 42
    case d3 = 43
    case d4 = 44
    case d5 = 45
    case d6 = 46
    case d7 = 47
    case d8 = 48
    
    case e1 = 51
    case e2 = 52
    case e3 = 53
    case e4 = 54
    case e5 = 55
    case e6 = 56
    case e7 = 57
    case e8 = 58
    
    case f1 = 61
    case f2 = 62
    case f3 = 63
    case f4 = 64
    case f5 = 65
    case f6 = 66
    case f7 = 67
    case f8 = 68
    
    case g1 = 71
    case g2 = 72
    case g3 = 73
    case g4 = 74
    case g5 = 75
    case g6 = 76
    case g7 = 77
    case g8 = 78
    
    case h1 = 81
    case h2 = 82
    case h3 = 83
    case h4 = 84
    case h5 = 85
    case h6 = 86
    case h7 = 87
    case h8 = 88
    
    static func makeKeys(rank: Int,
                         file: Int) -> ChessBoardPositionKeys? {
        ChessBoardPositionKeys(rawValue: rank*10 + file)
    }
}

typealias DirectionType = ChessBoardPositionKeys.DirectionType

extension ChessBoardPositionKeys {
    enum DirectionType {
        case up
        case leftUp
        case left
        case leftDown
        case down
        case rightDown
        case right
        case rightUp
    }
    
    func movedPositionKeys(color: ChessColor,
                           direction: DirectionType) -> ChessBoardPositionKeys? {
        
        var rank = self.rawValue.rank
        var file = self.rawValue.file

        switch direction {
        case .up:
            file.up(color)
        case .leftUp:
            file.up(color)
            rank.left()
        case .left:
            rank.left()
        case .leftDown:
            file.down(color)
            rank.left()
        case .down:
            file.down(color)
        case .rightDown:
            file.down(color)
            rank.right()
        case .right:
            rank.right()
        case .rightUp:
            file.up(color)
            rank.right()
        }
        
        return ChessBoardPositionKeys.makeKeys(rank: rank,
                                               file: file)
    }
}


extension Int {
    var rank: Int {
        (self % 100) / 10
    }
    
    var file: Int {
        self % 10
    }
    
    mutating func up(_ color: ChessColor){
        switch color {
        case .black:
            self += 1
        case .white:
            self -= 1
        }
    }
    
    mutating func left() {
        self -= 1
    }
    
    mutating func right() {
        self += 1
    }
    
    mutating func down(_ color: ChessColor) {
        switch color {
        case .black:
            self -= 1
        case .white:
            self += 1
        }
    }
}


