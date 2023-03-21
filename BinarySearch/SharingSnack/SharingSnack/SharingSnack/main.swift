//
//  main.swift
//  SharingSnack
//
//  Created by Kay on 2023/03/21.
//

/*
 16401
 과자 나눠주기
 */

import Foundation

let MN = readLine()!.split(separator: " ").map { Int(String($0))! }
let headCount = MN[0]
let snackCount = MN[1]

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

func checkNumber(_ number: Int) -> Bool {
    var result = 0
    for i in 0..<arr.count {
        result += (arr[i] / number)
    }
    if result >= headCount {
        return true
    }
    return false
}

var start = 1
var end = 1000000000
var mid = 0
var result = 0
while start <= end {
    mid = (start + end) / 2
    if checkNumber(mid) == true {
        start = mid + 1
        result = mid
    } else {
        end = mid - 1
    }
}
print(result)
