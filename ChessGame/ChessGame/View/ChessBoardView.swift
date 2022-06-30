//
//  ChessBoardView.swift
//  ChessGame
//
//  Created by jinho on 2022/06/29.
//

import Foundation
import UIKit

protocol ChessBoardViewDelegate: AnyObject {
    func clickSquareView(positionKey: ChessBoardPositionKey)
}

class ChessBoardView: UIStackView {
    
    let boardSizeWidth = (UIScreen.main.bounds.width-20)/8
    var rankStackView = [UIStackView]()
    weak var delegate: ChessBoardViewDelegate?
    var positions: [ChessBoardPositionKey: SquareView?] = [:]

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func initialize(positionkeys: [[ChessBoardPositionKey]],
                    position: ChessmenPosition) {
        
        positionkeys.forEach { keys in
            let rankStackView = horizontalStackView()
            keys.forEach { key in
                let squareView = self.squareView(with: key,
                                                 displayIcon: position[key]?.displayIcon ?? "")
                positions[key] = squareView
                addTapGestureRecognizer(squareView)
                rankStackView.addArrangedSubview(squareView)
            }
            self.addArrangedSubview(rankStackView)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChessBoardView {

    func moveChessmenIcon(selectedPositionKey: ChessBoardPositionKey,
                          movePositionKey: ChessBoardPositionKey) {
        if let selectedSquareView = positions[selectedPositionKey] as? SquareView,
           let moveSquareView = positions[movePositionKey] as? SquareView {
            moveSquareView.updateIcon(with: selectedSquareView.text)
            selectedSquareView.updateIcon(with: "")
        }
    }
    
    
    func updateSelectedPositionBorderOnSquareView(key: ChessBoardPositionKey) {
        if let squareView = positions[key] as? SquareView {
            squareView.updateBorderColor(.blue)
        }
    }
    
    func updateMoveablePositionBorderOnSquareView(keys: [ChessBoardPositionKey]) {
        keys.forEach { key in
            if let squareView = positions[key] as? SquareView {
                squareView.updateBorderColor(.orange)
            }
        }
    }
    
    func cleanupAllSquareViewBoarderColor() {
        positions.forEach {
            $0.value?.clearBorderColor()
        }
    }
}

extension ChessBoardView {
    
    func horizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }
    
    func squareView(with key: ChessBoardPositionKey,
                    displayIcon: String) -> SquareView {
        let view = SquareView(key: key,
                              displayIcon: displayIcon)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(lessThanOrEqualToConstant: boardSizeWidth),
            view.heightAnchor.constraint(lessThanOrEqualToConstant: boardSizeWidth),
        ])
        
        return view
    }
    
    func addTapGestureRecognizer(_ view: SquareView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSquare(sender:)))
        view.addGestureRecognizer(tap)
    }
}

extension ChessBoardView {
    
    @objc func didTapSquare(sender: UITapGestureRecognizer) {
        if let view = sender.view as? SquareView,
           let key = view.key {
            delegate?.clickSquareView(positionKey: key)
        }
    }
}
