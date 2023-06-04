//
//  main.swift
//  Budget
//
//  Created by Kay on 2023/06/04.
//

/*
 2512
 예산
 */

import Foundation

func check(_ arr: inout [Int], _ num: Int) -> Int {
    var result = 0
    for i in arr {
        if i >= num {
            result += num
        } else {
            result += i
        }
    }
    return result
}

let N = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
let target = Int(readLine()!)!

var start = 0
var end = arr.max()!
var mid = 0
var max = 0
while start <= end {
    mid = (start + end) / 2
    let testNum = check(&arr, mid)
    if target >= testNum {
        max = mid >= max ? mid : max
        start = mid + 1
    } else {
        end = mid - 1
    }
}
print(max)
