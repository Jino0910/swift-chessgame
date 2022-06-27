//
//  ChessmenKind+Direction.swift
//  ChessGame
//
//  Created by jinho on 2022/06/27.
//

import Foundation

extension Chessmen {
    
    func moveablePosition(_ currentPositionKey: ChessBoardPositionKeys) -> [[ChessBoardPositionKeys]] {
        
        var positionKeys = [[ChessBoardPositionKeys]]()
        
        self.kind.directions.forEach { directionTypes in
            var currentPositionKey = currentPositionKey
            directionTypes.forEach { type in
                var newPositionKeys = [ChessBoardPositionKeys]()
                for _ in 1...kind.movementDistance {
                    if let newPositionKey = currentPositionKey.movedPositionKeys(color: color,
                                                                                 direction: type) {
                        newPositionKeys.append(newPositionKey)
                        currentPositionKey = newPositionKey
                    } else {
                        continue
                    }
                }
                if newPositionKeys.count > 0 {
                    positionKeys.append(newPositionKeys)
                }
            }
        }
        
        return positionKeys
    }
}
