import UIKit
// 1. 성, 이름을 받아서 fullname을 출력하는 함수 만들기
// 2. 1번에서 만든 함수인데, 파라미터 이름을 제거하고 fullname출력하는 함수 만들기
// 3. 성, 이름을 받아서 fullname return 하는 함수 만들기

func printFullname(first: String, last: String){
    print(first + last)
}
printFullname(first: "정", last: "도현")


func printFullname2(_ first : String, _ last : String){
    print(first+last)
}
printFullname2("정", "도현")

func returnprintFullname(_ first : String, _ last : String)->String{
    return first + last
}

print(returnprintFullname("정", "도현"))
