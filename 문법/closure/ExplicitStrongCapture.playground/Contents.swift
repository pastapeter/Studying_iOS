import Cocoa

// Explict Strong Capture
// 클로저 내부에서 self에 접근하는 코드를 조금 더 간단하게 만들 수 있는 방법



struct PersonValue {
    let name: String = "Jane Doe"
    let age: Int = 0
    
    func doSomething() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [self] in
            print(name, age)
        }
    }
}


class PersonObject {
    let name: String = "Jane Doe"
    let age: Int = 0
    
    func doSomething() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            print(self.name, self.age)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) { [self] in
            print(name, age)
        }
    }
}
