//
//  main.swift
//  SumOfIntervals4
//
//  Created by Kay on 2023/02/07.
//

/*
 11659
 구간 합 구하기 4
 */

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

var numList = readLine()!.split(separator: " ").map { Int(String($0))! }
numList.insert(0, at: 0)
var psum = [Int](repeating: 0, count: N + 1)


for i in 1...N {
    psum[i] = psum[i-1] + numList[i]
}

func calculate(_ from: Int, _ to: Int) -> Int {
    return psum[to] - psum[from-1]
}

for i in 0..<K {
    let test = readLine()!.split(separator: " ").map { Int(String($0))! }
    print(calculate(test[0], test[1]))
}

// 9분 25초
