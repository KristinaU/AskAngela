//
//  ViewControllerTests.swift
//  AskAngelaTests
//
//  Created by The App Experts on 28/10/2020.
//  Copyright © 2020 The App Experts. All rights reserved.
//

import XCTest
@testable import AskAngela

class NoteViewControllerTests: XCTestCase {
    private var sut: NoteViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "NoteViewController") as? NoteViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_label_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.outputLabelText)
        
    }
    
    func test_textField_shouldBeConnected() {
        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.noteTextField)
        
    }
    
}
