import Cocoa

//typeCasting
/*
 인스턴스의 타입을 확인하거나(is), 해당 인스턴스를 자체 클래스 계층 구조의 다른 곳에서 다른 상위 클래스 또는 하위 클래스로 취급하는 방법(as)
 메서드나 함수가 반환하는 값이 불확실한 경우는, 컴파일러가 에러를 띄울때가 있다. 이 때문에 타입캐스팅
 */

// 상위 클래스 정의하기
class Animal {
    var name: String
    init(n: String) {
        name = n
    }
}

//하위 클래스 정의하기
class Human: Animal {
    func  code(){
        print("Typing away...")
    }
}

//하위클래스 정의하기
class Fish: Animal {
    func breathUnderWater(){
        print("Breathing under water")
    }
}


let dohyun = Human(n: "Dohyun")
let jack = Human(n: "Jack")
let nemo = Fish(n: "Nemo")
let number: Int = 12
let num: NSNumber = 12
let word: NSString  = "abc"

let neighbours = [dohyun, jack, nemo]
//let neighbours: [Any] = [dohyun, jack, nemo]

//let neighbours2: [AnyObject] = [dohyun, jack, nemo, number]
let neighbours2: [AnyObject] = [dohyun, jack, nemo]
let neighbours3: [NSObject] = [num, word]

let neighbour1 = neighbours[0]


// 타입 검사 is operator
if dohyun.name is String{
    print(true)
}

if neighbours[0] is Human {
    print("First Neighbour is human")
} else {
    print("Not human")
}

if neighbours[2] is Human {
    print("third Neighbour is human")
}

/*
 특정 클래스 타입의 상수 또는 변수는 하위 클래스의 인스턴스를 참조할 수 있습니다.
 이 경우에는 타입캐스트 연산자를 사용하여 서브 클래스 타입으로 다운캐스팅을 시도할 수 있습니다.
 
 */
// as는 업캐스팅과 패턴매칭에서만 사용할 수 있다.

func findNemo(from animals: [Animal]){
    for animal in animals {
        if animal is Fish {
            print(animal.name)
            let fish = animal as! Fish
            fish.breathUnderWater()
            let animalFist = fish as Animal
            print(animalFist.name)
        }
    }
}

//findNemo(from: neighbours)

if let fish = neighbours[1] as? Fish {
    fish.breathUnderWater()
} else {
    print("casting has failed")
}

