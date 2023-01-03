//
//  main.swift
//  AlgorithmLectureDFS1
//
//  Created by Kay on 2023/01/03.
//

/*
 24479
 알고리즘 수업 - 깊이 우선 탐색 1
 */

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let userInput = readLine()!.split(separator: " ").map { Int($0)! }

let N = userInput[0]
let M = userInput[1]
let R = userInput[2]

var count = 1

var arrMatrix = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Int](repeating: 0, count: N + 1)

for _ in 0..<M {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let u = input[0]
    let v = input[1]
    arrMatrix[u].append(v)
    arrMatrix[v].append(u)
}

func dfs(_ node: Int) {
    visited[node] = count
    arrMatrix[node] = arrMatrix[node].sorted()
    for i in 0..<arrMatrix[node].count {
        if visited[arrMatrix[node][i]] != 0 { continue }
        count += 1
        dfs(arrMatrix[node][i])
    }
}

dfs(R)

visited.enumerated().forEach {
    if $0.offset != 0 {
        print($0.element)
    }
}
