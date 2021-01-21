//
//  URLEncoderTests.swift
//  NetworkStoreTests
//
//  Created by MAC on 21/01/2021.
//

import XCTest
@testable import Hotels_Guide

class URLEncoderTests: XCTestCase {

    
    override class func setUp() {
        
    }
    
    override class func tearDown() {
        
    }
    
    func testEncodeParametersFunction_ShouldNotThrowWithEmptyParamters(){
        let request = try! URLRequestBuilder(with: "https://api.github.com", path: "users/KerollosNabil").build()
        let parameters:[String:String] = [:]
        let requestWithParam = try? URLEncoder.encodeParameters(for: request, with: parameters)
        
        XCTAssertNotNil(requestWithParam)
        XCTAssertEqual(requestWithParam?.url, request.url)
        
        XCTAssertNoThrow(try URLEncoder.encodeParameters(for: request, with: parameters))
    }
    func testEncodeParametersFunction_ShouldAddParametersToTheRequestObject(){
        let request = try! URLRequestBuilder(with: "https://api.github.com", path: "users/KerollosNabil").build()
        let parameters = [
            "sort_by": "votes_count",
            "order": "desc",
            "per_page": "20",
        ]
        let requestWithParam = try? URLEncoder.encodeParameters(for: request, with: parameters)
        
        XCTAssertNotNil(requestWithParam)
        XCTAssertNotNil(requestWithParam?.url)
        let componets = URLComponents(url: requestWithParam!.url!, resolvingAgainstBaseURL: false)
        XCTAssertEqual(componets?.queryItems?.count, 3)
        
        XCTAssertNoThrow(try URLEncoder.encodeParameters(for: request, with: parameters))
    }

}
