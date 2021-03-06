//
//  NetworkingTests.swift
//  NetworkStoreTests
//
//  Created by MAC on 22/01/2021.
//

import XCTest
@testable import Hotels_Guide

class NetworkingTests: XCTestCase {

    var sut:NetworkFetcher!
    override func setUp() {
        sut = NetworkFetcher()
    }
    override func tearDown() {
        sut = nil
    }

    func testFeachingHotels(){
        let expectation = self.expectation(description: "feackingHotels")

        sut.execute(EndPoint.hotels.urlRequest) { (result:Result<Hotels, DataStoreError>) in
            
            switch result{
            case .failure(_):
                XCTAssertTrue(false)
            case .success(let hotels):XCTAssertNotNil(hotels)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
