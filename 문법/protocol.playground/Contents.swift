import UIKit

// 프로토콜
// 지켜야할 약속 서비스 이용할 때 해야할 목록

//public protocol CustomStringConvertible{
//    public var description: String {get}
//}

// CustomStringConvertible

struct Lecture: CustomStringConvertible { // 파이썬에 __str__ 이랑 비슷
    var description: String {
        return "Title \(name), Instructor: \(instructor)"
    }
    
    let name: String
    let instructor: String
    let numOfStudent: Int
}

func printLectureName(lectures: [Lecture], from instructor: String){
    var lectureName = ""

    for lecture in lectures{
        if lecture.instructor == instructor{
            lectureName = lecture.name
        }
    }
    print(lectureName)
}

let lecture1 = Lecture(name: "iOS", instructor: "Peter", numOfStudent: 6)
let lecture2 = Lecture(name: "android", instructor: "Wendy", numOfStudent: 6)
let lecture3 = Lecture(name: "Python", instructor: "Jack", numOfStudent: 6)
let lectures = [lecture1, lecture1, lecture3]

printLectureName(lectures: lectures, from: "Peter")
print(lecture1)
