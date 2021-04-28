import Cocoa

class Animal {
    var name: String
    init(n: String) {
        name = n
    }
}

class Human: Animal {
    func  code(){
        print("Typing away...")
    }
}

class Fish: Animal {
    func breathUnderWater(){
        print("Breathing under water")
    }
}


let angela = Human(n: "Angela")
let jack = Human(n: "Jack Bauer")
let nemo = Fish(n: "Nemo")
let num: NSNumber = 12
let word: NSString  = "abc"

let neighbours: [Any] = [angela, jack, nemo]
let neighbours2: [AnyObject] = [angela, jack, nemo]
let neighbours3: [NSObject] = [num, word]

let neighbour1 = neighbours[0]

if neighbours[0] is Human {
    print("First Neighbour is human")
}

if neighbours[2] is Human {
    print("third Neighbour is human")
}

func findNemo(from animals: [Animal]){
    for animal in animals {
        if animal is Fish {
            print(animal.name)
            let fish = animal as! Fish
            fish.breathUnderWater()
            let animalFist = fish as Animal
        }
    }
}

//findNemo(from: neighbours)

if let fish = neighbours[1] as? Fish {
    fish.breathUnderWater()
} else {
    print("casting has failed")
}

