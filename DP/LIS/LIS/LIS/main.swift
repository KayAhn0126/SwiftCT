//
//  main.swift
//  LIS
//
//  Created by Kay on 2023/03/29.
//

/*
 11053
 가장 긴 증가하는 부분 수열
 */

import Foundation

let N = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

var dp = [Int](repeating: 0, count: N)
var result = 0
for i in 0..<arr.count {
    var latest = 0
    for j in 0...i {
        if arr[j] < arr[i] && latest < dp[j] {
            latest = dp[j]
        }
    }
    dp[i] = latest + 1
    result = dp[i] > result ? dp[i] : result
}
print(result)
