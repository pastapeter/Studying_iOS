import UIKit

// 스위프트는 다중상속을 지원하지 않습니다.
// 클래스의 상속

// MARK: 클래스의 상속과 재정의
// class 이름: 상속받을 클래스 이름 {구현부}

class Person{
    var name: String = ""
    
    func selfIntroduce(){
        print("i'm \(name)")
    }
    // final keyword provent override
    final func sayHello(){
        print("hello")
    }
    
    //static cannnot be overridden
    static func typeMethod(){
        print("type method - static")
    }
    
    class func classMethod(){
        print("type method - class")
    }
    
    final class func finalclassMethod(){
        print("type method - final class")
    }
}

class Student: Person {
    var major: String=""
    override func selfIntroduce() {
            print("i'm \(name) and my major is \(major)")
        }
    override class func classMethod() {
        print("overriden type method - class")
    }
}

let dohyun: Person = Person()
let hana: Student = Student()

dohyun.name = "dohyun"
hana.name = "hana"
hana.major = "Swift"

dohyun.selfIntroduce()
hana.selfIntroduce()
Person.classMethod()
Person.typeMethod()
Person.finalclassMethod()
Student.classMethod()
Student.typeMethod()
Student.finalclassMethod()
