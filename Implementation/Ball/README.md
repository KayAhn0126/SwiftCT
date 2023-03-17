# 1547 공

## 🍎 문제 접근
- 컵 1,2,3이 차례대로 놓여있고 처음에는 1번 컵 아래에 공이 놓여있다.
- 주어지는 입력은 컵의 위치를 바꾸는것이다.
- 만약 2 3 이렇게 주어진다면
- 컵의 위치는 1,3,2로 될것이다.
- 이 상태에서 1 2 이렇게 주어진다면
- 2,3,1이 된다.

## 🍎 문제 풀이
- from과 to를 받고 arr를 돌다가 현재 자리의 값이 from과 같다면 그 자리에 to를 넣어주고,
- 현재 자리의 값이 to와 같다면 그 자리에 from을 넣어주면 된다.
- 마지막에는 공이 어느 컵 아래에 있는지 출력해야하니 그 상태에서 첫번째 컵을 출력하면 된다.

## 🍎 전체 코드
```swift
import Foundation

var number = Int(readLine()!)!

var arr: [Int] = [1,2,3]

for i in 0..<number {
    let userInput = readLine()!.split(separator:  " ").map { Int(String($0))! }
    let from = userInput[0]
    let to = userInput[1]
    arr.enumerated().forEach {
        if $0.element == from {
            arr[$0.offset] = to
        } else if $0.element == to {
            arr[$0.offset] = from
        }
    }
}
print(arr[0])
```
