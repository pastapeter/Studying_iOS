import Cocoa

let c2 = { (str: String) -> String in
    return "Hello \(str)"
}

let result = c2("Closure")
print(result)

typealias SimpleStringClosure = (String) -> String

func perform(closure: SimpleStringClosure) {
    print(closure("IOS"))
}

perform(closure: c2)

perform(closure: {(str: String) -> String in
    return "Hi , \(str)"
})

let products = [
    "MacBook Air", "Macbook Pro",
    "iMac", "iMac Pro", "Mac Pro", "Mac mini",
    "iPad Pro", "iPad", "iPad mini",
    "iPhoneXs", "iPhoneXr", "iPhone 8", "iPhone 7",
    "Airpods", "Apple Watch Series 4", "Apple Watch Nike+"
]

var proModels = products.filter { (pro) in
    return pro.contains("Pro")
}
print(proModels)

proModels.sort{ (lhs: String, rhs: String) in
    return lhs.caseInsensitiveCompare(rhs) == .orderedAscending
}

print(proModels)


print("start")


DispatchQueue.main.asyncAfter(deadline: .now()+5) {
    print("end")
}

// 문법최적화
products.filter {$0.contains("Pro")}
proModels.sort { $0.caseInsensitiveCompare($1) == .orderedAscending}
proModels.sort(by: { (lhs: String, rhs:String) -> Bool in
                return lhs.caseInsensitiveCompare(rhs) == .orderedAscending})

proModels.contains(where: {(element: String) -> Bool in
    let array = proModels.map {$0}
    for ele in array {
        if ele == element {
            return true
        }
    }
    return false
})


