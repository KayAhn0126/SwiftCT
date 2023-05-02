# 11048 이동하기
- DP

## 🍎 문제 접근
- 현재 기점으로 좌, 상, 좌상 중 가장 큰 숫자와 현재 위치의 숫자를 더해서 DP의 현재 위치에 대입해주면 된다.
- 그럼 dp(1,1)은 어떻게 구할것인가?
- 가장 왼쪽, 가장 윗쪽에 0들을 넣어준다.
- 입력으로 주어지는 값들은 1,1부터 차례대로 넣는다.
- 마지막에 dp[N][M]을 구하면 된다.

## 🍎 문제 풀이
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var dp = [[Int]](repeating: [Int](repeating: 0, count: M+1), count: N+1)

for i in 1..<N+1 {
    var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    for j in 1..<M+1{
        dp[i][j] = arr[j-1]
    }
}

for i in 1..<N+1 {
    for j in 1..<M+1 {
        dp[i][j] = max(dp[i-1][j-1], dp[i-1][j], dp[i][j-1]) + dp[i][j]
    }
}
print(dp[N][M])
```
