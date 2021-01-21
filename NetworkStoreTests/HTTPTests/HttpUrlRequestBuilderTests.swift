//
//  HttpUrlRequestBuilderTests.swift
//  NetworkStoreTests
//
//  Created by MAC on 21/01/2021.
//

import XCTest
@testable import Hotels_Guide

class HttpUrlRequestBuilderTests: XCTestCase {
    
    var sut:URLRequestBuilder!

    override func setUp() {
        sut = URLRequestBuilder(with: "https://api.github.com", path: "users/KerollosNabil")
    }
    override func tearDown() {
        sut = nil
    }
    
    func testBuilderInitializerAndBuild(){
        let request = try? sut.build()
        
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.absoluteString, "https://api.github.com/users/KerollosNabil")
        
        XCTAssertNoThrow(try sut.build())
    }
    func testRequestMethod_WhenChangeTheMethod(){
        sut.set(method: .post)
        let request = try? sut.build()
        
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.httpMethod, HTTPMethod.post.rawValue)
        
        XCTAssertNoThrow(try sut.build())
    }
    func testRequestURL_WhenChangePath(){
        sut.set(path: "users/Sallen0400")
        let request = try? sut.build()
        
        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.absoluteString, "https://api.github.com/users/Sallen0400")
        
        XCTAssertNoThrow(try sut.build())
    }
    
    func testRequestHeader_WhenSetHeader(){
        let header = [
            
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Host": "api.producthunt.com"
            
        ]
        sut.set(headers: header)
        let request = try? sut.build()
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.allHTTPHeaderFields)
        XCTAssertEqual(request?.allHTTPHeaderFields, header)
        
        XCTAssertNoThrow(try sut.build())
    }
    
    func testRequestParameter_WhenSetParameter(){
        let parameters = [
            "sort_by": "votes_count",
            "order": "desc",
            "per_page": "20",
        ]
        sut.set(parameters: parameters)
        let request = try? sut.build()
        
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        let componets = URLComponents(url: request!.url!, resolvingAgainstBaseURL: false)
        XCTAssertEqual(componets?.queryItems?.count, 3)
        
        XCTAssertNoThrow(try sut.build())
    }

}
