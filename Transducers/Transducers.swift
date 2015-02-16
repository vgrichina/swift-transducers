//
//  Transducers.swift
//  Transducers
//
//  Created by Vladimir Grichina on 1/2/15.
//  Copyright (c) 2015 Componentix. All rights reserved.
//

import Foundation

public struct Transducer<AccumType, ElemType1, ElemType2> {
    typealias Fn1 = (AccumType, ElemType1) -> AccumType
    typealias Fn2 = (AccumType, ElemType2) -> AccumType
    typealias TFn = Fn2 -> Fn1

    public let call : TFn
}

public func append<a>(var arr : [a], x : a) -> [a] {
    arr.append(x)
    return arr
}

public func transduce<AccumType, ElemType1, ElemType2> (
        tfn : Transducer<AccumType, ElemType1, ElemType2>,
        rfn : (AccumType, ElemType2) -> AccumType,
    initial : AccumType, arr : [ElemType1]) -> AccumType {

    return reduce(arr, initial, tfn.call(rfn))
}

public func map<AccumType, ElemType1, ElemType2>(fn : ElemType1 -> ElemType2) -> Transducer<AccumType, ElemType1, ElemType2> {

    return Transducer { combine in
        return { result, elem in
            return combine(result, fn(elem))
        }
    }
}


public func filter<AccumType, ElemType>(fn : ElemType -> Bool) -> Transducer<AccumType, ElemType, ElemType> {

    return Transducer { combine in
        return { result, elem in
            if (fn(elem)) {
                return combine(result, elem)
            }
            return result
        }
    }
}

infix operator |> { associativity left precedence 80 }

public func |> <AccumType, ElemType1, ElemType2, ElemType3>(
        t1 : Transducer<AccumType, ElemType1, ElemType2>,
        t2 : Transducer<AccumType, ElemType2, ElemType3>) -> Transducer<AccumType, ElemType1, ElemType3> {

    return Transducer { combine in t1.call(t2.call(combine)) }
}
