//
//  main.swift
//  AlgorithmLectureDFS2
//
//  Created by Kay on 2023/01/04.
//

/*
 24480
 알고리즘 수업 - 깊이 우선 탐색 2
 */

// 양방향
// 인접 정점 내림차순
// 방문할 수 없는 경우 0

import Foundation

let userInput = readLine()!.split(separator: " ").map { Int($0)! }
let N = userInput[0]
let M = userInput[1]
let R = userInput[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Int](repeating: 0, count: N + 1)

var counter = 1

for _ in 0..<M {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    let u = edge[0]
    let v = edge[1]
    adjMatrix[u].append(v)
    adjMatrix[v].append(u)
}

func dfs(_ node: Int) {
    visited[node] = counter
    adjMatrix[node] = adjMatrix[node].sorted(by: >)
    for i in 0..<adjMatrix[node].count {
        if visited[adjMatrix[node][i]] != 0 { continue }
        counter += 1
        dfs(adjMatrix[node][i])
    }
}

dfs(R)

visited.enumerated().forEach {
    if $0.offset != 0 {
        print($0.element)
    }
}
