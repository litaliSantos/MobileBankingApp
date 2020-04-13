//
//  MobileBankingAppFakeTests.swift
//  MobileBankingAppFakeTests
//
//  Created by Litali Calheiros on 12/04/20.
//  Copyright © 2020 Litali Calheiros. All rights reserved.
//

import XCTest
@testable import MobileBankingApp

class MobileBankingAppFakeTests: XCTestCase {
    var sut: QueryService!
    
    override func setUp() {
        super.setUp()
        sut = QueryService()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "lancamentos", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url = URL(string: "https://desafio-it-server.herokuapp.com/lancamentos")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        sut.defaultSession = sessionMock
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testUpdateTransactionsResultsParsesData() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        XCTAssertEqual(sut.transactions.count, 0, "transactions should be empty before the data task runs")
        let url = URL(string: sut.getTransactions)
        let dataTask = sut.defaultSession.dataTask(with: url!) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                self.sut.updateTransactions(data!)
            }
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        
        // then
        XCTAssertEqual(sut.transactions.count, 3, "Didn't parse 3 items from fake response")
    }
}
