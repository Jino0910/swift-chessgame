//
//  ViewController.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import UIKit

class ViewController: UIViewController {
    
    let manager = ChessManager.shared
    
    let boardView: ChessBoardView = {
        let boardView = ChessBoardView()
        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.axis = .vertical
        boardView.alignment = .fill
        boardView.spacing = 0
        boardView.layer.borderWidth = 1
        boardView.layer.borderColor = UIColor.black.cgColor
        
        return boardView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        subviewChessView()
        
        newGame()
        boardView.delegate = self
        boardView.initialize(positionkeys: manager.chessBoard.positions.chessmenPositions,
                             position: manager.chessBoard.positions)
        
    }
    
    func subviewChessView() {
        view.addSubview(boardView)
        NSLayoutConstraint.activate([
            boardView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                             constant: -20),
            boardView.heightAnchor.constraint(equalTo: view.widthAnchor,
                                              constant: -20),
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    func newGame() {
        manager.newGame()
    }
}

extension ViewController: ChessBoardViewDelegate {
    func clickSquareView(positionKey: ChessBoardPositionKey) {
        let positionKey = positionKey
        manager.chessBoard.clickedChessmen(key: positionKey) { noSelected in
            switch noSelected {
            case .me(let keys):
                boardView.updateSelectedPositionBorderOnSquareView(key: positionKey)
                boardView.updateMoveablePositionBorderOnSquareView(keys: keys)
            default: break
            }
        } hasSelectedHandler: { hasSelected in
            switch hasSelected {
            case .same:
                boardView.cleanupAllSquareViewBoarderColor()
            case let .enemy(selectedPositionKey, movePositionKey):
                boardView.moveChessmenIcon(selectedPositionKey: selectedPositionKey,
                                           movePositionKey: movePositionKey)
                boardView.cleanupAllSquareViewBoarderColor()
            case let .move(selectedPositionKey, movePositionKey):
                boardView.moveChessmenIcon(selectedPositionKey: selectedPositionKey,
                                           movePositionKey: movePositionKey)
                boardView.cleanupAllSquareViewBoarderColor()
            default: break
            }
        }


    }
}
