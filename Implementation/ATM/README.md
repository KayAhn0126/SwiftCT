# 11399 ATM
- 구현 및 정렬

## 🍎 문제 접근
- 먼저 배열로 사람들이 인출하는데 걸리는 시간을 입력받고 시간이 짧은 순서대로 정렬했다.
- 이후 각 인원들이 걸리는 시간을 total에 담아서 출력하면 되는 문제!

## 🍎 문제 풀이
```swift
import Foundation

let N = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var result = 0
var adder = 0
arr.enumerated().sorted(by: {
    return $0.element < $1.element
}).forEach {
    adder += $0.element
    result += adder
}
print(result)
```
