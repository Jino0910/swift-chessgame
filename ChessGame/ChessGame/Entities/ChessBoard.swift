//
//  ChessBoard.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import Foundation

typealias ChessColor = ChessBoard.Color
class ChessBoard {
    
    enum Color: CaseIterable {
        case white
        case black
    }
    
    var positions: ChessmenPosition = [:]
    
    init() {
        
    }
    
    func initializeBoard() {
        positions = createChessmenPositions()
    }
}


extension ChessBoard {
    private func createChessmenPositions() -> [ChessBoardPositionKeys: Chessmen] {
        return ChessmenKind.allCases.map { kind in
            ChessColor.allCases.map { color in
                kind.ranks.map { rank in
                    [ChessBoardPositionKeys(rawValue: "\(rank.lowercased())\(kind.files(color))") ?? .a1:
                        Chessmen(kind: kind, color: color)]
                }.flatMap{ $0 }
            }.flatMap{ $0 }
        }
        .flatMap{ $0 }
        .reduce([:]) { (dic, position) -> [ChessBoardPositionKeys: Chessmen] in
            var dic = dic
            dic[position.key] = position.value
            return dic
        }
    }
}


