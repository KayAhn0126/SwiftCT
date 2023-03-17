//
//  main.swift
//  MakeToOne
//
//  Created by Kay on 2023/03/17.
//

/*
 1463
 1로 만들기 다시풀기
 */

import Foundation

var number = Int(readLine()!)!

var dp = [Int](repeating: 0, count: 1000001)
dp[1] = 0
dp[2] = 1
dp[3] = 1

for i in 4...1000000 {
    dp[i] = dp[i-1] + 1
    if i % 2 == 0 {
        dp[i] = min(dp[i / 2] + 1, dp[i])
    }
    if i % 3 == 0 {
        dp[i] = min(dp[i / 3] + 1, dp[i])
    }
}
print(dp[number])

