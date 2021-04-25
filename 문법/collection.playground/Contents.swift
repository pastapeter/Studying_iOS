import UIKit

// Array

var evenNumbers: [Int] = [2, 4, 6, 8]
//let eventNumbers2: Array<Int> = [2, 4, 6, 8]

evenNumbers.append(10)
evenNumbers += [12, 14, 16]
evenNumbers.append(contentsOf: [18, 20])

//let isEmpty = evenNumbers.isEmpty

evenNumbers.count

//print(evenNumbers.first)

//evenNumbers = []
//let firstItem = evenNumbers.last

if let firstElement = evenNumbers.first{
    print("-->first item is \(firstElement)")
}

evenNumbers.min()
evenNumbers.max()

var firstItem = evenNumbers[0]
var secondItem = evenNumbers[1]
var tenthItem = evenNumbers[9]

// ---->

let firstThree = evenNumbers[0...2]
evenNumbers
evenNumbers.contains(3)
evenNumbers.contains(4)

evenNumbers.insert(0, at: 0)

//evenNumbers.removeAll()
evenNumbers.remove(at: 0)
evenNumbers

evenNumbers[0] = -2
evenNumbers

evenNumbers.swapAt(0, 1)
//evenNumbers.swapAt(0, 9)
evenNumbers

evenNumbers[0...2]

//for num in evenNumbers {
//    print(num.)
//}

for (index, num) in evenNumbers.enumerated() {
    print("idx: \(index), value: \(num)")
}

let firstThreeRemoved = evenNumbers.dropFirst(3)
firstThreeRemoved
evenNumbers

let lastRemoved = evenNumbers.dropLast()
lastRemoved

let fthree = evenNumbers.prefix(3)

let lastThree = evenNumbers.suffix(3)


evenNumbers


// 중요 메소드 isEmpty, append, enumerated(), count
