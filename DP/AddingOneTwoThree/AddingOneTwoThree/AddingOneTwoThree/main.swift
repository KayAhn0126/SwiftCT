//
//  main.swift
//  AddingOneTwoThree
//
//  Created by Kay on 2023/05/17.
//

/*
 9095
 1,2,3 더하기
 */

import Foundation

let x = Int(readLine()!)!
var dp = [Int](repeating: 0, count: 12)
dp[1] = 1
dp[2] = 2
dp[3] = 4
dp[4] = 7
for i in 5...11 {
    dp[i] = dp[i-1] + dp[i-2] + dp[i-3]
}

for i in 0..<x {
    let temp = Int(readLine()!)!
    print(dp[temp])
}
