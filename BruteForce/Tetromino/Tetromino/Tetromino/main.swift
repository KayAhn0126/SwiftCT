//
//  main.swift
//  Tetromino
//
//  Created by Kay on 2023/03/16.
//

/*
 14500
 테트로미노
 */

/*
 처음에 생각했던 방법
 메서드 19개 만들어서 브루트포스 -> 시간도 코드도 비효율적!
 */

/*
 맵의 맥스를 아래 + 3, 우측 + 3을 해준다.
 
 5개의 모양을 회전 및 대칭해서 19개 모양을 만든다.
 이때 모양은 4 by 4 로 만들어준다. -> 나중에 맵에서 4 * 4로만 체크할것
 
 */

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
extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}
let fIO = FileIO()
//let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = fIO.readInt()
let M = fIO.readInt()

var adjMatrix = [[Int]](repeating: [Int](repeating: -100000, count: M + 3), count: N + 3)


for i in 0..<N {
    for j in 0..<M {
        adjMatrix[i][j] = fIO.readInt()
    }
}
/*
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
    adjMatrix[i].append(contentsOf: [-1000, -1000, -1000])
}
for _ in 0..<3 {
    adjMatrix.append([Int](repeating: -1000, count: M + 3))
}
*/

var tetrominoCollection: [[String]] = [
    [
        "1111",
        "0000",
        "0000",
        "0000"
    ],
    [
        "1000",
        "1000",
        "1000",
        "1000"
    ],
    [
        "1100",
        "1100",
        "0000",
        "0000"
    ],
    [
        "1000",
        "1000",
        "1100",
        "0000"
    ],
    [
        "1110",
        "1000",
        "0000",
        "0000"
    ],
    [
        "1100",
        "0100",
        "0100",
        "0000"
    ],
    [
        "0010",
        "1110",
        "0000",
        "0000"
    ],
    [
        "0100",
        "0100",
        "1100",
        "0000"
    ],
    [
        "1000",
        "1110",
        "0000",
        "0000"
    ],
    [
        "1100",
        "1000",
        "1000",
        "0000"
    ],
    [
        "1110",
        "0010",
        "0000",
        "0000"
    ],
    [
        "1000",
        "1100",
        "0100",
        "0000"
    ],
    [
        "0110",
        "1100",
        "0000",
        "0000"
    ],
    [
        "0100",
        "1100",
        "1000",
        "0000"
    ],
    [
        "1100",
        "0110",
        "0000",
        "0000"
    ],
    [
        "1110",
        "0100",
        "0000",
        "0000"
    ],
    [
        "0100",
        "1100",
        "0100",
        "0000"
    ],
    [
        "0100",
        "1110",
        "0000",
        "0000"
    ],
    [
        "1000",
        "1100",
        "1000",
        "0000"
    ],
]

func checkAndGetCurrentResult(_ y: Int, _ x: Int, _ k: Int) -> Int {
    var result = 0
    //tetrominoCollection과 map을 동시에 사용해야한다. 이 부분이 조금 어렵다!
    for i in 0..<4 {
        for j in 0..<4 {
            result += Int(String(tetrominoCollection[k][i][j]!))! * adjMatrix[y+i][x+j]
        }
    }
    return result
}

var result = -100000
var tempResult = 0
for i in 0..<N {
    for j in 0..<M {
        for k in 0..<tetrominoCollection.count {
            tempResult = checkAndGetCurrentResult(i, j, k) // (i,j)는 현재 위치
            result = tempResult > result ? tempResult : result
        }
    }
}
print(result)
