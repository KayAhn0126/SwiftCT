# 24416 피보나치 수 1

## 🍎 문제 접근
- 숫자가 주어지면 해당 숫자의 피보나치 값과 해당 값을 도출하기 위해 dp를 몇번 수행했는지 출력해주면 된다.
- 재귀함수로는 풀 수 없다!
- fibo(40) -> 시간초과
- dp로 풀어야 한다!
## 🍎 문제 풀이
- 전체 코드
```swift
import Foundation
var userInput = Int(readLine()!)!

// dp
var executionCountOfDP = 0
var dp = [Int](repeating: 0, count: 41)

dp[1] = 1
dp[2] = 1

for i in 3...userInput {
    dp[i] = dp[i-2] + dp[i-1]
    executionCountOfDP += 1
}
print(dp[userInput], executionCountOfDP)
```
