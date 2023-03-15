# 1436 영화감독 숌
- N의 범위가 1000만 아래
- O(N)으로 해결 가능
- 브루트포스

## 🍎 로직은 맞지만 시간초과인 코드
```swift
// contains 사용코드 -> 시간초과
import Foundation

let input = Int(readLine()!)!
var count = 0

if input == 0 {
    print("0")
} else {
    for i in 666...666 * 10000 { // 666부터 6660000
        if String(i).contains("666") == true {
            count += 1
        }
        if count == input {
            print(i)
            break
        }
    }
}
```
- contains 때문인것 같다

## 🍎 통과 코드
```swift
import Foundation

let userInput = Int(readLine()!)!

// 1666
// 26663
func checkThreeSix(_ number: Int) -> Bool {
    var testNumber = number
    var counter = 0
    while testNumber > 0 {
        if testNumber % 10 == 6 {
            counter += 1
            if counter == 3 {
                return true
            }
        } else {
            counter = 0
        }
        testNumber /= 10
    }
    return false
}

var counter = 0
for i in 666..<666*10000 {
    if checkThreeSix(i) == true {
        counter += 1
    }
    if counter == userInput {
        print(i)
        break
    }
}
```

## 🍎 느낀점
- checkThreeSix 함수처럼 패턴을 찾는게 중요하다.
