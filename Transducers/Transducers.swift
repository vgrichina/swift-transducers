//
//  Transducers.swift
//  Transducers
//
//  Created by Vladimir Grichina on 1/2/15.
//  Copyright (c) 2015 Componentix. All rights reserved.
//

import Foundation

public func append<a>(var arr : [a], x : a) -> [a] {
    arr.append(x)
    return arr
}

public func transduce<a, b, c>(tfn : ((c, b) -> c) -> (c, a) -> c, rfn : (c, b) -> c, initial : c, arr : [a]) -> c {
    return reduce(arr, initial, tfn(rfn))
}

public func map<a, b, c>(fn : (a) -> b) -> ((c, b) -> c) -> (c, a) -> c {
    func transducer(combine : (c, b) -> c) -> (c, a) -> c { // ?
        func combiner(result : c, x : a) -> c {
            return combine(result, fn(x))
        }
        return combiner
    }
    return transducer
}

infix operator |> { associativity left precedence 80 }
public func |> <a, b, c>(fn1 : (a) -> b, fn2 : (b) -> c) -> (a) -> c {
    func result(x : a) -> c {
        return fn2(fn1(x))
    }
    return result;
}