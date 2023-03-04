//
//  main.swift
//  RGBStreet2
//
//  Created by Kay on 2023/03/04.
//

/*
 17404
 RGB거리 2
 */

import Foundation

let streetCount = Int(readLine()!)!
let max = 987654321

var streetsArr = [[Int]](repeating: [Int](), count: streetCount)
for i in 0..<streetCount {
    streetsArr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var result = 987654321
for i in 0..<3 {
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 3), count: streetCount)
    for j in 0..<3 {
        if i == j {
            dp[0][j] = streetsArr[0][j]
            continue
        }
        dp[0][j] = max
    }
    
    for k in 1..<streetCount {
        dp[k][0] = min(dp[k-1][1], dp[k-1][2]) + streetsArr[k][0]
        dp[k][1] = min(dp[k-1][0], dp[k-1][2]) + streetsArr[k][1]
        dp[k][2] = min(dp[k-1][0], dp[k-1][1]) + streetsArr[k][2]
    }
    
    for l in 0..<3 {
        if i == l {
            continue
        }
        result = result > dp[streetCount-1][l] ? dp[streetCount-1][l] : result
    }
}
print(result)
