//
//  main.swift
//  NumberCard2
//
//  Created by Kay on 2023/02/21.
//

/*
 10816
 숫자 카드 2
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

let N = fIO.readInt()

var sanggeunArr = [Int]()
for i in 0..<N {
    sanggeunArr.append(fIO.readInt())
}

// sanggeunArr.append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })

let M = fIO.readInt()
var checkArr = [Int]()
for i in 0..<M {
    checkArr.append(fIO.readInt())
}
//checkArr.append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })

var countArr = [Int](repeating: 0, count: 20000001)

// 최대 50만번
for number in sanggeunArr {
    countArr[number + 10000000] += 1
}

// 최대 50만번
for element in checkArr {
    print(countArr[element + 10000000], terminator: " ")
}
