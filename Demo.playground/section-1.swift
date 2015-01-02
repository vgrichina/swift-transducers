// Playground - noun: a place where people can play

import Transducers


let original : [Int] = [1, 2, 3]
let empty : [Int] = []
let result : [Int] = transduce(map({$0 * 3}), append, empty, original)

result