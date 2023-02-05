//
//  main.swift
//  Sequence
//
//  Created by Kay on 2023/02/03.
//

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var inputArr = readLine()!.split(separator: " ").map { Int(String($0))! }
inputArr.insert(0, at: 0)

var psum = [Int](repeating: 0, count: N + 1)

for i in 1...N {
    psum[i] = psum[i-1] + inputArr[i]
}

var max = -987654321
for i in K...N {
    let challengeNumber = psum[i] - psum[i-K]
    max = challengeNumber > max ? challengeNumber : max
}
print(max)


