//
//  StreamCell.swift
//  Twitchi
//
//  Created by Admin on 03.12.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import UIKit

class StreamCell: UITableViewCell {
    
    @IBOutlet weak var streamImageView: UIImageView!
    @IBOutlet weak var broadcasterName: UILabel!
    @IBOutlet weak var streamTitle: UILabel!
    @IBOutlet weak var streamViewers: UILabel!
    
    func configureCell(_ stream: Stream) {
        broadcasterName.text = stream.broadcasterName
        streamTitle.text = stream.streamTitle
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        streamViewers.text = "\(formatter.string(from: NSNumber(value: stream.streamViewerCount))!) viewers"
        
        if stream.streamImage != nil {
            streamImageView.image = stream.streamImage
            
            
        }
    }

}
