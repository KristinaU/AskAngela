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

    func test_selectedDaysArray_hasInitiated() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.selectedDays)
        
    }
    
    func test_titleField_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.resolutionTitle)
        
    }
    
    func test_textField_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.resolutionText)
        
    }
    
    func test_label_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.outputLabelText)
        
    }
    
    func test_image_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.weCanDoIt)
        
    }
    
    func test_segmentedControl_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.selectNotifications)
        
    }
    
}
