//
//  StreamDataServices.swift
//  Twitchi
//
//  Created by Admin on 03.12.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import Foundation
import Alamofire


class StreamDataService {
    
    static let instance = StreamDataService()
    
    var streams = [Stream]()
    
    func downloadStreamsForGame(_ game: Game , comleted: @escaping downloadComplete) {
        
        var ViewerCountDouble: Double!
        var ImageUrlString: String!
        var ChannelNameString: String!
        var StatusString: String!
        //GET/Streams
        
        let gameString = game.gameName.replacingOccurrences(of: " ", with: "+")
        let url = TWITCH_URL_STREAMS_BASE + gameString + TWITCH_URL_STREAMS_CLIENT_ID
        
        request(url).responseJSON { (responce) in
            if let JSON = responce.result.value as? [String: Any] {
                if let streamsArray = JSON["streams"] as? [Dictionary<String, Any>], streamsArray.count > 0 {
                    for i in 0..<streamsArray.count {
                        if let viewerCount = streamsArray[i]["viewers"] as? Double {
                            ViewerCountDouble = viewerCount
                        }
                        
                        if let imageDict = streamsArray[i]["preview"] as? [String: Any] {
                            if let imageUrl = imageDict["large"] as? String {
                                ImageUrlString = imageUrl
                            }
                            
                        }
                        
                        if let channelDict = streamsArray[i]["channel"] as? [String: Any]{
                            if let name = channelDict["display_name"] as? String {
                                ChannelNameString = name
                            }
                            
                            if let title =  channelDict["status"] as? String {
                                StatusString = title
                            }
                        }
                        
                        let stream = Stream(name: ChannelNameString, title: StatusString, viewerCount : ViewerCountDouble, imageUrl: ImageUrlString)
                        self.streams.append(stream)
                    }
                }
                
                    
                }
        
        comleted()
        }
    }
    
    func removeAllStreams() {
        streams.removeAll()
        
        
    }
}
