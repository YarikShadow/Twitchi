//
//  ChannelViewController.swift
//  Twitchi
//
//  Created by Admin on 03.12.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import UIKit
import WebKit

class ChannelViewController: UIViewController {
    
    var stream: Stream!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        
        //http://www.twitch.tv/broadcasterName/embed
        let urlString = TWITCH_URL_EMBED_BASE + stream.broadcasterName + TWITCH_URL_EMBED
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    
}
