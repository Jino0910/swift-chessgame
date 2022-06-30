//
//  SquareView.swift
//  ChessGame
//
//  Created by jinho on 2022/06/29.
//

import Foundation
import UIKit

class SquareView: UILabel {
    
    var key: ChessBoardPositionKey? {
        didSet {
            self.backgroundColor = key?.diplayColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }

    init(key: ChessBoardPositionKey,
         displayIcon: String) {
        self.key = key

        super.init(frame: .zero)

        self.layer.backgroundColor = key.diplayColor.cgColor
        self.layer.borderWidth = 0
        self.font = .systemFont(ofSize: 30)
        self.textAlignment = .center
        self.text = displayIcon
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateIcon(with icon: String?) {
        self.text = icon
    }
    
    func updateBorderColor(_ color: UIColor) {
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
    }
    
    func clearBorderColor() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
