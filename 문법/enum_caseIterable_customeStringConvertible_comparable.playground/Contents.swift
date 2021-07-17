import Cocoa


enum CompassDirection: Comparable, CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
        case .east:
            return "east"
        case .north:
            return "north"
        case .south:
            return "south"
        case .west:
            return "west"
        }
    }
    case north, south, east, west
}

print("There are \(CompassDirection.allCases.count) directions.")
// Prints "There are 4 directions."
let caseList = CompassDirection.allCases
                               .map({ "\($0)" })
                               .joined(separator: ", ")

print(caseList)

print(CompassDirection.east)
print(CompassDirection.north)
print(CompassDirection.allCases[1])


struct A {
    var directionPriority: CompassDirection
    init(directionPriority: CompassDirection = .east) {
        self.directionPriority = directionPriority
    }
}

extension A: Comparable, Equatable {
    static func < (lhs: A, rhs: A) -> Bool {
        return lhs.directionPriority < rhs.directionPriority
    }
    
    static func == (lhs: A, rhs: A) -> Bool {
        return lhs.directionPriority == lhs.directionPriority
    }
}

let directA = A() //east
let directB = A(directionPriority: .south) //south
let directC = A(directionPriority: .west) //west
let directD = A(directionPriority: .north) //north

print(directB < directD) //south < north
print(directA < directB)
print(directA > directB)
print(directC > directA)
