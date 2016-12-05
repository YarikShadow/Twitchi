//
//  GameDataServices.swift
//  Twitchi
//
//  Created by Admin on 30.11.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import Foundation
import Alamofire

class GameDataService
{
    static let instance = GameDataService()
    
    var games = [Game]()
    
    func downloadTopGames(completed: @escaping downloadComplete){
        
        var nameString, imageUrlString :String!
        
        let url = TWITCH_URL_TOP_GAME
        
        request(url).responseJSON { (response) in
            print(response)
            if let JSON = response.result.value as? [String: Any] {
                if let topGamesArray = JSON["top"] as? [[String: Any]], topGamesArray.count > 0 {
                    for i in 0..<topGamesArray.count {
                        if let gameDict = topGamesArray[i]["game"] as? [String: Any] {
                            if let gameName = gameDict["name"] as? String {
                                nameString = gameName
                                
                            }
                            
                            if let boxArt = gameDict["box"] as? [String: Any] {
                                if let imageUrl = boxArt["large"] as? String {
                                    imageUrlString = imageUrl
                                }
                            }
                        }
                        
                        let game = Game(name: nameString , imageUrl: imageUrlString)
                            self.games.append(game)
                        }
                    }
                    
                }
            
            completed()
        }
    }
}
