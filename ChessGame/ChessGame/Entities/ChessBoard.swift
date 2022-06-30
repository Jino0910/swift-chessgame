//
//  ChessBoard.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import Foundation
import AudioToolbox

enum NoSelectedChessmen {
    case me([ChessBoardPositionKey])
    case enemy
    case nothing
}

enum HasSelectedChessmen {
    case same
    case move(selectedPositionKey: ChessBoardPositionKey,
              movePositionKey: ChessBoardPositionKey)
    case enemy(selectedPositionKey: ChessBoardPositionKey,
               movePositionKey: ChessBoardPositionKey)
    case blocked
    case cannot
}

typealias ChessColor = ChessBoard.Color
class ChessBoard {
    
    static let maxLength = 8
    var turn: Color = .white
    var selectedPositionKey: ChessBoardPositionKey?
    
    enum Color: CaseIterable {
        case white
        case black
    }
    
    var positions: ChessmenPosition = [:]
    
    func initializeBoard() {
        turn = .white
        positions = createChessmenPositions()
    }
}

extension ChessBoard {
    
    func gameScore() -> (Int, Int) {
        let whiteScore =
        self.positions.filter{ $0.value.color == .white }
            .map{ $0.value.kind.score }
            .reduce(0, +)
        let blackScore =
        self.positions.filter{ $0.value.color == .black }
            .map{ $0.value.kind.score }
            .reduce(0, +)
        
        return (whiteScore, blackScore)
    }
    
    func clickedChessmen(key: ChessBoardPositionKey,
                         noSelectedHandler:((NoSelectedChessmen)->()),
                         hasSelectedHandler:((HasSelectedChessmen)->())) {
        if let selectedPositionKey = self.selectedPositionKey {
            hasSelectedHandler(hasSelectedChessmenType(movePositionKey: key,
                                                      selectedPositionKey: selectedPositionKey))
        } else {
            noSelectedHandler(noSelectedChessmenType(key: key))
        }
    }
    
    private func hasSelectedChessmenType(movePositionKey: ChessBoardPositionKey,
                                         selectedPositionKey: ChessBoardPositionKey) -> HasSelectedChessmen {
        guard selectedPositionKey != movePositionKey else {
            self.selectedPositionKey = nil
            return .same
        }
        
        if let chessmen = positions[selectedPositionKey],
           let type = moveablePosition(selectedPositionKey: selectedPositionKey,
                                       movePositionKey: movePositionKey,
                                       selectedChessmen: chessmen) {
            return type
        } else {
            viberate()
            return .cannot
        }
    }
    
    private func noSelectedChessmenType(key: ChessBoardPositionKey) -> NoSelectedChessmen {
        if let chessmen = positions[key] {
            if chessmen.color == turn {
                selectedPositionKey = key
                return .me(chessmen.moveablePosition(key, allPath: false).flatMap{ $0 })
            } else {
                viberate()
                return .enemy
            }
        } else {
            return .nothing
        }
    }
    
    private func moveablePosition(selectedPositionKey: ChessBoardPositionKey,
                                  movePositionKey: ChessBoardPositionKey,
                                  selectedChessmen: Chessmen) -> HasSelectedChessmen? {
        let pathPositionKeys = selectedChessmen.moveablePosition(selectedPositionKey).filter{ $0.contains(movePositionKey) }.flatMap{ $0 }
        var type: HasSelectedChessmen?
        
        if let lastIndex = pathPositionKeys.firstIndex(of: movePositionKey) {
            for index in 0...lastIndex {
                let positionKey = pathPositionKeys[index]
                
                if lastIndex == index {
                    if let chessmen = positions[positionKey] {
                        if chessmen.color == turn {
                            viberate()
                            type = .blocked
                        } else {
                            moveChessmen(selectedPositionKey: selectedPositionKey,
                                         movePositionKey: movePositionKey,
                                         chessmen: selectedChessmen)
                            turnOver()
                            type = .enemy(selectedPositionKey: selectedPositionKey,
                                          movePositionKey: movePositionKey)
                        }
                    } else {
                        moveChessmen(selectedPositionKey: selectedPositionKey,
                                     movePositionKey: movePositionKey,
                                     chessmen: selectedChessmen)
                        turnOver()
                        type = .move(selectedPositionKey: selectedPositionKey,
                                     movePositionKey: movePositionKey)
                    }
                } else {
                    if let _ = positions[positionKey] {
                        viberate()
                        type = .blocked
                        break
                    }
                }
            }
        }
        return type
    }
}



extension ChessBoard {
    private func createChessmenPositions() -> [ChessBoardPositionKey: Chessmen] {
        return ChessmenKind.allCases.map { kind in
            ChessColor.allCases.map { color in
                kind.ranks.map { rank in
                    [ChessBoardPositionKey.makeKeys(rank: rank,
                                                     file: kind.files(color)) ?? .a1:
                        Chessmen(kind: kind, color: color)]
                }.flatMap{ $0 }
            }.flatMap{ $0 }
        }
        .flatMap{ $0 }
        .reduce([:]) { (dic, position) -> [ChessBoardPositionKey: Chessmen] in
            var dic = dic
            dic[position.key] = position.value
            return dic
        }
    }
    
    private func viberate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    private func turnOver() {
        turn = (turn == .white) ? .black : .white
        self.selectedPositionKey = nil
    }
    
    private func moveChessmen(selectedPositionKey: ChessBoardPositionKey,
                              movePositionKey: ChessBoardPositionKey,
                              chessmen: Chessmen) {
        positions[selectedPositionKey] = nil
        positions[movePositionKey] = chessmen
        print(positions.diplayPositionOnConsole + "\n")
    }
}


