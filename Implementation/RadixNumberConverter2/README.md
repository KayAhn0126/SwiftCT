# 11005 진법 변환 2
- 구현
- 10진법의 수 -> B진법의 수

## 🍎 문제 접근
- 10진수의 어떤 수를 N진수로 나타내는것이다.
- 100(10진수)를 2진수로 나타내보자
    - 먼저 답은 110 0100 이다.
    - 100을 2로 나눴을때 나머지는 0
    - 50을 2로 나눴을때 나머지는 0
    - 25를 2로 나눴을때 나머지는 1
    - 12를 2로 나눴을때 나머지는 0
    - 6을 2로 나눴을때 나머지는 0
    - 3을 2로 나눴을때 나머지는 1
    - 1을 2로 나눴을때 나머지는 1, 이때 몫이 0이 되서 끝.
- 역순으로 출력하면 된다.

## 🍎 전체 코드
```swift
import Foundation

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }
var tempNum = userInput[0]
let tempRadix = userInput[1]

var result = ""
while tempNum != 0 {
    let num = tempNum % tempRadix
    if num < 10 { result += String(num) }
    else { result += String(UnicodeScalar(num-10+65)!) }
    tempNum /= tempRadix
}
print(String(result.reversed()))
```
