import UIKit

// 1. 강의 이름, 강사 이름, 학생수를 가지는 Struct aksemfrl
// 2. 가의 어레이와 강사 이름을 받아서, 해당 강사의 강의 이름을 출력하는 함수 만들기
// 3. 강의 3개를 만들고 강사이름으로 강의 찾기

struct Lecture{
    let lectureName: String
    let teacherName: String
    let studentNum: Int
}

func printLecture(lectures: [Lecture], name: String){
    var lectureName = ""
    for lecture in lectures{
        if lecture.teacherName == name {
            lectureName = lecture.lectureName
        }
    }
//    let lecureName = lectures.first { lecture in
//        return lecture.teacherName == name
//    }?.lectureName ?? ""
    print(lectureName)
}

let lecture1 = Lecture(lectureName: "ios", teacherName: "정도현", studentNum: 10)
let lecture2 = Lecture(lectureName: "android", teacherName: "배승은", studentNum: 20)
let lecture3 = Lecture(lectureName: "python", teacherName: "홍지중", studentNum: 15)

let lectureArr = [lecture1, lecture2, lecture3]
printLecture(lectures: lectureArr, name: "홍지중")
