import Cocoa

//capturing value
// Nested Function은 값을 캡쳐한다.자신을 포함하고 있는 함수 body에 접근할떄 그 값을 캡쳐한다.
// 클로져는 외부의 값의 접근할때 값을 캡쳐한다.

var num = 0
//print("Check point #1: \(num)")
//
//num += 1
//print("Check point #2: \(num)")



// 캡쳐는 그냥 말 그대로 가져온다는 의미이다. swift에서의 캡쳐는 그 값을 참조를 가져온다는 뜻이다. 참조를 가져온다면,
// 결국 원본을 가져오는 것과 의미가 값다. 왜냐면 동일한 주소값을 참조하고 있기 때문이다. 따라서 캡쳐한 값을 변경한다면,
// 원본도 같이 변화하게 된다.

let c = {
    num += 1
    print("Check point #1: \(num)")
}
c()
print("Check point #2: \(num)")
