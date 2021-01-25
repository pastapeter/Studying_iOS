import UIKit

func printName(){
    print("HELLO my name is jason")
}

printName()

// param 1개
// 숫자를 받아서 10을 곱해서 출력한다.

func printMulitleOfTen(value: Int){
    print("\(value)*10 = \(value*10)")
}

printMulitleOfTen(value: 5)

//param 2개
//물건값과 갯수를 받아서 전체 금액을 출력하는 함수

//func printTotalPrice(price: Int, count: Int){
//    print("Total Price: \(price*count)")
//}

//printTotalPrice(price: 1500, count: 5)

func printTotalPrice(price: Int, count: Int){
    print("Total Price: \(price*count)")
}
printTotalPrice(price: 1500, count: 5)


func printTotalPriceDefault(price: Int = 1500, count: Int){
    print("Total Price: \(price*count)")
}

printTotalPriceDefault(price: 1500, count: 5)

func totalPrice(price: Int, count: Int)-> Int{
    let totalPrice = price*count
    return totalPrice
}

let calculatedPrice = totalPrice(price: 10000, count: 77)
print(calculatedPrice)
