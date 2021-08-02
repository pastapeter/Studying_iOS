import Cocoa

var greeting = "Hello, playground"

let now = Date()
let cal = Calendar.init(identifier: .gregorian)
let comps = cal.dateComponents([.weekday], from: now)
print(comps.weekday)

