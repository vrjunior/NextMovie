//
//  iTunesMovie.swift
//  NextMovie
//
//  Created by Valmir Junior on 21/11/18.
//  Copyright © 2018 Valmir Junior. All rights reserved.
//

import Foundation

struct ItunesMovie {
    
    let trackName: String?
    let trackCensoredName: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let releaseDate: Date?
    let trackTimeMillis: Int?
    let longDescription: String?
    let hasITunesExtras: String?
}

extension ItunesMovie: Codable { }
