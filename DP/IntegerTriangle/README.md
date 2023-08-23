# 1932 정수 삼각형
- DP

## 🍎 지문 해석
- 삼각형의 가장 위에서 가장 아랫줄까지 도달 했을때, 내려오면서 선택된 수의 합이 최대가 되는 경로를 구해 그 크기를 출력하는것이 문제

## 🍎 문제 접근
- bottom-up 방식으로 dp[0][0]만 채워넣고 내려가면서 더 큰수로 채우기

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

let N = Int(readLine()!)!
var arr = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
    arr[i].append(contentsOf: temp)
}
//MARK: DP 배열 및 초기값 설정
var dp = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
dp[0][0] = arr[0][0]

if N > 1 {
    dp[1][0] = dp[0][0] + arr[1][0]
    dp[1][1] = dp[0][0] + arr[1][1]
    for i in 2..<N {
        for j in 0...i {
            if j == 0 {            // 첫번째 열
                dp[i][j] = dp[i-1][j] + arr[i][j]
            } else if j == i {    // 마지막 열
                dp[i][j] = dp[i-1][j-1] + arr[i][j]
            } else {            // 첫번째 열과 마지막 열이 아닌 모든 열
                dp[i][j] = max(dp[i-1][j-1], dp[i-1][j]) + arr[i][j]
            }
        }
    }
}
print(dp[N-1].max()!)
```
