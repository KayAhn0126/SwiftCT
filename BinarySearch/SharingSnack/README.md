# 16401 과자 나눠주기
- 이분탐색

## 🍎 문제 접근
- 이분탐색을 하면서 특정 숫자가 조건에 맞는지 계속 확인하면서 최대값을 구하는 문제.

## 🍎 조심해야 할 점
- checkIfPossible 함수에서 매개변수로 받아온 수로 배열의 요소를 나눠주는 코드가 있는데 이때 start가 0이 된다면 극한의 상황에서는 mid가 0이 되어서 0으로 나누는 상황이 발생하고 이는 곧 런타임 에러를 발생 시킨다.

## 🍎 문제 풀이
```swift
import Foundation

let MN = readLine()!.split(separator: " ").map { Int(String($0))! }
let headCount = MN[0]
let snackCount = MN[1]

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

func checkNumber(_ number: Int) -> Bool {
    var result = 0
    for i in 0..<arr.count {
        result += (arr[i] / number) // number가 0이 되면 안되므로 아래의 이분탐색 코드에서 start를 1로 두어야 한다.
    }
    if result >= headCount {
        return true
    }
    return false
}

var start = 1
var end = 1000000000
var mid = 0
var result = 0
while start <= end {
    mid = (start + end) / 2
    if checkNumber(mid) == true {
        start = mid + 1
        result = mid
    } else {
        end = mid - 1
    }
}
print(result)
```
