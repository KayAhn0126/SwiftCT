# 17404 RGB 거리 2

## 🍎 문제 접근
- **한줄에 나와있는 각각의 숫자는 각 줄의 집을 색칠하는데 필요한 Cost이다.**
- RGB 거리 문제와 비슷하지만 다른점이 있다.
- 먼저 기존 RGB거리는 첫 집에 무슨색을 칠하던지 상관없고,결국에 마지막 집을 색칠 할 때,
    - 이전 집의 색상과 달라야 하고
    - 오는 비용이 최소비용이면 되었다.
- 하지만, RGB 거리 2 문제는 조건이 추가 되었다.
    - 1번 집의 색은 2번, **N번 집의 색과 같지 않아야 한다**.
    - N번 집의 색은 N-1번, **1번 집의 색과 같지 않아야 한다**.
    - i(2 ≤ i ≤ N-1)번 집의 색은 i-1, i+1번 집의 색과 같지 않아야 한다.
- 제일 중요하게 생각해야 할 것은 **1번에 있는 집의 색상이 N번의 집의 색상과 같으면 안된다**.

## 🍎 문제 풀이
### 전체적인 흐름
- 전처리
    - 처음에 집을 특정 색상으로 먼저 칠해주고 나머지 비용을 아주 큰 수인 10000000으로 둘것이다.
    - 만약 첫번째 집을 Red로 칠했다고 가정하고 나머지를 그대로 두게 되면 아래와 같다.
    -  R    G     B
    - 26   10    20
    - 다음 집을 칠하는데 minumum비용 따지기 때문에 G나 B가 선택 당할수 있고 그것은 Red로 칠한것이 아니게 되기 때문이다!
    - 그래서 현재 칠하지 않은 색상의 비용을 10000000으로 두게 되면 다음 집을 칠할 비용을 고민할 때, G나 B를 선택하지 않는다. 이는 곧 아래와 같이 첫 집을 Red로 칠한것이 된다.
    -  R       G        B
    -  26   10000000 10000000
- 최소비용 구하기 로직
```swift
for k in 1..<streetCount {
    dp[k][0] = min(dp[k-1][1], dp[k-1][2]) + streetsArr[k][0]
    dp[k][1] = min(dp[k-1][0], dp[k-1][2]) + streetsArr[k][1]
    dp[k][2] = min(dp[k-1][0], dp[k-1][1]) + streetsArr[k][2]
}
```
- 1번과 N번이 같은 색상인 경우를 배제하기
```swift
for l in 0..<3 {
    if i == l {
        continue
    }
    result = result > dp[streetCount-1][l] ? dp[streetCount-1][l] : result
}
```

## 🍎 전체 코드
```swift
import Foundation

let streetCount = Int(readLine()!)!
let max = 987654321

var streetsArr = [[Int]](repeating: [Int](), count: streetCount)
for i in 0..<streetCount {
    streetsArr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var result = 987654321
for i in 0..<3 {
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: streetCount)
    for j in 0..<3 {
        if i == j {
            dp[0][j] = streetsArr[0][j]
            continue
        }
        dp[0][j] = max
    }
    
    for k in 1..<streetCount {
        dp[k][0] = min(dp[k-1][1], dp[k-1][2]) + streetsArr[k][0]
        dp[k][1] = min(dp[k-1][0], dp[k-1][2]) + streetsArr[k][1]
        dp[k][2] = min(dp[k-1][0], dp[k-1][1]) + streetsArr[k][2]
    }
    
    for l in 0..<3 {
        if i == l {
            continue
        }
        result = result > dp[streetCount-1][l] ? dp[streetCount-1][l] : result
    }
}
print(result)
```
