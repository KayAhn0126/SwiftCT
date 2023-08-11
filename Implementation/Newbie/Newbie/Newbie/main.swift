//
//  main.swift
//  Newbie
//
//  Created by Kay on 2023/08/11.
//

/*
 1946
 신입 사원
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
