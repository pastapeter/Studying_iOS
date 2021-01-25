import UIKit

//struct Grade {
//    var letter: Character
//    var points: Double
//    var credits: Double
//}
//
//class Person {
//    var firstName: String
//    var lastName: String
//
//    init(firstName: String, lastName: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//    }
//
//    func printMyName() {
//        print("My name is \(firstName) \(lastName)")
//    }
//}
//
//class Student: Person {
//    var grades: [Grade] = []
//}

//let jay = Person(firstName: "jay", lastName: "Lee")
//let peter = Student(firstName: "peter", lastName: "Chung")
//
//jay.firstName
//peter.firstName
//
//jay.printMyName()
//peter.printMyName()
//
//let math = Grade(letter: "B", points: 8.5, credits: 3)
//let history = Grade(letter: "A", points: 10.0, credits: 4)
//peter.grades.append(math)
//peter.grades.append(history)
//
//print(peter.grades.count)
//
//struct Grade {
//    var letter: Character
//    var points: Double
//    var credits: Double
//}
//
//class Person {
//    var firstName: String
//    var lastName: String
//
//    init(firstName: String, lastName: String) {
//        self.firstName = firstName
//        self.lastName = lastName
//    }
//
//    func printMyName() {
//        print("My name is \(firstName) \(lastName)")
//    }
//}
//
//class Student: Person {
//    var grades: [Grade] = []
//}
//
//// 학생인데 운동선수
//class StudentAthelete: Student {
//    var minimumTrainingTime: Int = 2
//    var trainedTime: Int = 0
//
//    func train(){
//        trainedTime += 1
//    }
//}
//
//// 운동선수인데 축구선수
//class FootballPlayer: StudentAthelete {
//    var footballTeam = "FC Swift"
//
//    override func train() {
//        trainedTime += 2
//    }
//}
//
////Person > Student > Athelete > Football Player
//
//var athlete1 = StudentAthelete(firstName: "Yuna", lastName: "Kim")
//var athlete2 = FootballPlayer(firstName: "Heungmin", lastName: "Son")
//
//athlete1.firstName
//athlete2.firstName
//
////athlete1.grades.append(math)
////athlete2.grades.append(math)
//
//athlete1.minimumTrainingTime
//athlete2.minimumTrainingTime
//
//athlete2.footballTeam
//athlete2.train()
//athlete1.train()
//athlete2.train()
//athlete1.train()
//
//athlete2.trainedTime
//athlete1.trainedTime
//
//athlete1 = athlete2 as StudentAthelete //uppercast
//athlete1.train()
//athlete1.trainedTime
//
//if let son = athlete1 as? FootballPlayer {
//    print("---> team: \(son.footballTeam)")
//}

/*상속할 때 - 단일 책임원칙 / 타입이 분명해야할 때 /  다자녀가 있을때,(shared Base class)
 확장성이 필요한 경우 / 정체를 파악하기 위해 /
 코드에 대한 근거를 남겨라
 */


struct Grade {
    var letter: Character
    var points: Double
    var credits: Double
}

class Person {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func printMyName() {
        print("My name is \(firstName) \(lastName)")
    }
}

class Student: Person {
    var grades: [Grade] = []
    
    override init(firstName: String, lastName: String) {
        super.init(firstName: firstName, lastName: lastName)
    }
    
    convenience init(student: Student) {
        self.init(firstName: student.firstName, lastName: student.lastName )
    }
}

// 학생인데 운동선수
class StudentAthelete: Student {
    var minimumTrainingTime: Int = 2
    var trainedTime: Int = 0
    var sports: [String]
    
    init(firstName: String, lastName: String, sports: [String]) {
        // Phase1
        self.sports = sports // 이거 먼저
        super.init(firstName: firstName, lastName: lastName) // 그다음하는것
        // 자식클래스의 프로퍼티부터 생성되어야함
        
        //phase2
        self.train()
    }
    
    
    convenience init(name: String) {
        self.init(firstName: name, lastName: "", sports: [])
    }
    
    func train(){
        trainedTime += 1
    }
}

// 운동선수인데 축구선수
class FootballPlayer: StudentAthelete {
    var footballTeam = "FC Swift"
    
    override func train() {
        trainedTime += 2
    }
}

let student1 = Student(firstName: "Jason", lastName: "Lee")
let newstudent = Student(student: student1)
let student2 = StudentAthelete(firstName: "Jay", lastName: "Lee", sports: ["Football"])
let student3 = StudentAthelete(name: "Mike")


// 클래스 생성시 두단계
/*
 phase1
 자식클래스의 프로퍼티부터 생성하고, 부모클래스의 프로퍼티 setting 하는 것임
 phase2
 부모클래스의 프로퍼티까지 세팅 후에, 프로퍼티와 메소드를 사용가능하다.
 
 Di는 자신의 부모의 Di를 호출해야함
 CI는 같은 클래스의 이니셜라이저를 꼭 하나 호출해야한다.
 CI는 궁극적으로 Di를 호출해야한다.
 
 */
