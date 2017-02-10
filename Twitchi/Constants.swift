//
//  Constants.swift
//  Twitchi
//
//  Created by Admin on 25.11.16.
//  Copyright © 2016 Yaroslav. All rights reserved.
//

import Foundation
// https://api.twitch.tv/kraken
// ID     hj5b3zg9rm03vtfakb27w7cbzx3vsgx
// Twitch API url's

let TWITCH_URL_TOP_GAME = "https://api.twitch.tv/kraken/games/top?limit=50&client_id=hj5b3zg9rm03vtfakb27w7cbzx3vsgx"

let TWITCH_URL_STREAMS_BASE = "https://api.twitch.tv/kraken/streams?game="
let TWITCH_URL_STREAMS_CLIENT_ID = "&client_id=hj5b3zg9rm03vtfakb27w7cbzx3vsgx"

let TWITCH_URL_EMBED_BASE = "https://www.twitch.tv/"
let TWITCH_URL_EMBED = "/embed"

let TWITCH_URL_STREAM_DEEP_LINK = "twitch://open?stream="

typealias downloadComplete = () -> ()
