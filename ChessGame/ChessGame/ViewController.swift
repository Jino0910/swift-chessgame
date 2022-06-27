//
//  ViewController.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
//        let chessBoard = ChessBoard()
//        chessBoard.initializeBoard()
        
        let expectPawnPositionKeys: [[ChessBoardPositionKeys]] = [[.a6]]
        
        let moveablePositionKeys = Chessmen(kind: .pawn,
                                      color: .white).moveablePosition(.a7)

    }


}

