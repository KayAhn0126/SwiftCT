# 2565 전깃줄
- LIS
- 구현
- 정렬

## 🍎 문제 접근
- 전깃줄이 교차하는 경우 합선의 위험이 있어 몇개의 전깃줄을 없애 교차하지 않도록 만들어야 한다.
- 그럼 최대 증가 수열의 길이를 구하고 전체(현재 주어진 전깃줄 수)에서 빼는 방법으로 접근한다.

## 🍎 정렬이 필요하다.
- 입력으로 주어지는 A전봇대와 B전봇대가 연결되는 위치는 순서대로 주어지지 않는다.
    - 주어지는대로 배열에 넣고 LIS를 구하면 최대값이 구해지지 않는다.
- 하지만 A전봇대를 기준으로 오름차순 정렬하면 최대 증가 수열의 길이를 구할 수 있다.

## 🍎 전체 코드 및 문제 풀이
```swift
import Foundation

let num = Int(readLine()!)!

var arr: [(Int,Int)] = []
var dp = [Int](repeating: 0, count: num)

for _ in 0..<num {
    let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = fromTo[0]
    let to = fromTo[1]
    arr.append((from, to))
}

// 최대 증가 수열의 길이를 구하기 위해서 정렬한다.
// 기본으로 주어지는 대로 배열에 넣고 LIS를 구하면 최대값이 나오지 않는다.
arr = arr.sorted(by: {
    return $0.0 < $1.0
})

var result = Int.min
for i in 0..<num {
    var latest = 0
    for j in 0..<i {
        // 현재 시작점이 이전 시작점보다 크고,
        // 현재 끝점이 이전 끝점보다 크고,
        // 최대 증가 수열의 길이를 체크하기 위한 dp[j]의 길이가 이전까지 최대값을 저장해온 latest보다 크다면, 
        if arr[j].0 < arr[i].0 && arr[j].1 < arr[i].1 && latest < dp[j] {
            // latest를 업데이트 해준다.
            latest = dp[j]
        }
    }
    dp[i] = latest + 1
    result = dp[i] > result ? dp[i] : result
}
print(num - result)

```
