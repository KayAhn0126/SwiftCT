//
//  main.swift
//  Sticker
//
//  Created by Kay on 2023/08/19.
//

/*
 9465
 스티커
 */

/*
 문제 접근:
 하나의 컬럼에서 스티커를 선택했을때와, 해당 컬럼에서 스티커를 선택하지 않고 다음 컬럼에서 스티커를 선택했을때를 비교하자.
 */
import Foundation
var tc = Int(readLine()!)!
func solve(_ y: Int, _ x: Int) {
    
}

while tc != 0 {
    let n = Int(readLine()!)!
    var arr = [[Int]](repeating: [Int](), count: 2)
    for i in 0..<2 {
        arr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
    }
    var dp = [[Int]](repeating: [Int](repeating: 0, count: n), count: 2)
    dp[0][0] = arr[0][0]
    dp[1][0] = arr[1][0]
    if n > 1 {
        dp[0][1] = dp[1][0] + arr[0][1]
        dp[1][1] = dp[0][0] + arr[1][1]
        for i in 2..<n {
            dp[0][i] = max(dp[1][i-1], dp[1][i-2]) + arr[0][i]
            dp[1][i] = max(dp[0][i-1], dp[0][i-2]) + arr[1][i]
        }
    }
    print(max(dp[0][n-1], dp[1][n-1]))
    tc -= 1
}



