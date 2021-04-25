import UIKit

//func overload(price: Int, count: Int){
//    print("\(price*count)")
//}
//
//func overload(price: Double, count: Double){
//    print("\(price*count)")
//}
//
//func overload(가격: Int, 갯수: Int){
//    print("\(가격*갯수)")
//}

// in out parameter

var value = 3

func incrementAndPrint(_ value: inout Int){
    value += 1
    print(value)
}
incrementAndPrint(&value)


// ---- Function as a param
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func subtract(_ a: Int, _ b: Int) -> Int{
    return a - b
}

var function = add
function(2,4)
function = subtract
function(4,2)

func printResult(_ function:(Int, Int) -> Int, _ a: Int, _ b: Int){
    let result = function(a, b)
    print(result)
}
printResult(add, 10, 5)
printResult(subtract, 10, 5)
