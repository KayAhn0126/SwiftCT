# 2798 블랙잭
- 브루트 포스

## 🍎 문제 접근 및 풀이
- 주어진 숫자들 중 꼭 3개의 숫자를 더해서 M을 넘지 않는 가장 가까운 수를 구하면 된다.
- 카드의 개수가 최대 100개이므로 100 * 100 * 100 = 100만
- 브루트 포스로 풀어도 되어서 3중 for loop으로 해결

## 🍎 전체 코드
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] // 주어지는 요소
let M = NM[1] // 목표값

let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var biggest = -987654321
for i in 0..<N-2 {
    for j in i+1..<N-1 {
        for k in j+1..<N {
            let currentSum = arr[i] + arr[j] + arr[k]
            if currentSum <= M {
                biggest = currentSum > biggest ? currentSum : biggest
            }
        }
    }
}
print(biggest)
```
