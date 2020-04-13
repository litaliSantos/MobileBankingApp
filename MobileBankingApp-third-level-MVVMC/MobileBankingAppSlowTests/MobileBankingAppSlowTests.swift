//
//  MobileBankingAppSlowTests.swift
//  MobileBankingAppSlowTests
//
//  Created by Litali Calheiros on 12/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import XCTest

class MobileBankingAppSlowTests: XCTestCase {
    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // Asynchronous test
    //tenho que ver como reutilizar isso mudando a URL
    func testCallToUrlCompletes() {
        // given
        let url = URL(string: "https://desafio-it-server.herokuapp.com/lancamentos")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
