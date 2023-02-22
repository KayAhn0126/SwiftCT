//
//  main.swift
//  EffectiveHacking
//
//  Created by Kay on 2023/01/10.
//

/*
 1325
 효율적인 해킹
 */
// 2nd week fast campus

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
