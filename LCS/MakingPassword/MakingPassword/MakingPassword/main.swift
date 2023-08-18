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

var aStr = readLine()!.map { String($0) }
var bStr = readLine()!.map { String($0) }
aStr.insert("-", at: 0)
bStr.insert("-", at: 0)
let aStrCount = aStr.count // 11 + 1
let bStrCount = bStr.count // 12 + 1

var LCS = [[Int]](repeating: [Int](repeating: 0, count: bStrCount), count: aStrCount)

for i in 0..<aStrCount {
    for j in 0..<bStrCount {
        if i == 0 || j == 0 {  // 마진 설정
            LCS[i][j] = 0
        } else if aStr[i] == bStr[j] {
            LCS[i][j] = LCS[i - 1][j - 1] + 1
        } else {
            LCS[i][j] = max(LCS[i - 1][j], LCS[i][j - 1])
        }
    }
}

var i = aStrCount - 1
var j = bStrCount - 1
var result = ""
while LCS[i][j] != 0 {
    if LCS[i][j] == LCS[i-1][j] {
        i = i - 1
    } else if LCS[i][j] == LCS[i][j-1] {
        j = j - 1
    } else {
        result += aStr[i]
        i -= 1
        j -= 1
    }
}
result = String(result.reversed())
print(result)
