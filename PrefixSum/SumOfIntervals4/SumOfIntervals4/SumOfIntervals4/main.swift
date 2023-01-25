//
//  main.swift
//  SumOfIntervals4
//
//  Created by Kay on 2023/01/25.
//

/*
 11659
 구간 합 구하기 4
 */

/*
 N과 M은 각각 10만.
 2중 for문 X
 누적합
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var arr = readLine()!.split(separator: " ").map{ Int($0)! }
arr.insert(0, at: 0)


var psum = [Int](repeating: 0, count: N + 1)

for i in 1...N {
    psum[i] = psum[i-1] + arr[i]
}


func getResult(_ from: Int, _ to: Int) -> Int {
    return psum[to] - psum[from-1]
}

for i in 0..<M {
    let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = fromTo[0]
    let to = fromTo[1]
    print(getResult(from, to))
}
