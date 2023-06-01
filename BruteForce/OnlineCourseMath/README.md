# 19523 수학은 비대면강의입니다.
- 브루트 포스

## 🍎 문제 접근
- 범위 내에서 모든 경우를 체크하면서 조건이 충족되는지 테스트한다.

## 🍎 문제 해결 및 전체 코드
```swift
import Foundation

var input = readLine()!.split(separator: " ").map { Int(String($0))! }
let a = input[0]
let b = input[1]
let c = input[2]
let d = input[3]
let e = input[4]
let f = input[5]

let target = c + f
for i in -999...999 {
    for j in -999...999 {
        let first = (a * i) + (b * j)
        let second = (d * i) + (e * j)
        if first == c && second == f {
            print(i, j)
            break
        }
    }
}
```
