import Cocoa

//closure 와 인스턴스 사이에 강한 참조 사이클이 일어날수 있다.
//2개의 인스턴스가 서로를 참조할떄 강한 참조 사이클이 일어나는데, 이때 인스턴스는 정상적으로 메모리 해제가 발생하지 않는다.
//클로저가 인스턴스를 캡쳐하고 있고, 인스턴스가 클로저를 강한 참조를 하고 있다면, 강한 참조 사이클이 일어나게 된다.

class Car {
    var totalDrivingDistance = 0.0
    var totalUsedGas = 0.0
    
//    lazy var gasMileage: () -> Double = {
//        return self.totalDrivingDistance / self.totalUsedGas
//    }
    // 클로저는 self를 통해 인스턴스 속성에 접근
    // self는 인스턴스를 나타내는 속성인데, 이 속성을 클로저 안에서 사용하다보면, 클로저가 이 변수들을 캡쳐하게된다.
    // 클로저는 실행 종료때까지 self를 강한 참조 중이다.
    // 클로저는 self를 강한 참조중이고, self의 변수들을 캡쳐하고 있기 때문에, 저 변수들과도 강한 참조중이다.(이는 지금 변수가 weak이나 unowned로 설정이되어있지않기 때문이다)
    //
    
    // 참조형식을 캡쳐할때
    // 약한 참조
    // 약한 참조는 옵셔널 형식이다. self에 접근할때, 옵셔널을 벗겨줘야한다.
    // 클로저에 실행이 완료되지 않은 시점에, 캡쳐가 해지될 수 있다면 약한 참조를 사용한다.
    // 약한 참조로 캡쳐할때는 캡쳐대상의 해제된 경우도 고려해야한다.
//    lazy var gasMileage: () -> Double = { [weak self] in
//        guard let strongSelf = self else {return 0.0}
//        return strongSelf.totalDrivingDistance / strongSelf.totalUsedGas
//    }
    
    // 비소유참조
    // 클로저에 실행이 완료되지 않은 시점에, 캡쳐가 해지된다면, 그리고 그 캡처된 변수에 접근한다면, 런타임 오류가 발생할 수 있다.
    // 비소유 참조는 캡처대상이 클로저의 생명주기보다 길거나 같을때 사용한다. 
    lazy var gasMileage: () -> Double = { [unowned self] in
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
// 현재 강한참조사이클로 인해 deinit이 정상적으로 작동하지 않는다.


// 값형식을 캡쳐할때
// 참조 대신 복사본을 캡쳐한다.
var a = 0
var b = 0
let c = { [a] in print(a,b) }

a = 1
b = 2
c()






