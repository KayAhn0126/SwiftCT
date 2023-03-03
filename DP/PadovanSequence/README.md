# 9461 파도반 수열
- bottom up 방식

## 🍎 문제 접근
- 기초 DP 문제로 패턴을 찾아 점화식으로 구현하면 된다.
- 첫 10개의 숫자를 보면 아래와 같다.
- 1,1,1,2,2,3,4,5,7,9
- 즉 패턴은 -> **현재 숫자를 구하려면 전전 숫자와 전전전 숫자를 더하면 된다**.
- **DP[i] = DP[i-2] + DP[i-3]**

## 🍎 문제 풀이
```swift
import Foundation

let testCase = Int(readLine()!)!

var DP = [Int](repeating: 0, count: 101)

DP[1] = 1
DP[2] = 1
DP[3] = 1
DP[4] = 2
DP[5] = 2
DP[6] = 3
DP[7] = 4
DP[8] = 5
DP[9] = 7
DP[10] = 9

for i in 11...100 {
    DP[i] = DP[i-2] + DP[i-3]
}

for i in 0..<testCase {
    let testNum = Int(readLine()!)!
    print(DP[testNum])
}
```
- bottom up으로 다 구해놓고 출력만 해주면 된다.
