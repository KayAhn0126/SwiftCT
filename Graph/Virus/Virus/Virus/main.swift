//
//  main.swift
//  Virus
//
//  Created by Kay on 2023/02/23.
//

/*
 2606
 바이러스
 */

// 인접 리스트
import Foundation

let N = Int(readLine()!)!
let count = Int(readLine()!)!

var adjList = [[Int]](repeating: [Int](), count: N + 1)
var visited = [Int](repeating: 0, count: N + 1)
var result = 0
for _ in 0..<count {
    let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = fromTo[0]
    let to = fromTo[1]
    adjList[from].append(to)
    adjList[to].append(from)
}

func dfs(_ node: Int) {
    visited[node] = 1
    for element in adjList[node] {
        if visited[element] == 1 { continue }
        result += 1
        dfs(element)
    }
}
dfs(1)
print(result)
