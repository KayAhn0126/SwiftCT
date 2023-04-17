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

var adjList = [[Int]](repeating: [Int](), count : N + 1)

for i in 0..<M {
    let from = fIO.readInt()
    let to = fIO.readInt()
    adjList[to].append(from)
}

var currentArr = [Int](repeating: 0, count: N + 1)

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
    currentArr[i] = tempResult
    max = tempResult > max ? tempResult : max
}

var resultArr = [Int]()
for i in 1...N {
    if currentArr[i] == max {
        resultArr.append(i)
    }
}

resultArr.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
