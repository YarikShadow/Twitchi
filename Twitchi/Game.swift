//
//  Game.swift
//  Twitchi
//
//  Created by Admin on 29.11.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import UIKit
import Alamofire

class Game {
    
    var gameName: String!
    var gameImageUrl: String!
    var gameImage: UIImage?
    
    init(name: String , imageUrl: String) {
        self.gameName = name
        self.gameImageUrl = imageUrl
    }
    
    func downloadGameImage(completed: @escaping downloadComplete){
        request(self.gameImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.gameImage = image
                }
            }
            
            completed()
            
        }
        
    }
}
