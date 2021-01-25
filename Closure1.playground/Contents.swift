import UIKit

var multiplyClosure1: (Int, Int) -> Int = { (a: Int, b: Int)-> Int in return a * b
}

var multiplyClosure2: (Int, Int) -> Int = {return $0 * $1}

var multiplyClosure3: (Int, Int) -> Int = { a, b in return a * b
}

let result1  = multiplyClosure1(4, 2)
let result2  = multiplyClosure2(4, 2)
let result3  = multiplyClosure3(4, 2)

func operateTwoNum(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    let result = operation(a, b)
    return result
}

operateTwoNum(a: 4, b: 2, operation: multiplyClosure3)

var addClosure: (Int, Int) -> Int = { a, b in return a + b}

operateTwoNum(a: 4, b: 2, operation: addClosure)

operateTwoNum(a: 4, b: 2){ a, b in
    return a/b}

let voidClosure: () -> Void = {
    print("iOS 개발자 짱")
}

voidClosure()


// Capturing Values

var count = 0

let incrementer = {
    count += 1
}

incrementer()
incrementer()
incrementer()
incrementer()
incrementer()

count


// completion block - 비동기적인 경우, 해당 일이 끝나고 수행이 필요할떄, 그 데이터에 대한 일을 closure를 사용함
// higher order Functions - 함수를 인자로 받을 수 있는 함수가 있을 때, 파라미터를 바로 closure로 사용

// cloure 포맷
//{(parameters) -> return type in statements }


