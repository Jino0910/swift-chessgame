//
//  ChessBoard.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import Foundation

typealias ChessmenPosition = [ChessBoardPositionKeys: Chessmen]
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
        positions = createChessmen()
    }
}


extension ChessBoard {
    private func createChessmen() -> [ChessBoardPositionKeys: Chessmen] {
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
    
    func diplayPositionOnConsole() -> String {
        
        let positionKeys: [[ChessBoardPositionKeys]] =
        [
            [.a1, .b1, .c1, .d1, .e1, .f1, .g1, .h1, ],
            [.a2, .b2, .c2, .d2, .e2, .f2, .g2, .h2, ],
            [.a3, .b3, .c3, .d3, .e3, .f3, .g3, .h3, ],
            [.a4, .b4, .c4, .d4, .e4, .f4, .g4, .h4, ],
            [.a5, .b5, .c5, .d5, .e5, .f5, .g5, .h5, ],
            [.a6, .b6, .c6, .d6, .e6, .f6, .g6, .h6, ],
            [.a7, .b7, .c7, .d7, .e7, .f7, .g7, .h7, ],
            [.a8, .b8, .c8, .d8, .e8, .f8, .g8, .h8, ],
        ]
        
        return positionKeys.map { keys in
            keys.map { key -> String in
                if let chessmen = positions[key] {
                    return chessmen.kind.displayIcon(chessmen.color)
                } else {
                    return "."
                }
            }
        }
        .reduce("") { result, diplayIcons in
            return (result.isEmpty ? "" : result + "\n") + diplayIcons.reduce("", { "\($0)\($1)" })
        }
    }
}
