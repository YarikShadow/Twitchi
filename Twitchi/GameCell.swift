//
//  GameCell.swift
//  Twitchi
//
//  Created by Admin on 25.11.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var gameImageView: UIImageView!
    
    func congigurateCell( game: Game) {
        if game.gameImage != nil {
            gameImageView.image = game.gameImage
            gameImageView.layer.cornerRadius = 10
            gameImageView.layer.masksToBounds = true
        }
    }
    
}
