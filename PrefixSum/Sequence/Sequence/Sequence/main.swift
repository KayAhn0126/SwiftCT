//
//  main.swift
//  Sequence
//
//  Created by Kay on 2022/12/26.
//

/*
 2559
 수열
 */

// 1st week fast-campus
import Foundation

let inputArr = readLine()!.split(separator: " ").map { Int($0)! }
let N = inputArr[0]
let K = inputArr[1]

var temperatureArr = readLine()!.split(separator: " ").map { Int($0)!}
temperatureArr.insert(0, at: 0)

var psum = [Int](repeating: 0, count: N + 1)
var max = -10000000

for i in 1...N {
    psum[i] = psum[i-1] + temperatureArr[i]
}

for i in K...N {
    let challengeNumber = psum[i] - psum[i-K]
    max = challengeNumber > max ? challengeNumber : max
}

print(max)
