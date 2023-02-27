//
//  main.swift
//  Quit
//
//  Created by Kay on 2023/02/27.
//

/*
 14501
 퇴사
 */

import Foundation

let N = Int(readLine()!)!

var arrT = [Int]()
var arrP = [Int]()
var dp = [Int](repeating: -1, count: N)

for _ in 0..<N {
    let timePay = readLine()!.split(separator: " ").map { Int(String($0))! }
    let time = timePay[0]
    let pay = timePay[1]
    arrT.append(time)
    arrP.append(pay)
}

func solve(_ day: Int) -> Int {
    if day > N { return -987654321 }
    if day == N { return 0 }
    if dp[day] != -1 { return dp[day] }
    
    dp[day] = max(solve(day + 1), solve(day + arrT[day]) + arrP[day])
    return dp[day]
}

print(solve(0))

