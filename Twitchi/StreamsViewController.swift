//
//  StreamsViewController.swift
//  Twitchi
//
//  Created by Admin on 03.12.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import UIKit

class StreamsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var streamsTableView: UITableView!
    
    var game : Game!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(game.gameName.replacingOccurrences(of: "Optional(", with: ""))"

        // Do any additional setup after loading the view.
        
        streamsTableView.delegate = self
        streamsTableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        StreamDataService.instance.downloadStreamsForGame(game) {
            for stream in StreamDataService.instance.streams {
                stream.downloadStreamImage {
                    self.streamsTableView.reloadData()
                }
                
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        StreamDataService.instance.removeAllStreams()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StreamDataService.instance.streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = streamsTableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath ) as? StreamCell
        {
            
            let stream = StreamDataService.instance.streams[indexPath.row]
            cell.configureCell(stream)
            return cell
            
        } else {
            
            return StreamCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (streamsTableView.bounds.width / 16) * 9
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stream = StreamDataService.instance.streams[indexPath.row]
        
        openStream(stream)
    }
    
    //Handler func to open choosen stream
    func openStream(_ stream: Stream) {
        let alert = UIAlertController(title: "Open stream in Twitchi or in official Twitch app ?", message: "Official must be install for later option", preferredStyle: .alert)
        
        let openInTwitchiAction = UIAlertAction(title: "Twitchi", style: .default) { (action) in
            self.performSegue(withIdentifier: "channelShowVC", sender: stream)
        }
        
        let openInTwitchAppAction = UIAlertAction(title: "TwitchApp", style: .default) {(action) in
            self.openWithTwitchApp(stream)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(openInTwitchiAction)
        alert.addAction(openInTwitchAppAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "channelShowVC"{
            if let channelVC = segue.destination as? ChannelViewController {
                if let stream = sender as? Stream {
                    channelVC.stream = stream
                }
            }
    }
    }
        //MARK: Mobile deep link
    
        func openWithTwitchApp(_ stream: Stream) {
            let streamString = TWITCH_URL_STREAM_DEEP_LINK + stream.broadcasterName
            
            if let streamURL = URL(string: streamString) {
                
                if UIApplication.shared.canOpenURL(streamURL) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(streamURL, options: [:], completionHandler: nil)
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
            }
            
        }
}
