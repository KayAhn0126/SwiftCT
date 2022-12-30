//
//  main.swift
//  DFS
//
//  Created by Kay on 2022/12/30.
//

import Foundation

var n = 3

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var adjList = [[Int]]() // 인접 행렬 구현
var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n) // 방문 노드 체크 배열 구현

func dfs(_ y: Int, _ x: Int) {
    visited[y][x] = true
    print("\(y), \(x), is \(adjList[y][x])")
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= n || nx >= n { continue } // 언더플로우, 오버플로우 체크
        if adjList[ny][nx] == 0 { continue }
        if visited[ny][nx] { continue }
        dfs(ny,nx)
    }
}

for _ in 0..<n {
    adjList.append(Array(readLine()!.split(separator: " ") .map { Int(String($0))! }))
    /*
     1 0 0
     1 0 1
     1 1 1
     */
}

dfs(0,0)

/*
 0, 0, is 1
 1, 0, is 1
 2, 0, is 1
 2, 1, is 1
 2, 2, is 1
 1, 2, is 1
 */
