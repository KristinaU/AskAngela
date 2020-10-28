//
//  ViewControllerTests.swift
//  AskAngelaTests
//
//  Created by The App Experts on 28/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import XCTest
@testable import AskAngela

class ArchiveViewControllerTests: XCTestCase {
    private var sut: ArchiveViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ArchiveViewController") as? ArchiveViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.archiveTableView)
        XCTAssertNotNil(sut.archivedNotesArray)
        
    }
}
