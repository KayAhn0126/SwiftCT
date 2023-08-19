//
//  main.swift
//  RiceCakeTiger
//
//  Created by Kay on 2023/08/19.
//

/*
 2502
 떡 먹는 호랑이
 */

import Foundation

let DK = readLine()!.split(separator: " ").map { Int(String($0))! }
let D = DK[0]
let K = DK[1]

for i in stride(from: K-1, through: 0, by: -1) {
    var dp = [Int](repeating: 0, count: 31)
    dp[D] = K // 41
    dp[D-1] = i // 25
    var flag = true
    for j in stride(from: D-2, through: 1, by: -1) {
        dp[j] = dp[j+2] - dp[j+1]
        if dp[j] > dp[j+1] {
            flag = false
            break
        }
    }
    if flag {
        print(dp[1])
        print(dp[2])
        break
    }
}

