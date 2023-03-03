//
//  main.swift
//  ClimbingStairs
//
//  Created by Kay on 2023/03/02.
//

/*
 2579
 계단 오르기
 */

import Foundation

let userInput = Int(readLine()!)!

var arr = [Int](repeating: 0, count: userInput + 1)

for i in 1...userInput {
    arr[i] = Int(readLine()!)!
}

var dp = [Int](repeating: 0, count: userInput + 1)
// 각 자리에 왔을때 현재 자리까지 가장 큰 값을 넣어준다

/*
 0번 자리는 0이다
 1번 자리에 왔을때는 1번 밖에 없으니 1번자리의 값이 최대가 될것이고
 2번 자리에 왔을때는 1번 vs (1번 + 2번) 중 큰 값을 넣으면 된다.
 */

if userInput <= 1 {
    dp[0] = arr[0]
    dp[1] = arr[1]
    print(dp[userInput])
} else if userInput == 2 {
    dp[2] = arr[1] + arr[2]
    print(dp[userInput])
} else {
    dp[0] = arr[0]
    dp[1] = arr[1]
    dp[2] = arr[1] + arr[2]
    for i in 3...userInput {
        dp[i] = max(dp[i-2] + arr[i], dp[i-3] + arr[i-1] + arr[i])
    }
    print(dp[userInput])
}
