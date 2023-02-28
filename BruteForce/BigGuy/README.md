# 7568 덩치

## 🍎 문제 접근
- for loop으로 반복하면서 현재 기준에 있는 사람보다 키와 몸무게 둘 다 큰 사람이 몇 명이 있는지 카운트를 올려주면 된다.

## 🍎 전체 코드
```swift
import Foundation

let people = Int(readLine()!)!
var peopleArr: [(Int, Int)] = []
for i in 0..<people {
    let weightHeight = readLine()!.split(separator: " ").map { Int(String($0))! }
    let weight = weightHeight[0]
    let height = weightHeight[1]
    peopleArr.append((weight,height))
}

var result = [Int]()
for person in peopleArr {
    var tempResult = 1
    let currentWeight = person.0
    let currentHeight = person.1
    for people in peopleArr {
        let otherWeight = people.0
        let otherHeight = people.1
        if otherWeight > currentWeight && otherHeight > currentHeight {
            tempResult += 1
        }
    }
    result.append(tempResult)
}
result.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
```
