import UIKit

//Don't change this
var studentsAndScores = ["Amy": Int(readLine()!)!, "James": Int(readLine()!)!, "Helen": Int(readLine()!)!]

func highestScore(scores: [String: Int]) {
  
  //Write your code here.
    var score: [Int]!
    for (key, value) in scores{
        if value != nil {
            score.append(value)
        }
    }
    score.sort()
    print(score[0])
}

highestScore(scores: studentsAndScores)
