import UIKit

struct PersonStruct {
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    mutating func uppercaseName(){
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
}

class PersonClass{
    
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
   
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    func uppercaseName(){
        firstName = firstName.uppercased()
        lastName = lastName.uppercased()
    }
    
}

var personStruct1 = PersonStruct(firstName: "Peter", lastName: "Chung")
var personStruct2 = personStruct1

var personClass1 = PersonClass(firstName: "Peter", lastName: "Chung")
var personClass2 = personClass1

personStruct2.firstName = "Jay"
personStruct1.firstName
personStruct2.firstName
 
personClass2.firstName = "Jay"
personClass1.firstName
personClass2.firstName

personClass2 = PersonClass(firstName: "Bob", lastName: "Lee")
personClass1.firstName
personClass2.firstName

personClass1 = personClass2
personClass1.firstName
personClass2.firstName

/*
 - struct를 써야할 때 -
 두 object를 같다, 다르다로 비교해야하는 경우 -> 데이터 자체를 비교할때
 copy된 각 객체들이 독립적인 상태를 가져야하는 경우
 코드에서 오브젝트의 데이터를 여러 쓰레드에 걸쳐 사용할 경우 - value 타입을 써야지 안전함
 
 - class를 써야할 때 -
 두 object의 인스턴스 자체가 같음을 확인해야할 때(객체자체가 같은지 확인할 때)
 하나의 객체가 필요하고, 여러 대상에 의해 접근되고 변경이 필요한 경우
 
 1. 일단 struct로 쓰자 -> 나중에 class로 바꿔서 쓰자

 */
