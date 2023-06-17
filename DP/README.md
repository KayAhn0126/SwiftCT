# DP List

## 🍎 Easy
| 제목 | 키워드 | 풀어보기 |
| :-: | :-: | :-: |
| [1,2,3 더하기](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/AddingOneTwoThree) | DP | [9095](https://www.acmicpc.net/problem/9095) |
| [피보나치 수 1](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/FibonacciNumber) | bottom - up | [24416](https://www.acmicpc.net/problem/24416) |
| [파스칼의 삼각형](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/PascalsTriangle) | bottom - up | [16395](https://www.acmicpc.net/problem/16395) |
| [01타일](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/01Tile) | bottom - up | [1904](https://www.acmicpc.net/problem/1904) |
| [1로 만들기](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/MakeToOne) | 순서가 중요한 DP | [1463](https://www.acmicpc.net/problem/1463) |
| [신나는 함수 실행](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/ExcitingFunctionExecution) | 메모이제이션 | [9184](https://www.acmicpc.net/problem/9184) |
| [파도반 수열](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/PadovanSequence) | 패턴 찾기 + bottom - up | [9461](https://www.acmicpc.net/problem/9461) |
| [연속합](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/ConsecutiveSum) | 합이 최대인 부분배열 구하기 | [1912](https://www.acmicpc.net/problem/1912) |

## 🍎 Normal
| 제목 | 키워드 | 풀어보기 |
| :-: | :-: | :-: |
| [1로 만들기 2](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/MakeToOne2) | DP + 경로 추적 | [12852](https://www.acmicpc.net/problem/12852) |

## 🍎 Hard
| 제목 | 키워드 | 풀어보기 |
| :-: | :-: | :-: |
| [퇴사](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/Quit) | dp | [14501](https://www.acmicpc.net/problem/14501) |
| [계단 오르기](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/ClimbingStairs) | 규칙에 맞게 구현 + bottom - up | [2579](https://www.acmicpc.net/problem/2579) |
| [RGB거리](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/RGBStreet) | 구현 및 DP | [1149](https://www.acmicpc.net/problem/1149) |
| [RGB거리2](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/RGBStreet2) | 구현 및 DP | [17404](https://www.acmicpc.net/problem/17404) |

# DP 개념

## 🍎 재귀
- 재귀는 자기 자신을 호출하는것인데 기저사례를 만날 때까지 쪼개졌다가 반환된 값을 가지고 원래 구하려던 답을 만들어 준다.
- 재귀는 보통 top-down 형식.
- 하지만 단점도 있는데, 피보나치 수를 재귀를 통해 구한다면 큰수가 들어왔을때 많은 시간이 필요하다.
- 여기에 Memoization 개념이 추가되면 실행 속도를 많이 줄일 수 있다.

## 🍎 Memoization
- 이전에 구해놨던 값을 기억하고 있는것이다.
- 기존 재귀는 한번 구했던 값도 저장을 하지 않으니 다시 계산 했지만 기억을 하고 있으면 답을 반환해줌으로써 중복되는 계산을 피할 수 있다.
- 메모이제이션을 이용해 문제를 푸는것을 DP라고 한다.

## 🍎 재귀 + DP (top - down)
- [신나는 함수 실행 문제](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/ExcitingFunctionExecution)를 보자
```swift
import Foundation

var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 51), count: 51), count: 51)

func solve(_ a: Int, _ b: Int, _ c: Int) -> Int {
    if a <= 0 || b <= 0 || c <= 0 { // 재귀는 무조건 기저사례가 있어야 한다.
        return 1
    } else if dp[a][b][c] != 0 {
        return dp[a][b][c]
    } else if a > 20 || b > 20 || c > 20 {
        dp[a][b][c] = solve(20,20,20) // 메모이제이션 solve()함수가 값을 완전히 받아오기 전까지
        return dp[a][b][c]            // 여기는 실행되지 않는다.
    } else if a < b && b < c {
        dp[a][b][c] = solve(a, b, c-1) + solve(a, b-1, c-1) - solve(a, b-1, c)
        return dp[a][b][c]
    } else {
        dp[a][b][c] = solve(a-1, b, c) + solve(a-1, b-1, c) + solve(a-1, b, c-1) - solve(a-1, b-1, c-1)
        return dp[a][b][c]
    }
}

while let line = readLine() {
    let numbers = line.split(separator: " ").map { Int(String($0))! }
    let a = numbers[0]
    let b = numbers[1]
    let c = numbers[2]
    if a == -1 && b == -1 && c == -1 {
        break
    }
    print("w(\(a), \(b), \(c)) = \(solve(a,b,c))")
```
- 재귀적으로 실행되니 기저사례가 있고, solve()함수를 실행하면서 중간중간 계속 Memoization을 실행하고 있다.

## 🍎 반복문 + DP (bottom - up)
- [01타일 문제](https://github.com/KayAhn0126/SwiftCT/tree/main/DP/01Tile)
```swift
import Foundation

let N = Int(readLine()!)!

var DP = [Int](repeating: 0, count: 1000001)

DP[1] = 1
DP[2] = 2
DP[3] = 3
DP[4] = 5
for i in 5...1000000 { // 이미 가지고 있는 데이터를 기반으로 다음 해를 구한다.
    DP[i] = (DP[i-1] + DP[i-2]) % 15746
}

print(DP[N])
```
- **반복문 + DP 방식이 속도가 상대적으로 더 빠르다!**
