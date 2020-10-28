//
//  ViewControllerTests.swift
//  AskAngelaTests
//
//  Created by The App Experts on 28/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import XCTest
@testable import AskAngela

class ResolutionsViewControllerTests: XCTestCase {
    private var sut: ResolutionsViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ResolutionsViewController") as? ResolutionsViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.resolutionsTableView)
        XCTAssertNotNil(sut.resolutionsArray)
        
    }
}
