# 1325 효율적인 해킹

## 🍎 키워드
- 빠른 IO
- 배열과 인덱스를 이용한 Queue
- 인접 리스트 설계
- BFS
- 최대값이 2개 이상일때 처리 방법 + 오름차순

## 🍎 문제 설계
- 지문에서 "이 회사의 컴퓨터는 신뢰하는 관계와, 신뢰하지 않는 관계로 이루어져 있는데, A가 B를 신뢰하는 경우에는 B를 해킹하면, A도 해킹할 수 있다는 소리다."를 보고 인접리스트가 생각났다.
- 예제 입력을 보자
```swift
5 4
3 1
3 2
4 3
5 3
```
- N = 5, M = 4
- 총 컴퓨터 숫자 5 어떤 컴퓨터가 어떤 컴퓨터를 신뢰하는지 알려주는 믿음 고리 4개(간선)
- 3 (이 컴퓨터가) 1 (이 컴퓨터를 신뢰)
- 3 (이 컴퓨터가) 2 (이 컴퓨터를 신뢰)
- 4 (이 컴퓨터가) 3 (이 컴퓨터를 신뢰)
- 5 (이 컴퓨터가) 3 (이 컴퓨터를 신뢰)
- X컴퓨터를 신뢰하는 컴퓨터들 Y를 아래와 같이 인접리스트로 표현할 수 있다.
- [1][3]
- [2][3]
- [3][4,5]

## 🍎 문제 해결
- N의 범위가 10,000이고 시간복잡도는 O(10000 * 9999)인 O(N^2)으로 잡았다
- 아래와 같은 경우가 생길 수 있기 때문에..
    - [1][2] -> 1번을 신뢰하는 2번 컴퓨터
    - [2][3] -> 2번을 신뢰하는 3번 컴퓨터
    - [3][4] -> 3번을 신뢰하는 4번 컴퓨터
    - [4][5] -> ...
    - [5][6] -> ...
    - [6][7] -> ...
    - [7][8]
    - [8][9]
    - [9][10]
    - [10][11]
    - [N][N+1]  -> N번을 신뢰하는 N+1번 컴퓨터
- 10000 * 10000? 브루트포스 레츠고!
- bfs를 이용해서 한 depth씩 들어갈때마다 해킹 숫자에 +1을 해준다.
```swift
for i in 1...N {
    let result = bfs(i)
    biggestNum = biggestNum > result ? biggestNum : result
    biggestList[i] = result
}
```
- biggestNum은 최대값을 갱신하는 변수이고 biggestList는 값들이 저장되는 배열이다.
- 위와 같은 코드는 최대값이 2개 이상일수도 있을때 사용한다.
- biggestList 배열에서 biggestNum과 같은 값을 가지는 모든 위치 출력
```swift
for i in 1...N {
    if biggestNum == biggestList[i] {
        print(i, terminator: " ")
    }
}
```

## 🍎 놓친 부분
- 처음엔 방문 배열을 사용하지 않고 풀었다.
- 다시 생각해보니, 예제 입력에는 나와있지 않지만 두 대의 컴퓨터가 서로 신뢰하고 있는 경우, 내가 사용한 로직이 정상적이지 않게 작동할 수 있어서 방문 배열을 사용했다.
- 예시
- [1][3]
- [3][1]
- 방문 체크를 안해주면 dfs 함수가 계속 실행되서 끝나지 않았을것.

## 🍎 최대값이 2개 이상일때 처리 방법 + 오름차순
```swift
for i in 1...N {
    clearVisited()
    let number = dfs(i)
    biggestList[i] = number
    biggestNum = biggestList[i] > biggestNum ? biggestList[i] : biggestNum
}

for i in 1...N {
    if biggestNum == biggestList[i] {
        print(i, terminator: " ")
    }
}
```

## 🍎 배열과 idx변수를 Queue처럼 사용하기
```swift
func bfs(_ node: Int) -> Int {
    var bfsQueue = [Int](), idx = 0
    var visited = [Int](repeating: 0, count: N + 1)
    var count = 1
    visited[node] = count
    bfsQueue.append(node)
    while idx < bfsQueue.count {
        let number = bfsQueue[idx]; idx += 1
        for element in adjList[number] {
            if visited[element] != 0 { continue }
            count += 1
            visited[element] = 1
            bfsQueue.append(element)
        }
    }
    return count
}
```

## 🍎 처음에 빠른 I/O를 사용해서 풀었던 방법 + BFS
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

let N = fIO.readInt()
let M = fIO.readInt()

var adjList = [[Int]](repeating: [Int](), count: N + 1)

var biggestList = [Int](repeating: 0, count: N + 1)
var biggestNum = -100000

for _ in 0..<M {
    let by = fIO.readInt()
    let trusted = fIO.readInt()
    adjList[trusted].append(by)
}

func bfs(_ node: Int) -> Int {
    var bfsQueue = [Int](), idx = 0
    var visited = [Int](repeating: 0, count: N + 1)
    var count = 1
    visited[node] = count
    bfsQueue.append(node)
    while idx < bfsQueue.count {
        let number = bfsQueue[idx]; idx += 1
        for element in adjList[number] {
            if visited[element] != 0 { continue }
            count += 1
            visited[element] = 1
            bfsQueue.append(element)
        }
    }
    return count
}

for i in 1...N {
    let result = bfs(i)
    biggestNum = biggestNum > result ? biggestNum : result
    biggestList[i] = result
}

for i in 1...N {
    if biggestList[i] == biggestNum {
        print(i, terminator: " ")
    }
}
print("")
```

## 🍎 빠른 입출력 없이 풀었던 방법 + DFS + 참조
- 이 문제는 무조건 빠른 입출력이 있어야 풀 수 있는 문제인줄 알았는데 코드가 느렸던 이유는 따로 있다.
- 전역 변수(배열)를 매번 호출 하는것 보다 인자에 배열의 참조(객체의 실제 위치를 가리키는 포인터)를 넣으면 더 빠르다!
    - 참조를 하게 되면 사용하는 동안에는 배열의 참조가 스택의 레지스터에 쌓여서 실행 되고 레지스터는 가장 빠른 메모리이기 때문에 더 빠른것이라고 추측한다.
```swift
import Foundation
let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjList = [[Int]](repeating: [Int](), count : N + 1)

for i in 0..<M {
    let byTrusted = readLine()!.split(separator: " ").map { Int(String($0))! }
    let by = byTrusted[0]
    let trusted = byTrusted[1]
    adjList[trusted].append(by)
}

var biggestArr = [Int](repeating: 0, count: N + 1)

var max = Int.min
func dfs(_ adjList: inout [[Int]], _ num: Int, _ visited: inout [Bool], _ tempResult: inout Int) {
    visited[num] = true
    for i in adjList[num] {
        if visited[i] == true { continue }
        tempResult += 1
        dfs(&adjList, i, &visited, &tempResult)
    }
}

var result = 0
for i in 1...N {
    var tempResult = 0
    var visited = [Bool](repeating: false, count: N + 1)
    dfs(&adjList, i, &visited, &tempResult)
    biggestArr[i] = tempResult
    max = tempResult > max ? tempResult : max
}

var resultArr = [Int]()
for i in 1...N {
    if biggestArr[i] == max {
        resultArr.append(i)
    }
}

resultArr.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")

```
