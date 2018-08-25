//
//  Learn_iOsTests.swift
//  Learn iOsTests
//
//  Created by Andrey Rybakin on 25/08/2018.
//  Copyright © 2018  Andrew. All rights reserved.
//

import XCTest
@testable import Learn_iOs

class Learn_iOsTests: XCTestCase {
    // MARK: Meas Class Tests
    
    //Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testMealInitializationSuccess() {
        // Zero rating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest positive rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    func testMealInitializationFails() {
        // Negative Rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // Empty Name
        let emptyNameMeal = Meal.init(name: "", photo: nil, rating: 4)
        XCTAssertNil(emptyNameMeal)
        
        // Rating Exceeds Maximum
        let exceedsMaximumRatingMeal = Meal.init(name: "ExceedsMax", photo: nil, rating: 6)
        XCTAssertNil(exceedsMaximumRatingMeal)
    }
}
