import Cocoa

// autoclosure
// 파라미터로 전달되는 호출식을 클로저로 래핑하는 시스템

func random() -> Int {
    return Int.random(in: 0...100)
}

func takeResult(param: Int) {
    print(#function)
    print(param)
}

takeResult(param: random())
print("--------------------------------")

func takeClosure(param: () -> Int) {
    print(#function)
//    print(param())
}

takeClosure(param: {Int.random(in: 0...100)})
print("--------------------------------")


func takeAutoClosure(param: @autoclosure @escaping () -> Int) {
    print(#function)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        print(param())
    }
}

//takeAutoClosure(param: {Int.random(in: 0...100)})
//error? why
//오토클로저로 되어있다면, 클로저를 전달할 수 없다.
//오토클로저는 파라미터를 받을 수 없다.
//return type은 자유롭게 설정이 가능하다.

takeAutoClosure(param: Int.random(in: 0...100))
// 자동으로 클로저가 래핑해준다. 표현식을 클로저로 래핑해주는 경우를 말한다.

// 오토클로저의 대표적인 함수는 assert
let rnd = random()
assert(rnd > 30)


