//
//  main.swift
//  PadovanSequence
//
//  Created by Kay on 2023/03/02.
//

/*
 9461
 파도반 수열
 */

// 첫 10개의 숫자 -> 1,1,1,2,2,3,4,5,7,9
// 패턴 -> 현재 숫자를 구하려면 전전 숫자와 전전전 숫자를 더하면 된다.
// DP[i] = DP[i-2] + DP[i-3]

import Foundation

let testCase = Int(readLine()!)!

var DP = [Int](repeating: 0, count: 101)


DP[1] = 1
DP[2] = 1
DP[3] = 1
DP[4] = 2
DP[5] = 2
DP[6] = 3
DP[7] = 4
DP[8] = 5
DP[9] = 7
DP[10] = 9

for i in 11...100 {
    DP[i] = DP[i-2] + DP[i-3]
}

for i in 0..<testCase {
    let testNum = Int(readLine()!)!
    print(DP[testNum])
}
