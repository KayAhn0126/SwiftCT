//
//  main.swift
//  Cabbage
//
//  Created by Kay on 2022/12/31.
//

/*
#1012
 유기농 배추
 */

// 2nd week fast-campus

// DFS로 풀어보자
import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var M = 0
var N = 0
var K = 0

var testCase = Int(readLine()!)!

var adjMatrix: [[Int]] = [[]]
var visited: [[Int]] = [[]]

for _ in 0..<testCase {
    let info = readLine()!.split(separator: " ").map { Int($0)! }
    M = info[0] // 주의! 보통 세로 가로이지만 여기서는 가로 세로이다.
    N = info[1]
    K = info[2]
    print(search(N,M,K))
}


func search(_ N: Int, _ M: Int, _ K: Int) -> Int {
    var result = 0
    adjMatrix = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    
    for _ in 0..<K {
        let point = readLine()!.split(separator: " ").map { Int($0)! }
        let x = point[0]
        let y = point[1]
        adjMatrix[y][x] = 1
    }
    
    for i in 0..<N {
        for j in 0..<M {
            if visited[i][j] == 1 || adjMatrix[i][j] == 0 { continue }
            result += 1
            dfs(i, j)
        }
    }

    return result
}

func dfs(_ y: Int, _ x: Int) {
    visited[y][x] = 1
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[ny][nx] == 1 { continue }
        if adjMatrix[ny][nx] == 0 { continue }
        dfs(ny,nx)
    }
}
