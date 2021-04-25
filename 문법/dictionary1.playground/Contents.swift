import UIKit

var scoreDic: [String: Int] = ["Jason": 80, "Jay": 95, "Jake": 90]
//var scoreDic: Dictionary<String, Int> = ["Jason": 80, "Jay": 95, "Jake": 90]

if let score = scoreDic["Jason"] {
    score
}
else{
    //.. score 없음
}
scoreDic["Jay"]

scoreDic["Jerry"]

//scoreDic = [:]
scoreDic.isEmpty
scoreDic.count

//기존 사용자 업데이트
scoreDic["Jason"] = 99
scoreDic

//사용자 추가
scoreDic["Jack"] = 100
scoreDic

//사용자 제거
scoreDic["Jack"] = nil
scoreDic


//for loop
for (name, score) in scoreDic{
    print("\(name), \(score)")
}

for key in scoreDic.keys{
    print(key)
}

for value in scoreDic.values{
    print(value)
}

// 1 이름, 직업, 도시에 대해서 본읜의 딕셔너리 만들기
// 2 여기서 도시를 부산으로 업데이트 하기
// 3 딕셔너리를 받아서 이름과 도시프린트하는 함수

var myDic: [String: String] = ["name": "도현", "job": "student", "city": "Seoul"]
myDic["city"] = "Busan"
//print(myDic["name"]!, myDic["city"]!)

func printnamecity(dic: [String: String]){
    if let name = dic["name"], let city = dic["city"] {
        print(name, city)
    }
    else{
        print("-->cannot find")
    }
}
printnamecity(dic: myDic)
