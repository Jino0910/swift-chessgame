//
//  ViewController.swift
//  ChessGame
//
//  Created by jinho on 2022/06/20.
//

import UIKit

class ViewController: UIViewController {
    
    let manager = ChessManager.shared
    
    let whiteScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    let blackScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
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
        
        addSubViews()
        
        newGame()
        boardView.delegate = self
    }
    
    func addSubViews() {
        view.addSubview(boardView)
        view.addSubview(whiteScoreLabel)
        view.addSubview(blackScoreLabel)
        
        NSLayoutConstraint.activate([
            boardView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                             constant: -20),
            boardView.heightAnchor.constraint(equalTo: view.widthAnchor,
                                              constant: -20),
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            whiteScoreLabel.leadingAnchor.constraint(equalTo: boardView.leadingAnchor),
            whiteScoreLabel.bottomAnchor.constraint(equalTo: boardView.topAnchor,
                                               constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            blackScoreLabel.trailingAnchor.constraint(equalTo: boardView.trailingAnchor),
            blackScoreLabel.bottomAnchor.constraint(equalTo: boardView.topAnchor,
                                               constant: -20),
        ])
        
    }
    
    
    func newGame() {
        manager.newGame()
        boardView.initialize(positionkeys: manager.chessBoard.positions.chessmenPositions,
                             position: manager.chessBoard.positions)
        self.updateScore()
        
    }
    
    func updateScore() {
        let scores = manager.chessBoard.gameScore()
        whiteScoreLabel.text = "White \(scores.0)"
        blackScoreLabel.text = "\(scores.1) Black"
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
                updateScore()
            case let .move(selectedPositionKey, movePositionKey):
                boardView.moveChessmenIcon(selectedPositionKey: selectedPositionKey,
                                           movePositionKey: movePositionKey)
                boardView.cleanupAllSquareViewBoarderColor()
            default: break
            }
        }


    }
}
