# 2231 분해합

## 🍎 문제 접근
- i가 반복문을 1부터 userInput까지 돌면서 number + 각자리수들의 합을 더해서 userInput이 되는 i를 구하는 문제

## 🍎 전체 코드
```swift
import Foundation

let userInput = Int(readLine()!)!

func getSumOfPieces(_ num: Int) -> Int {
    var testNum = num
    var result = num
    while testNum > 9 {
        result += testNum % 10
        testNum /= 10
    }
    result += testNum
    return result
}

var result = 0
for i in 1...userInput {
    if userInput == getSumOfPieces(i) {
        result = i
        break
    }
}
print(result)
```
