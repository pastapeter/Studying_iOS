import Cocoa


class Person{
    var name: String
    var job: String?
    var home: Apartment?
    
    init(name: String){
        self.name = name
    }
}

class Apartment {
    var buildingNumber: String
    var roomNumber: String
    var `guard`: Person?
    var owner: Person?
    
    init(dong: String, ho: String){
        buildingNumber = dong
        roomNumber = ho
    }
}

let dohyun: Person? = Person(name: "dohyun")
let apart: Apartment? = Apartment(dong: "101", ho: "202")
let superman: Person? = Person(name: "superman")

// 옵셔널 체이닝 실행 후 결과값이 nil일 수도 있기 때문에
// 결과타입도 옵셔널이다.

// 옵셔널 체이닝을 쓰지 않는다면?
func guardJob(owner: Person?){
    if let owner = owner {
        if let home = owner.home {
            if let `guard` = home.guard {
                if let guardJob = `guard`.job {
                    print("job is \(guardJob)")
                } else {
                    print("no guard")
                }
            }
        }
    }
}

guardJob(owner: dohyun)

// 옵셔널 체이닝을 쓰면?
func guardJobOC(owner: Person?){
    if let guardJob = owner?.home?.guard?.job {
        print("job is \(guardJob)")
    } else {
        print("no guard")
    }
}

guardJobOC(owner: dohyun)

dohyun?.home?.guard?.job

dohyun?.home = apart

dohyun?.home?.guard
dohyun?.home?.guard = superman

dohyun?.home?.guard?.name

dohyun?.home?.guard?.job

dohyun?.home?.guard?.job = "경비원"

dohyun?.home?.guard?.job

//nil coalecing

var guardJob: String

guardJob = dohyun?.home?.guard?.job ?? "superman"
print(guardJob)

dohyun?.home?.guard?.job = nil

guardJob = dohyun?.home?.guard?.job ?? "superman"
print(guardJob)


