//
//  Quake.swift
//  Quakes
//
//  Created by Jon Bash on 2020-01-16.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

// muse use subclass of NSObject to work with MapKit
class Quake: NSObject, Decodable {
    // magnitude
    // place
    // time
    // coordinates
    let magnitude: Double
    let place: String
    let time: Date
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case place
        case time
        case latitude
        case longitude

        // containers
        case properties
        case geometry
        case coordinates
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let properties = try container
            .nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
        var coordinates = try container
            .nestedContainer(keyedBy: CodingKeys.self, forKey: .geometry)
            .nestedUnkeyedContainer(forKey: .coordinates)

        self.magnitude = try properties.decode(Double.self, forKey: .magnitude)
        self.place = try properties.decode(String.self, forKey: .place)
        self.time = Date(timeIntervalSince1970:
            (try properties.decode(Double.self, forKey: .time)) / 1000)
        self.longitude = try coordinates.decode(Double.self)
        self.latitude = try coordinates.decode(Double.self)

        super.init()
    }
}

// MARK: - Quake Results

struct QuakeResults: Decodable {
    let features: [Quake]
}
