//
//  main.swift
//  MakingPassword
//
//  Created by Kay on 2023/08/17.
//

/*
 17218
 비밀번호 만들기
 */

// LCS(Longest Common Subsequence)
import Foundation

let aStr = readLine()!.map { String($0) }
let bStr = readLine()!.map { String($0) }

let aStrCount = aStr.count // 11
let bStrCount = bStr.count // 12

var result = ""
var LCS = [[Int]](repeating: [Int](repeating: 0, count: bStr.count), count: aStrCount)

for i in 0..<aStrCount {
    for j in 0..<bStrCount {
        if i == 0 || j == 0{  // 마진 설정
            LCS[i][j] = 0
        } else if aStr[i] == bStr[j] {
            LCS[i][j] = LCS[i - 1][j - 1] + 1
        } else {
            LCS[i][j] = max(LCS[i - 1][j], LCS[i][j - 1])
        }
    }
}


LCS.enumerated().forEach {
    print($0.element)
}

