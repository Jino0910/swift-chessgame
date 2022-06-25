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
    
    var ranks: [String] {
        
        switch self {
        case .pawn:
            return ["A", "B", "C", "D", "E", "F", "G", "H"]
        case .bishop:
            return ["C", "F"]
        case .knight:
            return ["B", "G"]
        case .luke:
            return ["A", "H"]
        case .queen:
            return ["E"]
        }
    }
    
    func files(_ color: ChessColor) -> String {
        
        switch self {
        case .pawn:
            if color == .black {
                return "2"
            } else {
                return "7"
            }
        case .bishop, .knight, .luke, .queen:
            if color == .black {
                return "1"
            } else {
                return "8"
            }
        }
    }
}
