//
//  main.swift
//  FibonacciNumber
//
//  Created by Kay on 2023/02/28.
//

/*
 24416
 피보나치 수 1
 */

/*
 입력 : 첫째 줄에 n(5 ≤ n ≤ 40)이 주어진다.
 출력 : 코드1 코드2 실행 횟수를 한 줄에 출력한다.
 */

import Foundation
var userInput = Int(readLine()!)!

// dp
var executionCountOfDP = 0
var dp = [Int](repeating: 0, count: 41)

dp[1] = 1
dp[2] = 1

for i in 3...userInput {
    dp[i] = dp[i-2] + dp[i-1]
    executionCountOfDP += 1
}
print(dp[userInput], executionCountOfDP)
