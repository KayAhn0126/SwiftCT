# 1946 신입 사원
- 구현
- 정렬

## 🍎 문제 접근
- 문제를 처음에 잘못 읽어서 오래 걸렸다.
- 처음엔 숫자들이 점수인줄 알았지만, 순위였다.
    - 지문을 꼼꼼하게 읽어야한다.
- 서류 순위와 면접 시험 순위가 각각 인원수 만큼 주어지는데, 이를 서류 순위 기준으로 오름차순 정렬한다.
- 예를 들면, 아래와 같이 주어질때, 
```bash    
7
3 6
7 3
4 2
1 4
5 7
2 5
6 1
```
- 이를 서류 순위를 기준으로 오름차순 정렬한다.
```bash
1 4
2 5
3 6
4 2
5 7
6 1
7 3
```
- "어떤 지원자 A의 성적이 다른 어떤 지원자 B의 성적에 비해 서류 심사 결과와 면접 성적이 모두 떨어진다면 A는 결코 선발되지 않는다." 는 기준이 있으므로 서류 순위를 내려가면서, 
    - 만약 면접 시험 순위가 현재까지 오면서 갱신한 최고 순위보다 낮다면 탈락시키는 로직으로 구현하면 된다.
    - 현재까지 오면서 갱신한 면접의 최고 순위를 저장하기 위해 max라는 변수를 만들어 현재까지 면접 최고 순위를 저장한다.
- 위의 예시를 통해 알아보자
- 처음에 1 4는 서류 순위가 1등, 면접 시험 순위가 4등이라는 뜻이다.
    - max = 4
    - 서류에서 다음 순위의 면접 시험 순위가 4보다 낮으면 탈락이다.
- 다음 등수인 2등을 보자.
    - 면접 시험 순위가 5등이기 때문에 탈락.
    - 현재 max = 4
- 그 다음 등수인 3등을 보자.
    - 면접 시험 순위가 6등이기 때문에 탈락.
    - 현재 max = 4
- 그 다음 등수인 4등을 보자.
    - 면접 시험 순위가 2등이다.
    - 서류 순위 1등의 면접 시험 순위 보다 높기 때문에 합격이다.
    - 이제 다음 등수부터는 2등보다 높아야 합격이다.
    - 왜?
    - 만약 max를 바꾸지 않고 4로 냅둔다고 가정해보자.
    - 다음 등수 5등이 만약,
        - 서류 5등, 면접 3등 이라면 합격이다.
        - 하지만 반례로, 현재 등수 4등은 서류 4등, 면접 2등이기 때문에 5등은 탈락한다.
        - 그렇기 때문에 max를 계속 높은 수로 갱신해야 한다.
- 그 다음 등수인 5등을 보자.
    - 면접 시험 순위가 7등이기 때문에 탈락.
- 그 다음 등수인 6등을 보자.
    - 면접 시험 순위가 1등이기 때문에 합격.
- 마지막 7등을 보자.
    - 면접 시험 순위가 max(최고 순위)보다 크기때문에 탈락.

## 🍎 전체 코드
- 입력의 갯수가 10만개이기 때문에 빠른 입출력 사용
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

var tc = fIO.readInt()
var result = [Int]()

while tc != 0 {
    let total = fIO.readInt()
    var arr = [(Int,Int)]()
    for _ in 0..<total {
        let first = fIO.readInt()
        let second = fIO.readInt()
        arr.append((first, second))
    }
    arr = arr.sorted(by: {
        return $0.0 < $1.0
    })
    var count = 1
    var max = arr[0].1
    for i in 1..<arr.count {
        if arr[i].1 < max {
            count += 1
            max = arr[i].1
        }
    }
    result.append(count)
    tc -= 1
}

result.enumerated().forEach {
    print($0.element)
}
```
