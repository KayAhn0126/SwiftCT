//
//  main.swift
//  DrawingALine
//
//  Created by Kay on 2023/04/26.
//

/*
 2170
 선 긋기
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
