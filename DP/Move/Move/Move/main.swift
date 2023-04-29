//
//  main.swift
//  Move
//
//  Created by Kay on 2023/04/29.
//

/*
 11048
 이동하기
 */

// 현재 기점으로 좌, 상, 좌상 중 가장 큰 숫자와 현재 위치의 숫자를 더해서 DP의 현재 위치에 대입해주면 된다.

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var dp = [[Int]](repeating: [Int](repeating: 0, count: M+1), count: N+1)

for i in 1..<N+1 {
    var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    for j in 1..<M+1{
        dp[i][j] = arr[j-1]
    }
}

for i in 1..<N+1 {
    for j in 1..<M+1 {
        dp[i][j] = max(dp[i-1][j-1], dp[i-1][j], dp[i][j-1]) + dp[i][j]
    }
}
print(dp[N][M])
