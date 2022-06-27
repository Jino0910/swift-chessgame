//
//  ChessmenKind.swift
//  ChessGame
//
//  Created by jinho on 2022/06/25.
//

import Foundation

typealias ChessmenKind = Chessmen.Kind

extension ChessmenKind {
    
    var score: Int {
        switch self {
        case .pawn:
            return 1
        case .bishop, .knight:
            return 3
        case .luke:
            return 5
        case .queen:
            return 9
        }
    }
    
    func displayIcon(_ color: ChessColor) -> String {
        switch self {
        case .pawn:
            if color == .black {
                return "♟"
            } else {
                return "♙"
            }
        case .bishop:
            if color == .black {
                return "♝"
            } else {
                return "♗"
            }
        case .knight:
            if color == .black {
                return "♞"
            } else {
                return "♘"
            }
        case .luke:
            if color == .black {
                return "♜"
            } else {
                return "♖"
            }
        case .queen:
            if color == .black {
                return "♛"
            } else {
                return "♕"
            }
        }
    }
    
    var ranks: [Int] {
        
        switch self {
        case .pawn:
            return [1, 2, 3, 4, 5, 6, 7, 8]
        case .bishop:
            return [3, 6]
        case .knight:
            return [2, 7]
        case .luke:
            return [1, 8]
        case .queen:
            return [5]
        }
    }
    
    func files(_ color: ChessColor) -> Int {
        
        switch self {
        case .pawn:
            if color == .black {
                return 2
            } else {
                return 7
            }
        case .bishop, .knight, .luke, .queen:
            if color == .black {
                return 1
            } else {
                return 8
            }
        }
    }
    
    var directions: [[DirectionType]] {
        switch self {
        case .pawn:
            return [[.up]]
        case .knight:
            return [[.up, .leftUp], [.up, .rightUp],
                    [.left, .leftUp], [.left, .leftDown],
                    [.down, .leftDown], [.down, .rightDown],
                    [.right, .rightUp], [.left, .rightDown]]
        case .bishop:
            return [[.leftUp], [.leftDown], [.rightUp], [.rightDown]]
        case .luke:
            return [[.up], [.left], [.down], [.right]]
        case .queen:
            return [[.up], [.left], [.down], [.right],
                    [.leftUp], [.leftDown], [.rightUp], [.rightDown]]
        }
    }
    
    var movementDistance: Int {
        switch self {
        case .pawn, .knight:
            return 1
        case .bishop, .luke, .queen:
            return ChessBoard.maxLength
        }
    }
}
