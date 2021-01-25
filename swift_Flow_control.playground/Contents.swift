import UIKit
import Foundation

// ---- while
//while 조건 {
//
//}

//var i = 0
//while i < 10{
//    print(i)
//    i += 1
//}


//var i = 0
//print("---while")
//while i < 10{
//    print(i)
////    if i == 5{
////        break
////    }
//    i += 1
//}
//
//print("---repeat")
//i = 0
//repeat {
//    print(i)
//    i += 1
//} while i < 10
//let closedRange = 0...10
//let halfClosedRange = 0..<10
//

// ----- For
//var sum = 0
//for i in closedRange{
//    print("--->\(i)")
//    sum += i
//}
//
//print("---> total sum: \(sum)")
//
//
//var sinValue: CGFloat = 0
//for i in closedRange{
//    sinValue = sin(CGFloat.pi/4 * CGFloat(i))
//}
//
//let name = "Jason"
//
//for _ in closedRange{
//    print(name)
//}
//
//for i in closedRange{
//    if i%2 == 0{
//        print(i)
//    }
//}
//
//for i in closedRange where i % 2 == 0 {
//    print(i)
//}
//for i in closedRange{
//    if(i == 3){
//        continue
//    }
//    print("continue -- \(i)")
//}
//
//for i in closedRange where i != 3{
//    print(i)
//}
//
//for i in closedRange{
//    for j in closedRange{
//        print(i*j)
//    }
//}

//--- switch

//let num = 10
//
//switch num {
//case 0:
//    print("0")
//case 0...10:
//    print("0 ~ 10 사이")
//case 10:
//    print("10")
//default:
//    print("나머지입니다.")
//}
//
//let pet = "bird"
//
//switch pet {
//case "dog", "cat", "bird":
//    print("집동물")
//default:
//    print("잘모르겠습니다.")
//}

let num = 5
switch num {
case _ where num % 2 == 0:
    print("짝수")
default:
    print("홀수")
}


//let coordinate = (x: -1, y:10)
//
//switch coordinate{
//case (0,0):
//    print("원점")
//case (_,0):
//    print("x축이네요")
//case (0,_):
//    print("y축이네요")
//default:
//    print("좌표어딘가")
//}

let coordinate = (x: 10, y:10)

switch coordinate{
case (0,0):
    print("원점")
case (let x,0):
    print("x축이네요 x:\(x)")
case (0,let y):
    print("y축이네요, y:\(y)")
case (let x, let y) where x==y:
    print("좌표어딘가 x,y가 같음 x:\(x), y:\(y)")
case (let x, let y) :
    print("좌표어딘가 x:\(x), y:\(y)")
}
