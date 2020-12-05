//
//  APITests.swift
//  Dota HeroTests
//
//  Created by Dwi Putra on 04/12/20.
//

import XCTest
@testable import Dota_Hero
import Alamofire

class APITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIList(){
        let expectation = XCTestExpectation.init(description: "No failure")
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        AF.request(APIRouter.heroList)
            .responseDecodable(of: [ListHero].self, decoder: decoder) { response in
                switch response.result {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    break
                    
                case .success(_):
                    expectation.fulfill()
                    break
                }
            }
        wait(for: [expectation], timeout: 20)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
