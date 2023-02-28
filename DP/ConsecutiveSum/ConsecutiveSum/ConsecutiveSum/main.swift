//
//  main.swift
//  ConsecutiveSum
//
//  Created by Kay on 2023/02/28.
//

/*
 1912
 연속합
 */

import Foundation

let numCount = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var dp = [Int](repeating: 0, count: numCount)

dp[0] = arr[0]

var biggestNumber = dp[0]
for i in 1..<numCount {
    dp[i] = max(dp[i-1] + arr[i], arr[i])
    biggestNumber = dp[i] > biggestNumber ? dp[i] : biggestNumber
}

print(biggestNumber)
