//
//  main.swift
//  EffectiveHacking
//
//  Created by Kay on 2023/01/10.
//

/*
 1325
 효율적인 해킹
 */
// 2nd week fast campus

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjList = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Bool](repeating: false, count: N + 1)

var biggestList = [Int](repeating: 0, count: N + 1)
var biggestNum = -100000

for i in 0..<M {
    let trustRelation = readLine()!.split(separator: " ").map { Int(String($0))! }
    let by = trustRelation[0]
    let trusted = trustRelation[1]
    adjList[trusted].append(by)
}

func dfs(_ node: Int) -> Int {
    var totalHacking = 1
    visited[node] = true
    let count = adjList[node].count
    for i in 0..<count {
        if visited[adjList[node][i]] == true { continue }
        totalHacking += dfs(adjList[node][i])
    }
    return totalHacking
}

func clearVisited() {
    for i in 1...N {
        visited[i] = false
    }
}

for i in 1...N {
    clearVisited()
    let number = dfs(i)
    biggestList[i] = number
    biggestNum = biggestList[i] > biggestNum ? biggestList[i] : biggestNum
}

for i in 1...N {
    if biggestNum == biggestList[i] {
        print(i, terminator: " ")
    }
}

