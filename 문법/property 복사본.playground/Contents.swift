import UIKit
//property: 호출된 값을 하나 반환한다.
//Method: 호출시 어떤 작업을 한다.
// setter가 있을 경우에는 computed property 사용
// setter가 없을 경우에는 -> 계산이 많이 필요하면 method, DB 액세스나 File 액세스가 필요하면 method
struct Person{
    var firstName: String {
//        willSet{
//            print("willSet: \(firstName) --> \(newValue)")
//        }
        didSet{
            print("didSet: \(oldValue) --> \(firstName)")
        }
    }
    var lastName: String
    
    //lazy property : 나중에 코드가 실행됨 최적화!!!
//    lazy var isPopular: Bool = {
//        if fullName == "Jay Park" {
//            return true
//        }
//        else{
//            return false
//        }
//    }()
    
    //computed property는 var만 가능, readonley
//    var fullName: String {
//        get {
//            return "\(firstName) \(lastName)"
//        }
//        set {
//            if let firstName = newValue.components(separatedBy: " ").first{
//                self.firstName = firstName
//            }
//            if let lastName = newValue.components(separatedBy: " ").last{
//                self.lastName = lastName
//            }
//        }
//
//    }
//    var fullName: String {
//        return "\(firstName) \(lastName)"
//    }
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    //type property 생성된 인스턴스와 상관없이 struct의 타입 속성을 정하고 싶을때 사용한다.
    static let isAlien: Bool = false
}

var person = Person(firstName: "Jason", lastName: "Lee")

//person.firstName
//person.lastName
//
//person.firstName = "Jim"
//person.lastName = "Kim"
//
//person.firstName
//person.lastName
//person.fullName
//person.fullName = "Jay Park"
//
//person.firstName
//person.lastName
//
//Person.isAlien
//
//person.isPopular

person.fullName()
