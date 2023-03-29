//
//  main.swift
//  Pascal'sTriangle
//
//  Created by Kay on 2023/03/29.
//

import Foundation

let NK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NK[0]
let K = NK[1]

//30줄까지 총 30 * 30
var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: 31), count: 31)
adjMatrix[1][1] = 1
adjMatrix[2][1] = 1
adjMatrix[2][2] = 1
for i in 3...30 {
    adjMatrix[i][1] = 1
    adjMatrix[i][i] = 1
}

for i in 3...30 {
    for j in 2..<i {
        adjMatrix[i][j] = adjMatrix[i-1][j-1] + adjMatrix[i-1][j]
    }
}
print(adjMatrix[N][K])
