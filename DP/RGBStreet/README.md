# 1149 RGB 거리
- bottom up
- memoization

## 🍎 문제 접근
- 모든 집을 칠하는 비용의 최솟값을 구하면 된다.
- 단,
    - 1번 집의 색은 2번 집의 색과 같지 않아야 한다.
    - N번 집의 색은 N-1번 집의 색과 같지 않아야 한다.
    - i번의 집의 색은 i-1, i+1번 집의 색과 같지 않아야 한다.

## 🍎 전체 코드
```swift
import Foundation

let streets = Int(readLine()!)!
var streetsArr = [[Int]](repeating: [Int](), count: streets)

for i in 0..<streets {
    streetsArr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: streets)
var prevStreet = streetsArr[0]

dp[0][0] = prevStreet[0] // 첫 집을 Red로 칠하는데 드는 비용
dp[0][1] = prevStreet[1] // 첫 집을 Green로 칠하는데 드는 비용
dp[0][2] = prevStreet[2] // 첫 집을 Blue로 칠하는데 드는 비용

for i in 1..<streets {
    // red
    dp[i][0] = min(dp[i-1][1], dp[i-1][2]) + streetsArr[i][0]
    // green
    dp[i][1] = min(dp[i-1][0], dp[i-1][2]) + streetsArr[i][1]
    // blue
    dp[i][2] = min(dp[i-1][0], dp[i-1][1]) + streetsArr[i][2]
}
print(min(dp[streets-1][0], dp[streets-1][1], dp[streets-1][2]))
```
- 이전 집의 색상과 다르기만 하면 되므로 현재 red의 비용을 계산할 때는 이전 레드를 아예 빼버리고 green과 blue 중 작은값을 구한다.
