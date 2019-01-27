//
//  SongRecord.swift
//  App
//
//  Created by Colin Evans on 2019-01-26.
//

import Foundation
import Vapor

struct SongRecord: Content {
    //var song: String
    //var artist: String
    var count: Int
    var songId: Int
    var artistId: Int
    var state: String
    var style: String
}
