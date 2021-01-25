import UIKit

var carName: String?
carName = nil
carName = "Tank"

var Actor: String? = nil
let num = Int("10")


//고급기능 4가지

// Forced unwrapping > 억지로 박스를 까보기
// Optional binding (if let) > 부드럽게 박스를 까보자 1
// Optional binding (guard) > 부드럽게 박스를 까보자 2
// Nil coalescing > 박스를 까봣더니, 값이 없으면 디폴트 값을 줘보자

//carName = nil
//print(carName!)

if let unwrappedcarName = carName{
    print(unwrappedcarName)
}
else{
    print("Car name 없다")
}

//이름 계획표
//- 싱가폴
//    - 0000
//    - 0000000
//        - 0000
//- 싱가폴 맛집
//- 싱가폴 숙소



//func printParsedInt(from: String){
//    if let parsedInt = Int(from) {
//        print(parsedInt)
//    }
//    else{
//        print("casting 안된다")
//    }
//}

func printParsedInt(from: String){
    guard let parsedInt = Int(from)
    else{
        print("Int로 컨버팅 안됨")
        return
    }
    print(parsedInt)
}

printParsedInt(from: "100")
printParsedInt(from: "헬로우 마이 네임이즈")

carName = "Model 3"
let myCarName: String = carName ?? "Model S"


// -- 도전과제
// 1. 최애 음식이름을 담는 변수를 작성 + (String?)
// 2. 옵셔널 바인딩을 이용해서 값을 확인해보기
// 3. 닉네임을 받아서 출력하는 함수 만들기, 조건입력 파라미터는 String?

var favoriteFood : String? = "shrimp"

func printFood(food: String?){
    if let printFood = food{
        print(printFood)
    }
    else{
        print("cannot convert")
    }
}
printFood(food: favoriteFood)

func printNickname(name: String?){
    guard let Nickname = name
    else{
        print("Let's make Nickname")
        return
    }
    print(Nickname)
}
printNickname(name: nil)
