//
//  main.swift
//  ExcitingFunctionExecution
//
//  Created by Kay on 2023/02/28.
//

/*
 9184
 신나는 함수 실행
 */

import Foundation

var dp = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 51), count: 51), count: 51)

func solve(_ a: Int, _ b: Int, _ c: Int) -> Int {
    if a <= 0 || b <= 0 || c <= 0{
        return 1
    } else if dp[a][b][c] != 0 {
        return dp[a][b][c]
    } else if a > 20 || b > 20 || c > 20 {
        dp[a][b][c] = solve(20,20,20)
        return dp[a][b][c]
    } else if a < b && b < c {
        dp[a][b][c] = solve(a, b, c-1) + solve(a, b-1, c-1) - solve(a, b-1, c)
        return dp[a][b][c]
    } else {
        dp[a][b][c] = solve(a-1, b, c) + solve(a-1, b-1, c) + solve(a-1, b, c-1) - solve(a-1, b-1, c-1)
        return dp[a][b][c]
    }
}

while let line = readLine() {
    let numbers = line.split(separator: " ").map { Int(String($0))! }
    let a = numbers[0]
    let b = numbers[1]
    let c = numbers[2]
    if a == -1 && b == -1 && c == -1 {
        break
    }
    print("w(\(a), \(b), \(c)) = \(solve(a,b,c))")
}
