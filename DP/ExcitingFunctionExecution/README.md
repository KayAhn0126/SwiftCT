# 9184 신나는 함수 실행
- 메모이제이션

## 🍎 문제 접근
- 문제를 보면 다음과 같은 재귀함수가 있다고 한다.
```bash
if a <= 0 or b <= 0 or c <= 0, then w(a, b, c) returns:
    1

if a > 20 or b > 20 or c > 20, then w(a, b, c) returns:
    w(20, 20, 20)

if a < b and b < c, then w(a, b, c) returns:
    w(a, b, c-1) + w(a, b-1, c-1) - w(a, b-1, c)

otherwise it returns:
    w(a-1, b, c) + w(a-1, b-1, c) + w(a-1, b, c-1) - w(a-1, b-1, c-1)
```
- 문제는 a = 15, b = 15, c = 15를 넣었을 때 중복으로 계산되는 부분이 많아서 오랜 시간이 걸린다.
- 메모이제이션을 통해 이미 구해놓은 값이 있다면 해당 값을 반환해 중복되는 시간을 줄이면 된다.

## 🍎 문제 풀이
```swift
import Foundation

var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 51), count: 51), count: 51)

func solve(_ a: Int, _ b: Int, _ c: Int) -> Int {
    if a <= 0 || b <= 0 || c <= 0 {
        return 1
    } else if dp[a][b][c] != 0 {
        return dp[a][b][c]
    } else if a > 20 || b > 20 || c > 20 {
        dp[a][b][c] = solve(20,20,20)
        return dp[a][b][c]
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
}
```
