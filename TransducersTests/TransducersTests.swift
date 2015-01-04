//
//  TransducersTest.swift
//  Transducers
//
//  Created by Vladimir Grichina on 1/2/15.
//  Copyright (c) 2015 Componentix. All rights reserved.
//

import XCTest

//import Transducers

class TransducersTest: XCTestCase {
    func testSimple() {
        let result = transduce(map({$0 * 2 as Int}), append, [], [1, 2, 3])
        
        XCTAssertEqual([2, 4, 6], result)
    }

    func testComplex() {
        let result = transduce(
            map({$0 + 1}) |>
            map({$0 * 2}) |>
            map({$0 + 1}), append, [], [1, 2, 3])
        
        XCTAssertEqual([5, 7, 9], result)
    }

    func testPerformanceExampleSimple() {
        let arr : [Int] = map(1...100_000, {$0})
        self.measureBlock() {
            var mapped = map(arr, {$0 + 1})
            let result = reduce(mapped, 0, {$0 + $1})
        }
    }

    func testPerformanceExampleSimpleTransducer() {
        let arr : [Int] = map(1...100_000, {$0})
        self.measureBlock() {
            let result = transduce(map({$0 + 1}), {$0 + $1}, 0, arr)
        }
    }

    func testPerformanceExampleComplex() {
        let arr : [Int] = map(1...100_000, {$0})
        self.measureBlock() {
            var mapped = map(arr, {$0 + 1})
            var mapped2 = map(mapped, {$0 * 2})
            var mapped3 = map(mapped2, {$0 + 1})
            let result = reduce(mapped3, 0, {$0 + $1})
        }
    }

    func testPerformanceExampleComplexTransducer() {
        let arr : [Int] = map(1...100_000, {$0})
        self.measureBlock() {
            let result = transduce(
                map({$0 + 1}) |>
                map({$0 * 2}) |>
                map({$0 + 1}),
                {$0 + $1}, 0, arr)
        }
    }

}
