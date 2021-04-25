import UIKit

struct Student{
    
    var name: String = ""
    var `class`: String = "Swift"
    var koreanAge: Int = 0
    
    var westerAge: Int {
        get {return koreanAge - 1
        }
        
        set(inputValue){koreanAge = inputValue + 1}
    }
    
    static var typeDescription: String = "학생"
    
    func selfIntroduce(){
        print("저는 \(self.class)반 \(self.name)입니다")
    }
    
    var selfIntroduce2: String{
        get{ return "저는 \(self.class)반 \(self.name)입니다"}
    }
    
    static var selfinroduction: String{
        return "학생타입입니다."
    }
}

class myStudent{
    var name: String
    let length: Int
    
    init(name: String, length: Int) {
        self.name = name
        self.length = length
    }
}

var peter = myStudent(name: "peter", length: 173)
peter.name = "dohyun"
//peter.length = 111
let wendy = myStudent(name: "wendy", length: 155)
wendy.name = "dohyun"


var dohyun: Student = Student()

dohyun.koreanAge = 10
dohyun.name = "dohyun"
print(dohyun.selfIntroduce2)
print(Student.typeDescription)
print(Student.selfinroduction)


struct Money{
    var currencyRate: Double = 1100
    var dollar: Double = 0
    var won: Double{
        get{
            return dollar*currencyRate
        }
        set{
            dollar = newValue / currencyRate
        }
    }
}

var moneyInMyPocket = Money()

moneyInMyPocket.currencyRate = 1150
moneyInMyPocket.dollar = 11
moneyInMyPocket.won = 11500
print(moneyInMyPocket.won)
print(moneyInMyPocket.dollar)

print(moneyInMyPocket.won)

class DataImporter{
    var filename = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}
let manager = DataManager()

// 아래 두 시점에서는 importer가 생성이되지 않는다. lazy var 가 아니었으면 무조건 불려야한다.
manager.data.append("some data")
manager.data.append("some more data")

// 외부에서 이렇게 접근해야만 lazy가 사용되면서 importer가 생성이된다.
print(manager.importer.filename)
//    {
//        willSet(newRate){
//            print("환율이 \(currencyRate)에서 \(newRate)로 변경될 예정입니다.")
//        }
//        didSet(oldRate){
//            print("환율이 \(oldRate)에서 \(currencyRate)로 변경되었습니다.")
//        }
//    }
//    {
//        willSet{
//            print("\(dollar)달러에서 \(newValue)달러로 변경될 예정입니다")
//        }
//        didSet{
//            print("\(oldValue)달러에서 \(dollar)달러로 변경되었습니다.")
//        }
//    }

struct Point{
    var x = 0.0
    var y = 0.0 // 저장프로퍼티
}
struct Size{
    var width = 0.0
    var height = 0.0
}
struct Rect{
    var origin = Point() // origin은 시작 위치니깐 point() 타입으로
    var size = Size() // 너비나 높이를가지니 size타입으로
    var center: Point { //center는 가운데 지점이니 point()타입으로 선언
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            // get에도 새로 변수를 선언하고 값을 할당 가능하다고 한다. 리턴만 제대로 해주면 된다고 한다.
            
            return Point(x: centerX, y: centerY)
            // Point값으로 리턴해주어한다.
        }
        set(newCenter){
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
print(initialSquareCenter)
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y)")


struct Cuboid{
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
