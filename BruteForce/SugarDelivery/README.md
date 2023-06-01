# 2839 설탕배달
- 구현

## 🍎 문제 접근
- 먼저 큰 봉지인 5KG 봉지로 바로 나눌수 있다면 그것이 베스트.
- 아니라면 3KG 봉지에 한번 담고 다시 5KG로 나눌수 있는지 확인한다.
- 위의 작업을 계속 반복하다 만약 설탕이 0보다 작게 내려가면 -1 출력 후 종료.

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

var n = Int(readLine()!)!
var result = 0

while true {
    if n % 5 == 0 {
        result += (n/5)
        print(result)
        break
    }
    n -= 3
    result += 1
    if n < 0 {
        print(-1)
        break
    }
}
```
