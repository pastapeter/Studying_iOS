//
//  main.swift
//  closure
//
//  Created by abc on 2021/08/03.
//

import Foundation

func biggerOne(_ a: Int, _ b: Int) -> Int? {
    if a == b {
        return nil
    } else if a>b {
        return a
    } else {
        return b
    }
}

//var someClosure : (Int, Int) -> Int? = biggerOne(_:_:)
//
//someClosure = {(left: Int, right: Int) in
//
//    someClosure(left, right)
//}
//print(someClosure(2,3)!)




//var someClosure : (Int, Int) -> Int? = biggerOne(_:_:)
//someClosure = {[someClosure](left: Int, right: Int) in
//    someClosure(left, right)
//}
//print(someClosure(2,3)!)

var c = 0
var d = 0
var smartClosure: () -> () = { [c,d] in   print(c,d)}
smartClosure()

c = 6
d = 9
//let smartClosure = {[c,d] in print(c,d)}
smartClosure()
