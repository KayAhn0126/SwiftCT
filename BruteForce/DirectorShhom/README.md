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
- 숫자에 666이 포함되는지 확인하는 방법을 어떤 블로그에서 발견해 사용했다.
```swift
import Foundation

let input = Int(readLine()!)!

var count = 0

func hasContainThreeSix(_ number: Int) -> Bool {
    var temp = number
    while temp >= 666 {
        if temp % 1000 == 666 { // 나머지가 666이 나와야 하니 적어도 1000으로 나눠야한다.
            return true
        }
        temp /= 10 // 자리수를 앞으로 한칸 옮긴다.
    }
    return false
}

if input == 0 {
    print("0")
} else {
    for i in 666...666 * 10000 { // 666부터 6660000
        if hasContainThreeSix(i) {
            count += 1
        }
        if count == input {
            print(i)
            break
        }
    }
}
```

## 🍎 느낀점
- hasContainThreeSix 함수처럼 패턴을 찾는게 중요하다.
- contains를 사용했을때 코드와 비교해도 큰 차이를 못느끼겠는데 나중에 알게되면 여기에 적어보자
