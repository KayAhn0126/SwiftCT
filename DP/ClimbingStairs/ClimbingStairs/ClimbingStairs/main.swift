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
    /**
     - 첫 번째 계단까지는 (첫 번째 계단)이 최댓값이다.
     - 두 번째 계단까지는 (첫 번째 계단 + 두 번째 계단) 혹은 (두 번째 계단) 중 하나가 최댓값이다.
     - 세 번째 계단까지는 (첫 번째 계단 + 세 번째 계단) 혹은 (두 번째 계단 + 세 번째 단계) 중 하나가 최댓값이다.
     */
    
    for i in 3...userInput {
        dp[i] = max(dp[i-2] + arr[i], dp[i-3] + arr[i-1] + arr[i])
    }
    /**
     마지막 계단을 무조건 밟고, 연속된 세 개의 계단을 밟으면 안된다면 아래 두 가지 케이스가 존재한다.
     ① (마지막 계단 + 전전 계단)을 밟는 경우
     ② (마지막 계단 + 전 계단 + 전전전 계단)을 밟는 경우
     - 이 덕분에 세 개 계단을 연속으로 밟는 경우가 없어진다.
     */
    print(dp[userInput])
}
