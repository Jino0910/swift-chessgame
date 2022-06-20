//
//  ChessBoard.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import Foundation

class ChessBoard {
    
    var turned: User.Color = .white
    var whiteUser: User?
    var blackUser: User?
    
    init() {
        
    }
    
    func initialBoard() {
        
        turned = .white
        
        // 체크말 생성
        initialChessBoard()
    }
    
    private func initialChessBoard() {
        
        // 화이트
        whiteUser = User(color: .white,
                         chessmens: createChessmen(color: .white))
        
        
        // 블랙
        blackUser = User(color: .black,
                         chessmens: createChessmen(color: .black))
    }
}

extension ChessBoard {
    
    private func createChessmen(color: User.Color) -> [Chessmen] {
        
        return [Chessmen.Kind.pawn,
                Chessmen.Kind.knight,
                Chessmen.Kind.bishop,
                Chessmen.Kind.luke,
                Chessmen.Kind.queen].map { kind in
            
            Chessmen.ranks(kind)
                .map{ Chessmen(kind: kind,
                               location: "\($0)\(Chessmen.files(kind, color: color))",
                               color: color) }
        }.flatMap{ $0 }
    }
}
