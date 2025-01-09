//
//  pokedexUITestsLaunchTests.swift
//  pokedexUITests
//
//  Created by Prakash Koukuntla on 12/23/24.
//

import XCTest

final class pokedexUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // After app launch but before taking a screenshot

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
