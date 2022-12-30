//
//  main.swift
//  DFSWithConnectedComponent
//
//  Created by Kay on 2022/12/30.
//

import Foundation

// MARK: - 종화는 방구쟁이야! 이러다 다 죽어~~ 문제 풀이
let nm = readLine()!.split(separator: " ").map { Int($0)! }

let n = nm[0]
let m = nm[1]

var adjList = [[Int]]()
var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)

for _ in 0..<5 {
    adjList.append(readLine()!.split(separator: " ").map { Int($0)! })
}

let dy = [-1, 0, 1, 0]
let dx = [0, 1, 0, -1]

var counter = 0

func dfs(_ y: Int, _ x: Int) {
    visited[y][x] = true
    for direction in 0..<4 {
        let ny = y + dy[direction]
        let nx = x + dx[direction]
        if ny < 0 || nx < 0 || ny >= n || nx >= m { continue }
        if adjList[ny][nx] == 0 { continue }
        if visited[ny][nx] == true { continue }
        dfs(ny, nx)
    }
}

for i in 0..<n {
    for j in 0..<m {
        if(adjList[i][j] == 1 && visited[i][j] == false) {
            dfs(i,j)
            counter += 1
        }
    }
}
print(counter)

/*
 input
 5 5
 1 0 1 0 1
 1 1 0 0 1
 0 0 0 1 1
 0 0 0 1 1
 0 1 0 0 0
 
 output
 4
 
 */
