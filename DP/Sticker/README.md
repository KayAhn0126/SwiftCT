# 9465 스티커
- DP

## 🍎 지문 해석
- 상냥이가 점수를 매긴 스티커를 변을 공유하지 않는 선에서 하나씩 떼어냈을때, 점수의 합이 최대는 경우를 구하는 문제.
- 즉, 스티커 하나를 떼어내면 해당 스티커의 상하좌우 위치에 있는 스티커는 훼손되어 사용할 수 없다.

## 🍎 문제 접근
- bottom-up 방식으로 마지막에 가장 큰 수를 출력하면 된다.
- 아래와 같은 2행 * n열이 있다고 해보자.
    - 50 10 100 20 40
    - 30 50 70  10 60
- 여기서 최대로 나올 수 있는 점수는 50 50 100 60인 스티커를 고르는 경우인 260이 된다.
- 50([0][0]) + 50([1][1]) + 100([0][2]) + 60([1][4])
- 100에서 60으로 점프하는 구간을 보면 매번 지그재그로 갈 필요없이 다음 column으로 넘어가도 된다는것이다. 포인트는 마지막 열에 도달 했을때 최대값이기만 하면 된다!

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation
var tc = Int(readLine()!)!

while tc != 0 {
    let n = Int(readLine()!)!
    var arr = [[Int]](repeating: [Int](), count: 2)
    for i in 0..<2 {
        arr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
    }
    var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: 2)
    dp[0][0] = arr[0][0]
    dp[1][0] = arr[1][0]
    if n > 1 {
        dp[0][1] = dp[1][0] + arr[0][1]
        dp[1][1] = dp[0][0] + arr[1][1]
        for i in 2..<n {
            dp[0][i] = max(dp[1][i-1], dp[1][i-2]) + arr[0][i]
            dp[1][i] = max(dp[0][i-1], dp[0][i-2]) + arr[1][i]
        }
    }
    print(max(dp[0][n-1], dp[1][n-1]))
    tc -= 1
}
```
