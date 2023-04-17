//
//  main.swift
//  AwayFromFood
//
//  Created by Kay on 2023/04/17.
//

/*
 1743
 음식물 피하기
 */

import Foundation

let NMK = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMK[0]
let M = NMK[1]
let K = NMK[2]

var adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for i in 0..<K {
    let RC = readLine()!.split(separator: " ").map { Int(String($0))! }
    let R = RC[0] - 1
    let C = RC[1] - 1
    adjMatrix[R][C] = 1
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var result = 0
func dfs(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] != 0 { continue }
        if adjMatrix[ny][nx] != 1 { continue }
        result += 1
        visited[ny][nx] = 1
        dfs(ny,nx)
    }
}

var max = 0
for i in 0..<N {
    for j in 0..<M {
        if visited[i][j] == 1 { continue }
        if adjMatrix[i][j] == 0 { continue }
        visited[i][j] = 1
        result += 1
        dfs(i,j)
        max = result > max ? result : max
        result = 0
    }
}
print(max)
