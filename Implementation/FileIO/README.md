# File IO
- [조수환님 gist](https://gist.github.com/JCSooHwanCho/30be4b669321e7a135b84a1e9b075f88)
- [숫자 카드 2 문제 시간초과 해결 글](https://www.acmicpc.net/board/view/78491)
- [File IO 분석글](https://m.blog.naver.com/gustn3964/222258493870)

## 🍎 기본 코드
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
```

## 🍎 사용법
- 아래와 같은 입력이 주어진다고 해보자

    5
    1 2 3 4 5

- 위와 같은 입력을 일반적으로 받는다면,
```swift
import Foundation

let N = Int(readLine()!)!
var arr = [Int]()
arr.append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
```
- 이런식으로 받을 수 있다.
- 하지만 File IO 클래스를 이용해 받는다면 아래와 같이 입력 해주어야 한다.
```swift
let fIO = FileIO()

let N = fIO.readInt()

var arr = [Int]()
for i in 0..<N {
    arr.append(fIO.readInt())
}
```
- 신기한 점은 1 2 3 4 5 처럼 공백과 함께 주어지는 입력도 readInt()로 받는다.
- Xcode에서 실행시, 모든 입력을 마치고 EOF(Control + D)를 통해 buffer에 입력을 더 걸어주지 않음을 알려주는 방식으로 사용해야 한다.
