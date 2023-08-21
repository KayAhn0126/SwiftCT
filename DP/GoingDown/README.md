# 2096 내려가기
- DP

## 🍎 지문 해석
- N * 3의 표에 각 행마다 숫자가 세개씩 적혀있다.
- 내려가기 게임을 하는데, 조건이 있다.
    - 바로 아래의 수로 내려가거나, 아래의 수와 붙어있는 수로만 내려갈 수 있다.
    - 즉, 현재 위치가 [0][0]일때 [1][0] 또는 [1][1]로 이동이 가능
    - 현재 위치가 [0][1]일때 [1][0] 또는 [1][1] 또는 [1][2]로 이동이 가능
    - 현재 위치가 [0][2]일때 [1][1] 또는 [1][2]로 이동이 가능

## 🍎 문제 접근
- 2개의 2차원 DP 배열을 만들어야한다.
    - 하나는 최대, 하나는 최소
- 현재 숫자들이 주어져있는 배열 arr를 사용해서 DP 배열을 채워나가자!
- 하라는대로 점화식을 세우면 된다!

## 🍎 문제 풀이
```swift
import Foundation

let N = Int(readLine()!)!
var arr = [[Int]]()
for _ in 0..<N {
    arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

//MARK: max와 min 2차원 배열 각각 생성
var maxDP = [[Int]](repeating: [Int](repeating: 0, count: 3), count: N)
var minDP = [[Int]](repeating: [Int](repeating: 0, count: 3), count: N)

//MARK: 각 maxDP와 minDP의 첫 행을 초기화
for i in 0..<3 {
    maxDP[0][i] = arr[0][i]
    minDP[0][i] = arr[0][i]
}

//MARK: maxDP 점화식
for i in 1..<N {
    for j in 0..<3 {
        if j == 0 {
            maxDP[i][j] = max(maxDP[i-1][j] + arr[i][j], maxDP[i-1][j+1] + arr[i][j])
        } else if j == 1 {
            maxDP[i][j] = max(maxDP[i-1][j-1] + arr[i][j], maxDP[i-1][j] + arr[i][j], maxDP[i-1][j+1] + arr[i][j])
        } else {
            maxDP[i][j] = max(maxDP[i-1][j-1] + arr[i][j], maxDP[i-1][j] + arr[i][j])
        }
    }
}

//MARK: minDP 점화식
for i in 1..<N {
    for j in 0..<3 {
        if j == 0 {
            minDP[i][j] = min(minDP[i-1][j] + arr[i][j], minDP[i-1][j+1] + arr[i][j])
        } else if j == 1 {
            minDP[i][j] = min(minDP[i-1][j-1] + arr[i][j], minDP[i-1][j] + arr[i][j], minDP[i-1][j+1] + arr[i][j])
        } else {
            minDP[i][j] = min(minDP[i-1][j-1] + arr[i][j], minDP[i-1][j] + arr[i][j])
        }
    }
}

//MARK: 마지막 행에서 가장 큰 수와 가장 작은 수를 찾으면 답!
var resultMax = maxDP[N-1].max()!
var resultMin = minDP[N-1].min()!
print(resultMax, resultMin)

```
