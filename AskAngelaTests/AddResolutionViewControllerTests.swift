//
//  ViewControllerTests.swift
//  AskAngelaTests
//
//  Created by The App Experts on 28/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import XCTest
@testable import AskAngela

class AddResolutionViewControllerTests: XCTestCase {
    private var sut: AddResolutionViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "AddResolutionViewController") as? AddResolutionViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.selectedDays)
        XCTAssertNotNil(sut.resolutionTitle)
        XCTAssertNotNil(sut.resolutionText)
        XCTAssertNotNil(sut.outputLabelText)
        XCTAssertNotNil(sut.weCanDoIt)
        XCTAssertNotNil(sut.selectNotifications)
        
    }
}
