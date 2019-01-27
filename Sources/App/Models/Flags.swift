//
//  Flags.swift
//  App
//
//  Created by Colin Evans on 2019-01-26.
//

import Foundation
import Vapor

/// Convertible to / from content in an HTTP message.
struct Flags: Content {
    var startDate: String
    var endDate: String
    var state: String? // could be sent as nil if lat and long are sent
}
