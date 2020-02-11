//
//  Unit4AssessmentTests.swift
//  Unit4AssessmentTests
//
//  Created by Alex Paul on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import XCTest
@testable import Unit4Assessment

class Unit4AssessmentTests: XCTestCase {
    
    func testCardsModel() {
        // arrange
        // grab json and validate in jsonlint.com
        // we are testing first article

        let jsonData = """
{
"cardListType": "q and a",
"apiVersion": "1.2.3",
"cards": [
    {
        "id": "1",
        "cardTitle": "What is the difference between a synchronous & an asynchronous task?",
        "facts": [
            "Synchronous: waits until the task have completed.",
            "Asynchronous: completes a task in the background and can notify you when complete."
        ]
    }
]
}
""".data(using: .utf8)!
        
        let expectedCardTitle = "What is the difference between a synchronous & an asynchronous task?"
        
        // act
        do {
            let structOfCards = try
                JSONDecoder().decode(StructOfCards.self, from: jsonData)
            
            // assert
            let supTitle = structOfCards.cards.first?.cardTitle ?? ""
            XCTAssertEqual(expectedCardTitle, supTitle)
        } catch {
            XCTFail("decoding error: \(error)")
        }
    }
}
