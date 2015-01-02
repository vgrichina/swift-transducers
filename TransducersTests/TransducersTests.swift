//
//  TransducersTest.swift
//  Transducers
//
//  Created by Vladimir Grichina on 1/2/15.
//  Copyright (c) 2015 Componentix. All rights reserved.
//

import XCTest

import Transducers

class TransducersTest: XCTestCase {
    func testSimple() {
        let original : [Int] = [1, 2, 3]
        let empty : [Int] = []
        let result : [Int] = transduce(map({$0 * 2 as Int}), append, empty, original)
        
        XCTAssertEqual([2, 4, 6], result)
    }

    func testComplex() {
        let result : [Int] = transduce(
            map({$0 + 1}) |>
            //map({$0 * 2}) |
            map({$0 + 1}), append, [], [1, 2, 3])
        
        XCTAssertEqual([5, 7, 9], result)
    }

    func testPerformanceExample() {
        self.measureBlock() {
            // TODO
        }
    }

}
