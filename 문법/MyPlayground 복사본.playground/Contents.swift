import UIKit
// --- comment
//var str = "Hello, playground"
//let val = arc4random_uniform(100)
//print("--> \(val)")


// --- TUPLE

let coordinates = (4,6)

let x = coordinates.0
let y = coordinates.1

let coordinatesNamed = (x:2, y:3)

let x2 = coordinatesNamed.x
let y2 = coordinatesNamed.y


let (x3, y3) = coordinatesNamed

x3
y3


// --- Boolean

let yes = true
let no = false

let isFourGreaterThanFive = 4>5

if isFourGreaterThanFive{
    print("---> true")
}
else {
    print("---> false")
}

let a = 5
let b = 10

if a>b{
    print("---> a가 크다")
}
else{
    print("---> b가 크다")
}

let name1 = "jin"
let name2 = "jason"

let isTwoNameSame = name1 == name2

if isTwoNameSame{
    print("-->이름 같다")
}
else{
    print("notsame")
}

let isJason = name2 == "jason"
let isMale = false

let jasonAndMale = isJason && isMale
let jasonOrMale = isJason || isMale

//let greetingMessage: String
//if isJason{
//    greetingMessage = "Hello Jason"
//}
//else{
//    greetingMessage = "Hello Somebody"
//}
//print("Msg: \(greetingMessage)")

let greetingMessage: String = isJason ? "Hello Jason":"Hello Somebody"
print("Msg: \(greetingMessage)")

func hello(){
    var hours = 50
    let payPerHour = 10000
    var salary = 0

    if hours > 40 {
        let extraHours = hours - 40
        salary += extraHours * payPerHour*2
        hours -= extraHours
    }

    salary += hours * payPerHour
    print(hours, salary)
}

hello()


