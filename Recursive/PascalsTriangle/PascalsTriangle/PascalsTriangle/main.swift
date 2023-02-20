//
//  main.swift
//  PascalsTriangle
//
//  Created by Kay on 2023/02/20.
//

/*
 16395
 파스칼의 삼각형
 */

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

if 1 <= N && 1 <= K && K <= N && N <= 30 && K <= 30 {
    var dp = [[Int]](repeating: [Int](repeating: 0, count: 31), count: 31)
    
    dp[1][1] = 1
    if N == 1 && K == 1 {
        print(1)
    } else {
        for i in 2...N {
            for j in 1...i {
                dp[i][j] = dp[i-1][j-1] + dp[i-1][j]
            }
        }
        print(dp[N][K])
    }
}
