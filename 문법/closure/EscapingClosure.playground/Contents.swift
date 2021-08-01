import Cocoa

// Escaping closure
// 어디서부터 탈출??

//func performNonEscaping(closure: () -> ()) {
//    print("start")
//    closure()
//    print("end")
//}
//
//performNonEscaping {
//    print("closure")
//}

// 함수 body에서 호출되고 있는 closure은 항상 함수가 끝나기 전에 실행된다. 결국 함수 라이프사이클 내에서 실행된다고 볼 수 있다.
// 결국 escaping? 탈출하는것은 함수 라이프사이클 밖에서도 closure가 실행되는 것을 의미한다. 함수의 정상적인 실행흐름을 탈출하는 것이다.
// 시작시점과 종료시점이 정확하지 않다. 결국 함수의 실행흐름과 관련이 없어진다.
// 비동기 프로그래밍을 할때 함수의 실행흐름을 거스를때 사용된다.

//func performEscaping(closure: @escaping () -> ()) {
//    print("start")
//
//    var a = 12
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//        closure()
//        for _ in 0...3 {
//            a += 3
//        }
//        print(a)
//    }
//
//    print("end")
//}
//
//performEscaping {
//    print("closure")
//}

//왜 필요???
//closure의 실행이 완료될때까지 closure을 제거하지 않는다
//위에서 보면 클로져가 클로져 외부에 있는 값을 캡쳐한다.
//그리고 escaping 하고 있기 때문에, closure가 다 완료될때까지 closure와 closure가 캡쳐한 모든 값들을 살려놓는다.



class Pokemon {
  let name: String
  init(name: String) {
    self.name = name
  }
    deinit { print("\(self.name) escaped!") }
}

func delay(_ seconds: Int, closure: @escaping ()->()) {
  let time = DispatchTime.now() + .seconds(seconds)
  DispatchQueue.main.asyncAfter(deadline: time) {
    print("🕑")
    closure()
  }
}

func demo1() {
  let pokemon = Pokemon(name: "Mewtwo")
    print("before closure: \(pokemon.name)")
  delay(1) {
    print("inside closure: \(pokemon.name)")
  }
  print("bye")
}

//demo1()
// 실행 화면
// before closure: Mewtwo
// bye
// 🕑
// inside closure: Mewtwo
// Mewtwo escaped!

func demo2() {
  var pokemon = Pokemon(name: "Pikachu")
    print("before closure: \(pokemon.name)")
  delay(1) {
    print("inside closure: \(pokemon.name)")
  }
  pokemon = Pokemon(name: "Mewtwo")
    print("after closure: \(pokemon.name)")
}

demo2()
// 실행 화면
// before closure: Pikachu
// Pikachu escaped!
// after closure: Mewtwo
// 🕑
// inside closure: Mewtwo
// Mewtwo escaped!
