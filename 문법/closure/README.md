# Closure
## 1. Capture
클로저 캡처란 클로저가 매개변수나 지역변수가 아닌 주변 외부의 context를 사용하기 위해 주변 외부의 context를 참조하는 것이다.  
캡처는 말 그대로 가져온다는 의미이다. 참조로 가져오니 어떻게 생각하면 원본을 가져오는 것과 의미가 동일하다. 동일한 주소값을 참조하고 있으니, 결국 캡쳐한 값을 변경한다면, 원본의 값도 같이 변경된다. 

간단한 예제로는 
```swift
var num = 0
let c = {
    num += 1
    print("Check point #1: \(num)")
}
c()
print("Check point #2: \(num)")
```
위에서 클로저 안에서 num의 값이 변경되고 있다. 이렇게 되면 클로저 c가 num을 캡쳐하고 있는 것이다. 그렇기 때문에, num의 값을 참조하고 있다. 그래서 다시 print 해보면 c의 값이 더 올라간 것을 볼 수 있다.  

단순히 생각하면 당연한거 아닌가?? 라는 생각을 할수 있다.   
하지만 swift에서 Int 자료형 변수는 값 타입이다. 그래서 일반적으로 global함수로 num을 바꾸고 다시 밖에서 num을 출력한다면 다시 0이 나올것이다. 많은 사람들이 C언어로 swap 함수 만들때 하는 실수와 동일히다.  
swift에서도 이런 것이 적용된다. 클로저도 함수이기 때문에, 라이프사이클이 있다. 기본적으로는 라이프사이클 내에서 다 해결하고, 다 끝나면 모든 메모리를 반환하는 게 옳다.
참조를 통해서 함수, 클로저 내에서도 우리는 값을 변경할 수 있다. 이게 곧 Capturing values이다.

애플의 공식예제로 본다면
```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```
makeIncrementer는 Int형을 받아서 Int 형을 return 하는 closure을 return 한다.
makeIncrementer의 지역변수는 runningTotal이 있다.
func incrementer()라는 클로저에는 runningTotal이라는 주변 외부의 변수를 가지고 있다. 이때 캡쳐가 일어난것이다. 클로저에서 값을 변경하기위해 참조로 변한다. 

참조로 캡처를 하게되면 makeIncrementer에 대한 호출이 종료될때, runningTotal과 amount가 사라지지 않으며, 다음에 incrementer 함수가 호출될때 running Total을 사용할 수 있습니다.
결국 클로저의 reference count가 0이 되지 않았다는 소리이다. 그래서 아래의 코드가 가능하다
```swift
let incrementByTen = makeIncrementer(forIncrement: 10)

incrementByTen()
// returns a value of 10
incrementByTen()
// returns a value of 20
incrementByTen()
// returns a value of 30
```

***

## 2. Escaping Closure
Escaping Closure이라고 어디선가 탈출한다는 의미이다. 그렇다면 어디서 탈출하는 것일까?
라는 생각을 해본다면, 함수 라이프사이클이라고 생각하면 난 편했다.

일반적으로 nonescaping 클로저에서는 함수 body에서 호출되고 있는 클로저는 항상 함수가 끝나기 전에 실행된다. 결국 함수 라이프사이클 내에서 실행된다고 볼 수 있다.

### nonescaping
```swift
func performNonEscaping(closure: () -> ()) {
    print("start")
    closure()
    print("end")
}

performNonEscaping {
    print("closure")
}
```
이 코드에서 보자면, performNonEscaping()에서는 클로저를 파라미터로 받고있다. 이 클로저는 일반적으로 함수 내에서 만들어진 함수라고 볼 수 있다.(복사본) 그렇게 생각한다면, 함수가 끝나기 전까지 함수 내에 있는 모든 코드는 다 일어날 것이고 다 일어난뒤에는, 메모리가 다 반환되는 것이 정상이다.

하지만 함수 라이프사이클 내에서가 아닌 밖에서 클로저가 사용되어야하는 경우가 있을때, @escaping이라는 annotation을 클로저 앞에 붙인다.  
탈출하는것은 함수 라이프사이클 밖에서도 closure가 실행되는 것을 의미한다. 함수의 정상적인 실행흐름을 탈출하는 것이다.  
@escaping 클로저는 시작시점과 종료시점이 정확하지 않다. 결국 함수의 실행 흐름과 관련이 없어진다.   
보통 비동기프로그래밍을 할때 함수의 실행흐름을 거스를때 사용한다.


### escaping
```swift
func performEscaping(closure: @escaping () -> ()) {
    print("start")
        
    var a = 12
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        closure()
        for _ in 0...3 {
            a += 3
        }
        print(a)
    }
    
    print("end")
}

performEscaping {
    print("closure")
}
```
이 코드에서 본다면, escaping이 클로저 앞에 붙어있기 때문에 함수가 다 끝난 이후에도 그 클로저는 계속 실행될 예정이라는 것을 알 수 있다.   
그러면 함수가 실행되면, 먼저 start가 프린트 되고, 비동기가 있기 때문에, 바로 end가 찍힌다. 이시점에서 performEscaping의 함수의. 라이프사이클은 끝이난다. 하지만 우리는 클로저를 escaping 시켰기 때문에, 이 클로저는 아직 살아있는 것이다.     
3초가 지난뒤에 closure()가 발동되서 closure가 찍히고, 그리고 print(a)까지 완성된다. 


### 왜 사용??
클로저의 실행이 완료될때까지 클로저를 제거하지 않는다. 그리고 클로저는 클로저 외부의 값을 캡쳐하고 있기 때문에, 그 값들도 계속 살아있다. 그래서 함수 밖에서 클로저의 기능과 클로저가 캡쳐한 값으로 무언가를 진행할 때 유용하다. 

* * *

## 3. 캡쳐된 변수는 클로저가 실행될때 평가된다.
출처 : [클로저 캡처에 대해서](https://velog.io/@kimdo2297/%ED%81%B4%EB%A1%9C%EC%A0%B8-%EC%BA%A1%EC%B3%90%EC%97%90-%EB%8C%80%ED%95%B4%EC%84%9C-about-closure-capture)

```swift
class Pokemon {
  let name: String
  init(name: String) {
    self.name = name
  }
  deinit { print("\(self) escaped!") }
}

func delay(_ seconds: Int, closure: @escaping ()->()) {
  let time = DispatchTime.now() + .seconds(seconds)
  DispatchQueue.main.asyncAfter(deadline: time) {
    print("🕑")
    closure()
  }
}
```
```swift
func demo1() {
  let pokemon = Pokemon(name: "Mewtwo")
  print("before closure: \(pokemon)")
  delay(1) {
    print("inside closure: \(pokemon)")
  }
  print("bye")
}

demo1()
// 실행 화면 
// before closure: Mewtwo
// bye
// 🕑
// inside closure: Mewtwo
// Mewtwo escaped!
```
```swift
func demo2() {
  var pokemon = Pokemon(name: "Pikachu")
  print("before closure: \(pokemon)")
  delay(1) {
    print("inside closure: \(pokemon)")
  }
  pokemon = Pokemon(name: "Mewtwo")
  print("after closure: \(pokemon)")
}

demo2()
// 실행 화면
// before closure: Pikachu
// Pikachu escaped!
// after closure: Mewtwo
// 🕑
// inside closure: Mewtwo
// Mewtwo escaped! 
```
이 코드와 실행 결과를 읽으면서 굉장히 신기했던 것 중에 하나이다. 클로저의 캡처가 실행될때 이루어진다는 것이다. 기본적으로 demo2를 보자면, 처음에 포켓몬이름은 피카츄다.  그리고 신기한건 피카츄가 나간다. 그리고 다시 맨투스가 들어왔다가 그리고 inside closure가 불린다.

결국에는 처음에 피카츄라는 인스턴스가 생기고, delay가 있는동안에, pokemon이라는 인스턴스의 이름이 피카츄에서 맨투스로 바뀐다. 이러면서, 피카츄로 만들어진 인스턴스는 deinit 되고, 맨투스 인스턴스가 생긴것이다. 이 때 1초가 이제 지나서 클로저가 포켓몬을 캡쳐한다. 


이 클로저는 escaping이기 때문에 demo2 함수가 다 끝난뒤에 실행될 수 있다. 그렇기 때문에, after closure 맨투스가 끝난뒤(1초뒤)에 맨투스를 캡쳐한다. 그리고 클로저가 다 실행된 뒤에 메모리를 반납한다.

***

## Closure CaptureList(reference Type)
클로저와 인스턴스 사이에 강한 참조 사이클이 일어날 수 있다.  
2개의 인스턴스가 서로를 참조할때 강한 참조 사이클이 일어나는데, 이때 인스턴스는 정상적으로 메모리 해제가 발생하지 않는다.  
클로저가 인스턴스를 캡쳐하고 있고, 인스턴스가 클로저를 강한 참조를 하고 있다면, 강한 참조사이클이 일어나게 된다.

### 강한참조사이클이 일어날때
```swift
class Car {
    var totalDrivingDistance = 0.0
    var totalUsedGas = 0.0
    
    lazy var gasMileage: () -> Double = {
        return self.totalDrivingDistance / self.totalUsedGas
    }
    
    func drive() {
        self.totalDrivingDistance = 1200.0
        self.totalUsedGas = 73.0
    }
    
    deinit {
        print("car deinit")
    }
}

var myCar: Car? = Car()
myCar?.drive()
myCar?.gasMileage()
myCar = nil
```
현재 Car class에 2개의 변수가 있는데, strong으로 변수 설정이 되어있다. 이러한 경우, class내부의 클로저가 저 2개를 캡쳐할 경우, 강한 참조 사이클이 일어난다. 그래서 myCar?.gasMilage()를 부른다면, 강한 참조로 인해서 인스턴스가 deinit을 못하게 된다.  
핵심은   
1. 클로저는 self를 통해 인스턴스 속성에 접근
2. self는 인스턴스를 나타내는 속성인데, 이 속성을 클로저 안에서 사용하다보면, 클로저가 이 변수들을 캡쳐하게된다.
3. 클로저는 실행 종료때까지 self를 강한 참조 중이다.
4. 클로저는 self를 강한 참조중이고, self의 변수들을 캡쳐하고 있기 때문에, 저 변수들과도 강한 참조중이다.(이는 지금 변수가 weak이나 unowned로 설정이되어있지않기 때문이다)
5. mycar에 nil을 주었지만, 클로저는 계속 self를 캡쳐하고있는 상태라서, 결국 deinit은 불리지 않는다.

그렇다면 이를 막는 방법은??? 우리는 capturelist에서 약한참조 혹은 비소유 참조로 만들어주면 된다.
### 약한 참조로 강한참조 사이클을 막는 경우
```swift
lazy var gasMileage: () -> Double = { [weak self] in
    guard let strongSelf = self else {return 0.0}
    return strongSelf.totalDrivingDistance / strongSelf.totalUsedGas
}
```
이런식으로 약한참조로 capturelist를 적용시켜주면, deinit이 해결된다.   
하지만 약한 참조는 옵셔널 타입이기 떄문에, self에 접근할때 옵셔널을 바인딩해줘야한다.   
클로저에 실행이 완료되지 않은 시점에, 캡쳐가 해지될 수 있다면, 약한 참조를 사용한다. 옵셔널 바인딩으로 캡쳐가 해지되었다는 것을 인지하고 바로 빠져나갈 수 있게 만들었기 때문에 런타임 에러가 발생하지 않는다.   

### 비소유참조로 강한참조사이클을 막는 경우
```swift
lazy var gasMileage: () -> Double = { [unowned self] in
    return self.totalDrivingDistance / self.totalUsedGas
}
```
비소유 참조로 강한 참조사이클을 막는 경우에 주의해야할점은, 옵셔널 바인딩이 없는 것이다.   
클로저가 실행이 완료되지 않은 시점에, 캡쳐가 해지된다면, 그리고 그 캡쳐된 변수에 접근한다면, 런타임 오류가 발생할 수 있다.   
따라서 비소유 참조는 캡처대상이 클로저의 생명주기보다 길거나 같을때 사용한다. 

## CaptureList(value Type)
값형식을 캡쳐할때는 참조대신 복사본을 캡쳐하게 만들 수 있다.
```swift
var a = 0
var b = 0
let c = { [a] in print(a,b) }

a = 1
b = 2
c()
// 0 2
```
값 형식 캡처는 복사본을 캡쳐한다고 볼 수 있다. 그래서 a, b를 c 클로저에 넣어 놓고, [a]만 캡처리스트에 넣어준다면? a는 참조가 아니고 값의 복사본이 들어가기 때문에 클로저가 실행될 시점에 변경되지 않는다.(3의 내용이 적용되지 않는다는 것).  

다시 생각해보자면 a의 주소값이 1000, b의 주소값이 1004라면, c 클로저에 들어가있는 a의 주소값은 1000이 아니라 a의 복사본 1040 주소를 가진 새로운 a가 들어있고, 그리고 b는 참조로 캡처를 하니, 1004가 그대로 들어가있다. 그리고 1000 주소에 있는 a를 변경하고, 1004의 주소에 있는 b를 변경했다. 그리고 c 클로저를 실행한다면, b는 1004 주소에 있는 값이 변경 되었으니, 2로 변경되었지만 a 의 값을 변경할때 우리는 1000주소값에 있는 a를 변경했지, 1040 주소에 있는 값을 변경한 것이 아니기 때문에 0이 출력된다.

### 포켓몬으로 이해하기
```swift
func demo3() {
    var pokemon = Pokemon(name: "Pikachu")
    print("before closure: \(pokemon.name)")
    delay(1) { [pokemon] in
        print("inside closure: \(pokemon.name)")
    }
    pokemon = Pokemon(name: "Mewtwo")
    print("after closure: \(pokemon.name)")
}

demo3()
// 실행화면 
// before closure: Pikachu
// after closure: Mewtwo
// Mewtwo escaped!
// 🕑
// inside closure: Pikachu
// Pikachu escaped!
```
피카츄로 이해를 해보자면 먼저 포켓몬 인스턴스는 피카츄라는 이름을 가진다    
그리고 delay라는 클로저가 포켓몬을 캡처할때 캡처리스트가 없었다면, 실행시점에 캡쳐해서 맨토스를 잡았겠지만, 캡처리스트를 적용시키면서 피카츄라는 이름을 가진 포켓몬 인스턴스 하나를 복사해서 가지고 있는 것이다. 결국 참조가 아니라 값복사로 캡처를 하고 있다.    
이렇기 때문에 캡쳐는 피카츄가 된 것으로 확인할 수 있다. 

