//
//  ViewControllerTests.swift
//  AskAngelaTests
//
//  Created by The App Experts on 28/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import XCTest
@testable import AskAngela

class ViewControllerTests: XCTestCase {
    private var sut: ViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.mainTextView)
        XCTAssertNotNil(sut.mainTableView)
        XCTAssertNotNil(sut.showJoke())
        
    }
}
