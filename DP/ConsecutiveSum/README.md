# 1912 연속합

## 🍎 문제 접근
- n개의 정수로 이루어진 임의의 수열이 주어진다.
- 이중 연속된 몇 개의 수를 선택해서 구할 수 있는 합 중 가장 큰 합을 구하면 된다.
- DP 문제를 풀때는 내가 직접 상황을 겪는다고 생각해보면 조금 더 쉽다.
- 예를들어 아래와 같은 입력이 주어졌다.
```bash
10
10 -4 3 1 5 6 -35 12 21 -1
```
- 인덱스 1의 입장을 보면 이전 숫자 10과 자신을 더한것(6)과 현재 자신(-4)중 큰 값은 6이다.
- 즉, 현재값과 이전값을 더한것을 A
- 현재값을 B라고 했을때
- A와 B를 비교해서 더 큰것을 선택하면 된다.

## 🍎 전체 코드
```swift
import Foundation

let numCount = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var dp = [Int](repeating: 0, count: numCount)

dp[0] = arr[0]

var biggestNumber = dp[0]
for i in 1..<numCount {
    dp[i] = max(dp[i-1] + arr[i], arr[i])
    biggestNumber = dp[i] > biggestNumber ? dp[i] : biggestNumber
}

print(biggestNumber)
```
