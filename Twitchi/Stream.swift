//
//  Stream.swift
//  Twitchi
//
//  Created by Admin on 03.12.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//


import UIKit
import Alamofire

class Stream {
    
    var broadcasterName: String!
    var streamTitle: String!
    var streamViewerCount: Double!
    var streamImage: UIImage?
    var streamImageUrl: String!
    
    init(name: String, title: String, viewerCount : Double, imageUrl: String) {
        self.broadcasterName = name
        self.streamTitle = title
        self.streamViewerCount = viewerCount
        self.streamImageUrl = imageUrl
    }
    
    func downloadStreamImage(completed: @escaping downloadComplete){
        request(self.streamImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.streamImage = image
                }
            }
            
            completed()
        }
    
    }
}
