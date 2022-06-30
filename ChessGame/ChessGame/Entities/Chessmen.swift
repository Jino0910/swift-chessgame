//
//  Chessmen.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import Foundation

class Chessmen {
    enum Kind: CaseIterable {
        case pawn
        case knight
        case bishop
        case luke
        case queen
    }
    
    let kind: Kind
    let color: ChessColor
    
    init(kind: Kind,
         color: ChessColor) {
        self.kind = kind
        self.color = color
    }
    
    var displayIcon: String {
        self.kind.displayIcon(color)
    }
}
