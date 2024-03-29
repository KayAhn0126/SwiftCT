# 1904 01타일
- bottom up 방식으로 해결

## 🍎 문제 접근
- 기초적인 DP 문제
- "무엇을 했을 때 몇가지 경우가 나온다" 라는것이 처음에 주어진다 그것의 패턴을 찾아 점화식을 세우고 문제를 풀면 된다.
- 패턴
```bash
 N |            가짓수                | 총갯수
 --|--------------------------------|------
 1 | 1                              |  1
 2 | 00, 11                         |  2
 3 | 001, 100, 111                  |  3
 4 | 0011, 0000, 1001, 1100, 1111   |  5
```
- 총 갯수의 패턴을 보면 1 - 2 - 3 - 5 - 8 - 13 처럼 앞의 두 수를 더해서 현재의 수를 만들어내는
- 피보나치 수열인것을 알 수 있다.

## 🍎 문제 풀이
- 전체 코드
```swift
import Foundation

let N = Int(readLine()!)!

var DP = [Int](repeating: 0, count: 1000001)

DP[1] = 1
DP[2] = 2
DP[3] = 3
DP[4] = 5
for i in 5...1000000 {
    DP[i] = (DP[i-1] + DP[i-2]) % 15746
}

print(DP[N])
```
