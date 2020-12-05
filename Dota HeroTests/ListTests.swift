//
//  ListTests.swift
//  Dota HeroTests
//
//  Created by Dwi Putra on 04/12/20.
//

import XCTest
@testable import Dota_Hero

class ListTests: XCTestCase {
    let list = ListVM()
    let database = Database()
    let heroID = 999999
    override func setUpWithError() throws {
        database.deleteAllData()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        database.deleteAllData()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSaveAndFetchDB(){
        let listHero = ListHero()
        listHero.id = heroID
        database.save([listHero])
        let hero = database.fetch(ListHero.self)
        
        XCTAssertEqual(hero.last?.id, heroID)
    }
    
    func testDeleteDB(){
        let listHero = ListHero()
        listHero.id = heroID
        database.save([listHero])
        database.delete(ListHero.self, with: heroID)
        let hero = database.fetch(ListHero.self)
        
        XCTAssertNotEqual(hero.last?.id, heroID)
    }
    
    func testListFilterFound(){
        let listHero = ListHero()
        listHero.id = heroID
        let arr = ["Carry", "Escape", "Nuker"]
        listHero.roles.append(objectsIn: arr)
        let listHero1 = ListHero()
        listHero1.id = heroID+1
        let arr1 = ["Carry", "Escape", "Initiator"]
        listHero1.roles.append(objectsIn: arr1)
        database.save([listHero,listHero1])
        
        list.fetchList(withRole: "Initiator")
        
        XCTAssertEqual(list.data.first?.id, heroID+1)
    }
    
    func testListFilterNil(){
        let listHero = ListHero()
        listHero.id = heroID
        let arr = ["Carry", "Escape", "Nuker"]
        listHero.roles.append(objectsIn: arr)
        let listHero1 = ListHero()
        listHero1.id = heroID+1
        let arr1 = ["Carry", "Escape", "Initiator"]
        listHero1.roles.append(objectsIn: arr1)
        database.save([listHero,listHero1])
        
        list.fetchList(withRole: "Jungler")
        
        XCTAssertNil(list.data.first?.id)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
