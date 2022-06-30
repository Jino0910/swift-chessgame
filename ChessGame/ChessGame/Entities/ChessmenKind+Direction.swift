//
//  ChessmenKind+Direction.swift
//  ChessGame
//
//  Created by jinho on 2022/06/27.
//

import Foundation

extension Chessmen {

    func moveablePosition(_ currentPositionKey: ChessBoardPositionKey,
                          allPath: Bool = true) -> [[ChessBoardPositionKey]] {

        var positionKeys = [[ChessBoardPositionKey]]()

        // 방향별로 갈 수 있는 정보값을 얻음(2중배열)
        self.kind.directions.forEach { directionTypes in
            var currentPositionKey = currentPositionKey
            var newPositionKeys = [ChessBoardPositionKey]()
            directionTypes.forEach { type in
                newPositionKeysFromType(currentPositionKey: &currentPositionKey,
                                        newPositionKeys: &newPositionKeys,
                                        directionType: type)
            }
            
            // 점프하는 체스말의 경로를 삭제함
            if !allPath && kind == .knight{
                removeJumpPathFromknight(newPositionKeys: &newPositionKeys)
            }
            
            if newPositionKeys.count > 0 {
                positionKeys.append(newPositionKeys)
            }
        }

        return positionKeys
    }
    
    func newPositionKeysFromType(currentPositionKey: inout ChessBoardPositionKey,
                                 newPositionKeys: inout [ChessBoardPositionKey],
                                 directionType: DirectionType){

        // 체스판내부에서 갈 수 있는 칸을 배열로 얻음
        for _ in 1...kind.movementDistance {
            if let newPositionKey = currentPositionKey.movedPositionKeys(color: color,
                                                                         direction: directionType) {
                newPositionKeys.append(newPositionKey)
                currentPositionKey = newPositionKey
            } else {
                continue
            }
        }
    }
    
    func removeJumpPathFromknight(newPositionKeys: inout [ChessBoardPositionKey]) {
        if newPositionKeys.count > 0 {
            newPositionKeys.removeFirst()
        }
        
    }
}
