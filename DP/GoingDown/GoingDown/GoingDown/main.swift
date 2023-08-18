//
//  main.swift
//  GoingDown
//
//  Created by Kay on 2023/08/18.
//

/*
 2096
 내려가기
 */

/*
 지문 해석:
    N이 10만이다.
    DP로 풀자.
 */

import Foundation

let N = Int(readLine()!)!
var arr = [[Int]]()
for _ in 0..<N {
    arr.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

var maxDP = [[Int]](repeating: [Int](repeating: 0, count: 3), count: N)
var minDP = [[Int]](repeating: [Int](repeating: 0, count: 3), count: N)

for i in 0..<3 {
    maxDP[0][i] = arr[0][i]
    minDP[0][i] = arr[0][i]
}

// maxDP 점화식
for i in 1..<N {
    for j in 0..<3 {
        if j == 0 {
            maxDP[i][j] = max(maxDP[i-1][j] + arr[i][j], maxDP[i-1][j+1] + arr[i][j])
        } else if j == 1 {
            maxDP[i][j] = max(maxDP[i-1][j-1] + arr[i][j], maxDP[i-1][j] + arr[i][j], maxDP[i-1][j+1] + arr[i][j])
        } else {
            maxDP[i][j] = max(maxDP[i-1][j-1] + arr[i][j], maxDP[i-1][j] + arr[i][j])
        }
    }
}

// minDP 점화식
for i in 1..<N {
    for j in 0..<3 {
        if j == 0 {
            minDP[i][j] = min(minDP[i-1][j] + arr[i][j], minDP[i-1][j+1] + arr[i][j])
        } else if j == 1 {
            minDP[i][j] = min(minDP[i-1][j-1] + arr[i][j], minDP[i-1][j] + arr[i][j], minDP[i-1][j+1] + arr[i][j])
        } else {
            minDP[i][j] = min(minDP[i-1][j-1] + arr[i][j], minDP[i-1][j] + arr[i][j])
        }
    }
}
var resultMax = maxDP[N-1].max()!
var resultMin = minDP[N-1].min()!
print(resultMax, resultMin)
