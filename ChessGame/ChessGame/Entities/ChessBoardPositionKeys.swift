//
//  ChessBoardPositionKeys.swift
//  ChessGame
//
//  Created by jinho on 2022/06/25.
//

import Foundation

internal enum ChessBoardPositionKeys: String, Hashable {
    
    case a1
    case a2
    case a3
    case a4
    case a5
    case a6
    case a7
    case a8
    
    case b1
    case b2
    case b3
    case b4
    case b5
    case b6
    case b7
    case b8
    
    case c1
    case c2
    case c3
    case c4
    case c5
    case c6
    case c7
    case c8
    
    case d1
    case d2
    case d3
    case d4
    case d5
    case d6
    case d7
    case d8
    
    case e1
    case e2
    case e3
    case e4
    case e5
    case e6
    case e7
    case e8
    
    case f1
    case f2
    case f3
    case f4
    case f5
    case f6
    case f7
    case f8
    
    case g1
    case g2
    case g3
    case g4
    case g5
    case g6
    case g7
    case g8
    
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case h7
    case h8
}

typealias ChessmenPosition = [ChessBoardPositionKeys: Chessmen]

extension ChessmenPosition {
    var diplayPositionOnConsole: String {
        
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
                if let chessmen = self[key] {
                    return chessmen.kind.displayIcon(chessmen.color)
                } else {
                    return "."
                }
            }
        }
        .reduce("") { result, diplayIcons in
            (result.isEmpty ? "" : result + "\n") + diplayIcons.reduce("", { "\($0)\($1)" })
        }
    }
}