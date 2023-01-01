//
//  main.swift
//  SafeArea
//
//  Created by Kay on 2023/01/01.
//

/*
 2468
 안전영역
 */
// 2nd week fast-campus
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var result = 1

let N = Int(readLine()!)!

var adjMatrix = [[Int]]()
var visited: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)// BFS가 아니므로 Bool 타입으로 선언, 100번 정도 갈아끼워야한다.


for _ in 0..<N {
    adjMatrix.append(readLine()!.split(separator: " ").map { Int($0)! })
}

func dfs(_ y: Int, _ x: Int, _ depth: Int) {
    visited[y][x] = true
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] == true { continue }
        if depth >= adjMatrix[ny][nx] { continue }
        dfs(ny, nx, depth)
    }
}

for rainLevel in 1...100 {
    var counter = 0
    visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == true { continue }
            if rainLevel >= adjMatrix[i][j] { continue }
            dfs(i, j, rainLevel)
            counter += 1
        }
    }
    result = counter > result ? counter : result
}

print(result)

