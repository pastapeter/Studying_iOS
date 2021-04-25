import UIKit

struct Lecture{
    var title: String
    var maxStudent: Int = 10
    var numOfregistered: Int = 0
    
    func remainSeats() -> Int {
        let remainSeats = lec.maxStudent - lec.numOfregistered
        return remainSeats
    }
    
    mutating func register() { //stored property의 값을 변경시키는 함수는 앞에 mutating을 써줘야함
        //등록된 학생수 증가시키기
        numOfregistered += 1
    }
    
    static let target: String = "Anybody want to learn Something"
    
    static func 소속학원이름() -> String {
        return "fast-campus"
    }
}

var lec = Lecture(title: "iOS Basic")




//remainSeats(of: lec)
lec.remainSeats()
lec.register()
lec.register()
lec.register()
lec.register()


lec.remainSeats()
Lecture.target
Lecture.소속학원이름()

struct Math {
    static func abs(value: Int) -> Int {
        if value > 0 {
            return value
        }
        else {
            return -value
        }
    }
}
Math.abs(value: -20)

//제곱, 반값,
extension Math {
    static func square(value: Int) -> Int {
       return value * value
    }
    static func half(value: Int) -> Int {
        return value / 2
    }
}

var value: Int = 3

extension Int {
    func square() -> Int {
        return self * self
    }
    func half() -> Int {
        return self / 2
    }
}

value.square()
value.half()
