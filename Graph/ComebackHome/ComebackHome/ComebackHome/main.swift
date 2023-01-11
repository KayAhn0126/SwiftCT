//
//  main.swift
//  ComebackHome
//
//  Created by Kay on 2023/01/11.
//

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let RCK = readLine()!.split(separator: " ").map { Int(String($0))! }
let R = RCK[0]
let C = RCK[1]
let K = RCK[2]

var map = [[Character]](repeating: [Character](), count: R)
var visited = [[Bool]](repeating: [Bool](repeating: false, count: C), count: R)


for i in 0..<R {
    map[i].append(contentsOf: readLine()!.map { Character(String($0)) })
}


var dfsCount = 0
var result = 0

func clearVisited() {
    for i in 0..<R {
        for j in 0..<C {
            visited[i][j] = false
        }
    }
}

func dfs(_ y: Int,  _ x: Int) {
    dfsCount += 1
    visited[y][x] = true
//    if y == R-1 && x == C-1 && K == dfsCount {
//        result += 1
//        dfsCount = 0
//    }
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= R || nx >= C || map[ny][nx] == "T" || visited[ny][nx] == true { continue }
        dfs(ny,nx)
        visited[ny][nx] = false
    }
}


clearVisited()
dfs(0,0)
print(result)
