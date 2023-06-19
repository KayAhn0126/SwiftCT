# 2745 진법 변환
- 구현
- X 진법의 수 -> 10 진법의 수

## 🍎 문제 접근
- B진법의 수 N을 10진법의 수로 바꾸는 문제.
- 0~9 ... A:10 ... Z:35
- 주어진 수를 역순 + 배열화하고 로직에 맞게 처리하면 된다.

## 🍎 문제 풀이
- 1101(2진수)를 10진수로 바꾸는 방법은 아래와 같다
    - (1*2^3) + (1*2^2) + (0*2^1) + (1*2^0) = 13
- ZZZZZ(36진수)를 10진수로 바꾸는 방법은 어떻게 될까?
    - 36진법에서 Z는 35이다.
    - (35 * 36^4) + (35 * 36^3) + (35 * 36^2) + (35 * 36^1) + (35 * 36^0) = 60466175

## 🍎 전체 코드
```swift
import Foundation

let userInput = readLine()!.split(separator: " ").map { String($0) }
let tempString = userInput[0]
let tempRadix = Int(userInput[1])!

let strArr = Array(String(tempString.reversed()))
var total = 0
for i in 0..<strArr.count {
    var currentNumber = Int(strArr[i].asciiValue!)
    if 48 <= currentNumber && currentNumber <= 57 {
        currentNumber -= 48
        let tempNum = Int(pow(Double(tempRadix), Double(i)))
        total += tempNum * currentNumber
    } else {
        currentNumber -= 55
        let tempNum = Int(pow(Double(tempRadix), Double(i)))
        total += tempNum * currentNumber
    }
}
print(total)
```
