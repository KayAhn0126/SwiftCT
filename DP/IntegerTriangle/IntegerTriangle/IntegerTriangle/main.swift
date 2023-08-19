//
//  main.swift
//  IntegerTriangle
//
//  Created by Kay on 2023/08/19.
//

/*
 1932
 정수 삼각형
 */

import Foundation

let N = Int(readLine()!)!
var arr = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
    arr[i].append(contentsOf: temp)
}
var dp = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

dp[0][0] = arr[0][0]
if N > 1 {
    dp[1][0] = dp[0][0] + arr[1][0]
    dp[1][1] = dp[0][0] + arr[1][1]
    for i in 2..<N {
        for j in 0...i {
            if j == 0 {
                dp[i][j] = dp[i-1][j] + arr[i][j]
            } else if j == i {
                dp[i][j] = dp[i-1][j-1] + arr[i][j]
            } else {
                dp[i][j] = max(dp[i-1][j-1], dp[i-1][j]) + arr[i][j]
            }
        }
    }
}
print(dp[N-1].max()!)
