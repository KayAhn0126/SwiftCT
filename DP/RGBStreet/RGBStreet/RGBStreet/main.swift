//
//  main.swift
//  RGBStreet
//
//  Created by Kay on 2023/03/03.
//

/*
 1149
 RGB거리
 */

import Foundation

let streets = Int(readLine()!)!
var streetsArr = [[Int]](repeating: [Int](), count: streets)

for i in 0..<streets {
    streetsArr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: streets)
var prevStreet = streetsArr[0]
dp[0][0] = prevStreet[0]
dp[0][1] = prevStreet[1]
dp[0][2] = prevStreet[2]

for i in 1..<streets {
    // r
    dp[i][0] = min(dp[i-1][1], dp[i-1][2]) + streetsArr[i][0]
    // g
    dp[i][1] = min(dp[i-1][0], dp[i-1][2]) + streetsArr[i][1]
    // b
    dp[i][2] = min(dp[i-1][0], dp[i-1][1]) + streetsArr[i][2]
}
print(min(dp[streets-1][0], dp[streets-1][1], dp[streets-1][2]))

