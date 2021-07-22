import Cocoa

//class Car {
//    var colour = "Red"
//}
//
//let myCar = Car()
//myCar.colour = "Blue"
//
//let yourCar = Car()
//print(yourCar.colour)

class Car {
    var color = "Red"
    static let shared = Car()
    private init(){}
    
    func printColor(){
        print(color)
    }
}

Car.shared.printColor()
Car.shared.color = "Brown"
Car.shared.printColor()

class Volume {
    var volume = 50
    static let shared = Volume()
    
    private init(){}
    
    func lowVolume(){
        volume -= 5
    }
    
    func highVolume(){
        volume += 5
    }
}

class music{
    var musicName: String
    var artist: String
    var volume = Volume.shared
    
    init(musicName: String, artist: String) {
        self.musicName = musicName
        self.artist = artist
    }
}

let musicA = music(musicName: "하루하루", artist: "빅뱅")
let musicB = music(musicName: "쏘리쏘리", artist: "슈퍼주니어")

print("\(musicA.musicName)의 음량은 \(musicA.volume.volume)")
musicA.volume.highVolume()
musicA.volume.highVolume()
print("\(musicB.musicName)의 음량은 \(musicB.volume.volume)")


//
//let myCar = Car.singletonCar
//myCar.color = "Blue"
//
//let yourCar = Car.singletonCar
//print(yourCar.color)
//
//
//class A{
//    init() {
//        Car.singletonCar.color = "Brown"
//    }
//}
//class B{
//    init() {
//        print(Car.singletonCar.color)
//    }
//}

//let a = A()
//let b = B()
