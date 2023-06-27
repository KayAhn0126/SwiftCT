//
//  main.swift
//  PickingNumber
//
//  Created by Kay on 2023/06/27.
//

/*
 2230
 수 고르기
 */

// 조심 할 점: 두 수를 고를때 같은 수를 고를 수 있다.

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var arr = [Int]()
for _ in 0..<N {
    arr.append(Int(readLine()!)!)
}
arr.sort()

var start = 0
var end = 0
var result = Int.max

while end < N {
    let temp = arr[end] - arr[start]
    if temp == M {
        result = M
        break
    }
    if temp > M { // 차이가 m보다 크다
        result = min(temp, result)
        start += 1
    } else {
        end += 1
    }
}
print(result)
