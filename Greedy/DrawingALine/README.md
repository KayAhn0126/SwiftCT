# 2170 선 긋기
- 그리디 (라인스위핑)
- 빠른 입출력

## 🍎 문제 풀이 전 확인해야 할 점
- 입력값이 최대 100만개가 주어진다.
- 일반적인 입출력으로 제출했고 시간초과가 났다.
- Swift는 입력값이 10만개 이상이라면 시간초과가 날 수 있으므로 빠른 입출력을 사용했다.

## 🍎 문제 접근
- 선을 그을 때에는 이미 선이 있는 위치에 겹쳐서 그릴 수도 있는데, 여러번 그은 곳과 한 번 그은 곳의 차이를 구별 할 수 없다.
- 이와 같은 식으로 선을 그었을 때, 그려진 선(들)의 총 길이를 구하면 되는데, 선이 여러 번 그려진 곳은 한 번씩만 계산한다.

## 🍎 문제 풀이
- 먼저 입력이 주어지면 배열 A에 저장해두고, 시작 점을 기준으로 A를 오름차순 정렬 했다.
    - 만약 시작점이 같다면 끝 점이 작은것이 앞으로 오도록 오름차순 정렬했다.
    ```swift
    arr.sort(by: {
        if $0.0 == $1.0 {
            return $0.1 < $1.1
        }
        return $0.0 < $1.0
    })
    ```
- 처음 주어진 선분의 시작점과 끝점을 start와 end로 놓고 다음 선분과 비교 하면서 아래의 로직을 진행한다.
    ```swift
    var start = arr[0].0
    var end = arr[0].1
    var total = 0

    for i in 1..<arr.count {
        let cmpStart = arr[i].0
        let cmpEnd = arr[i].1
        if cmpEnd <= end { // 이전 선분이 다음 선분을 포함하는 경우.
            continue
        } else if cmpStart <= end && end < cmpEnd { // 다음 선분의 시작점이 이전 선분의 끝 보다 작거나 같고, 다음 선분의 끝점이 이전 선분의 끝보다 확실히 클때.
            end = cmpEnd
        } else { // 이전 선분의 끝점이 다음 선분의 시작점 보다 확실히 작을때.
            total += end - start
            start = cmpStart
            end = cmpEnd
        }
    }
    total += end - start
    print(total)
    ```

## 🍎 이해를 돕기 위한 그림
![](https://i.imgur.com/GJdRiJo.png)
- 1번 상황에서는 시원하게 continue!
- 2번 상황에서는 start는 그대로 end만 늘려주기!
    - 이 상황을 어떻게 조건문으로 작성하지?
    - 다음 선분의 시작점이 이전 선분의 끝점 보다 작거나 같아야 하고 다음 선분의 끝점이 이전 선분의 끝점 보다 확실히 크면(초과) 된다!
- 3번 상황에서는 이전 상황을 정리(계산)해주고 start와 end를 다시 세팅하면 된다.
    - 이 상황을 어떻게 조건문으로 작성하지?
    - 다음 선분의 시작점이 이전 선분의 끝점 보다 확실히 크면(초과) 이어지지 않는 다른 선분이다!

## 🍎 전체 코드
```swift
import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

let fIO = FileIO()

let num = fIO.readInt()

var arr: [(Int,Int)] = []
for _ in 0..<num {
    let A = fIO.readInt()
    let B = fIO.readInt()
    if A > B {
        arr.append((B, A))
    } else {
        arr.append((A, B))
    }
}
arr.sort(by: {
    if $0.0 == $1.0 {
        return $0.1 < $1.1
    }
    return $0.0 < $1.0
})

var start = arr[0].0
var end = arr[0].1
var total = 0

for i in 1..<arr.count {
    let cmpStart = arr[i].0
    let cmpEnd = arr[i].1
    if cmpEnd <= end { // 이전 선분이 다음 선분을 포함하는 경우.
        continue
    } else if cmpStart <= end && end < cmpEnd { // 다음 선분의 시작점이 이전 선분의 끝 보다 작거나 같고, 다음 선분의 끝점이 이전 선분의 끝보다 확실히 클때.
        end = cmpEnd
    } else { // 이전 선분의 끝점이 다음 선분의 시작점 보다 확실히 작을때.
        total += end - start
        start = cmpStart
        end = cmpEnd
    }
}
total += end - start
print(total)

```
