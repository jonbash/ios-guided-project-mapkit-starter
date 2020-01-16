//
//  QuakesTests.swift
//  QuakesTests
//
//  Created by Paul Solt on 10/31/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import XCTest
@testable import Quakes

class QuakesTests: XCTestCase {

    let kFPAccuracy = 0.001

    func testQuakeJSONParsing() {
        // red, green, refactor
        // - red = write failing test
        // - green = refactor, clean up until passing
        // - refactor = clean up code or reorganize
        // repeat

        let decoder = JSONDecoder()
        // below not needed; handled in init(from decoder:)
//        decoder.dateDecodingStrategy = .millisecondsSince1970
        do {
            let quake = try decoder.decode(Quake.self, from: quakeData)
            let date = Date(timeIntervalSince1970: 1388620296020 / 1000)
            // Test(Expected, Actual)
            XCTAssertEqual(1.29, quake.magnitude, accuracy: kFPAccuracy)
            XCTAssertEqual("10km SSW of Idyllwild, CA", quake.place)
            XCTAssertEqual(date, quake.time)
            XCTAssertEqual(-116.7776667, quake.longitude, accuracy: kFPAccuracy)
            XCTAssertEqual(33.663333299999998, quake.latitude, accuracy: kFPAccuracy)
        } catch {
            XCTFail("Error decoding: \(error)")
        }
    }
}
