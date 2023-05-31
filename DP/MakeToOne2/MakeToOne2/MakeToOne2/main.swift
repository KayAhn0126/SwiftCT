//
//  main.swift
//  MakeToOne2
//
//  Created by Kay on 2023/05/26.
//

/*
 12852
 1로 만들기 2
 */

import Foundation

var num = Int(readLine()!)!
var dp = [Int](repeating: 0, count: num + 1)
var prev = [Int](repeating: 0, count: num + 1)

if num == 1 {
    print(0)
    print(1)
} else if num == 2 || num == 3 {
    print(1)
    print(num, 1)
} else {
    dp[1] = 0
    prev[1] = 0

    for i in 2...num {
        dp[i] = dp[i-1] + 1
        prev[i] = i-1
        if i % 2 == 0 && dp[i] > dp[i/2] + 1 {
            dp[i] = dp[i/2] + 1
            prev[i] = i/2
        }
        if i % 3 == 0 && dp[i] > dp[i/3] + 1 {
            dp[i] = dp[i/3] + 1
            prev[i] = i / 3
        }
    }
    print(dp[num])
    while num != 0 {
        print(num, terminator: " ")
        num = prev[num]
    }
    print("")
}
