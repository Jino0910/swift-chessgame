//
//  Chessmen.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import Foundation

class Chessmen {
    enum Kind {
        case pawn
        case knight
        case bishop
        case luke
        case queen
    }
    
    let kind: Kind
    let location: String
    let color: User.Color
    
    init(kind: Kind,
         location: String,
         color: User.Color) {
        self.kind = kind
        self.location = location
        self.color = color
    }
}

extension Chessmen {
    var score: Int {
        switch kind {
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
    
    var displayIcon: String {
        switch kind {
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
                return "♛"
            }
        }
    }
    
    static func ranks(_ kind: Kind) -> [String] {
        
        switch kind {
        case .pawn:
            return ["A", "B", "C", "D", "E", "F", "G", "H"]
        case .bishop:
            return ["C", "F"]
        case .knight:
            return ["A", "H"]
        case .luke:
            return ["B", "G"]
        case .queen:
            return ["E"]
        }
    }
    
    static func files(_ kind: Kind,
                      color: User.Color) -> String {
        
        switch kind {
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


