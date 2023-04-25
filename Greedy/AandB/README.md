# 12904 A와 B
- 구현
- 그리디

## 🍎 문제 접근
- S를 T로 바꿀 수 있으면 1, 없으면 0을 출력한다.
- 최악의 상황에 S의 길이가 1이고 T의 길이가 1000이 된다면 S를 T로 만드는 시간 복잡도는 O(2^1000)과 같다.
- 즉, S를 T로 만드는 방법(브루트 포스)로는 절대 풀 수 없음.
- 그러므로 T를 S로 만드는 방법을 찾아야한다.
- T의 길이가 1000이고 S의 길이가 1일때, T를 S로 만드는 시간 복잡도는 상수 O(1000)이다.
- 그러므로 이 문제는 T를 S의 크기만큼 줄였을때 같은지 확인하는 방법으로 풀어야 한다.

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

var S = readLine()!
var T = readLine()!

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

while true {
    if S.count == T.count {
        if S == T {
            print(1)
        } else {
            print(0)
        }
        break
    }
    if T[T.count-1]! == "A" {
        T.removeLast()
    } else {
        T.removeLast()
        T = String(T.reversed())
    }
}
```
