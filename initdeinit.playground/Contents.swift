import UIKit

class PersonB{
    var name: String
    var age: Int
    var nickName: String
    //생성자
    init(name: String, age: Int, nickName: String) {
        self.name = name
        self.age = age
        self.nickName = nickName
    }
}
let hana: PersonB = PersonB(name: "hana", age: 20, nickName: "하나")

// 프로퍼티에 초기값이 꼭 필요없을때
// 옵셔널을 사용한다.
// class 내부의 init을 사용할때는 convenience 키워드 사용

class PersonC{
    var name: String
    var age: Int
    var nickName: String?

//    init(name: String, age: Int, nickName: String) {
//        self.name = name
//        self.age = age
//        self.nickName = nickName
//    }
    
    convenience init(name: String, age: Int, nickName: String){
        self.init(name: name, age: age)
        self.nickName = nickName
    }

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let jenny: PersonC = PersonC(name: "Jenny", age: 10)
let mike: PersonC = PersonC(name: "mike", age: 10, nickName: "hh")

//암시적 추출 옵셔널은 인스턴스 사용에 꼭필요하지만 초기값을 할당하지 않고자 할 떄 사용
class Puppy{
    var name: String
    var owner: PersonC!
    
    init(name: String) {
        self.name = name
    }
    
    func goOut(){
        print("\(name)가 주인\(owner.name)와 산책한다.")
    }
}

let happy:Puppy = Puppy(name: "happy!")
//owner가 암시적 추출 옵셔널이기땜에 있어야함
happy.owner = jenny
happy.goOut()

// 실패가능한 이니셜라이저
//이니셜나라이저 매개변수로 전달되는 초기값이 잘못된 경우 인스턴스 생성에 실패할 수 있다.
// 인스턴스 생성에 실패하면 nil 반환
// 실패가능한 이니셜라이저 반환타입은 옵셔널
// init?사용
class PersonD{
    var name: String
    var age: Int
    var nickName: String?
    
    init?(name: String, age: Int){
        if (0...120).contains(age) == false {
            return nil
        }
        if name.count == 0{
            return nil
        }
        self.name = name
        self.age = age
    }
}

let john:PersonD? = PersonD(name: "john", age: 23)
let joker:PersonD? = PersonD(name:"joker", age: 123)
let batman:PersonD? = PersonD(name: "", age: 10)

print(joker)
print(batman)

// deinit 소멸자
//deinit은 클래스의 인스턴스가 해제되는 시점에 호출
//클래스타입에만
//인스턴스가 메모리에서 해제되는 시점은 ARC의 규칙에 따라 결정됨

class PersonE{
    var name: String
    var pet: Puppy?
    var child: PersonC
    init(name: String, child: PersonC) {
        self.name = name
        self.child = child
    }
    // 인스턴스가 메모리에서 해제되는 시점에 자동호출
    deinit {
        if let petName = pet?.name {
            print("\(name)가 \(child.name)에게 \(petName)를 인도합니다.")
            self.pet?.owner = child
        }
    }
}

var donald:PersonE? = PersonE(name: "donald", child: jenny) //도날드의 닐가능성을 열어두자
donald?.pet = happy
donald = nil

