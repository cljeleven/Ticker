//
//  ColumnManangerTest.swift
//  JCTickerTests
//
//  Created by zexi chen on 2022-12-10.
//

//

import XCTest
@testable import JCTicker

final class ColumnManangerTest: XCTestCase {


    func testBasicParsing() throws {
      
        let cm = ColumnManager()
        XCTAssert(cm.targetCol(input: "123456").count == 6)
        XCTAssert(cm.targetCol(input: "1234.56").count == 7)
        XCTAssert(cm.targetCol(input: "1.43456").count == 7)
        
    }

    func testBasicErrorParsing() throws {
         
          let cm = ColumnManager()
          XCTAssert(cm.targetCol(input: "123t456").count == 0)
          XCTAssert(cm.targetCol(input: "12a34.56").count == 0)
          XCTAssert(cm.targetCol(input: "1.4345$6").count == 0)
          
        
    }



}
