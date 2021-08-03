import Cocoa

struct GroceryProduct: Codable {
    var name: String
    var points: Int
    var desc: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case desc = "description"
        case points
    }
}

let pear = GroceryProduct(name: "Pear", points: 250, desc: "A ripe pear.")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

do {
    let data = try encoder.encode(pear)
    print(String(data: data, encoding: .utf8)!)
} catch {
    print(error)
}

