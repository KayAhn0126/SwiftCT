//
//  main.swift
//  SafeArea
//
//  Created by Kay on 2023/02/13.
//

/*
 2468
 안전영역
 */

/*
 connected component + for(1~100)
 N은 2이상 100 이하 정수
 각 칸에 들어올 수 있는 수는 1이상 100 이하 정수
 */

import Foundation

let N = Int(readLine()!)!

var matrix = [[Int]](repeating: [Int](), count: N)

var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)

for i in 0..<N {
    matrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

func clearVisited() {
    for row in 0..<N {
        for col in 0..<N {
            visited[row][col] = 0
        }
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func dfs(_ y: Int, _ x: Int, _ tryNumber: Int) {
    visited[y][x] = 1
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] == 1 || matrix[ny][nx] <= tryNumber { continue }
        dfs(ny, nx, tryNumber)
    }
}


var max = -987654321
for tryNumber in 1..<101{
    var currentConnectedComponentCount = 0
    clearVisited()
    for i in 0..<N {
        for j in 0..<N {
            if visited[i][j] == 1 || matrix[i][j] <= tryNumber { continue }
            dfs(i,j,tryNumber)
            currentConnectedComponentCount += 1
        }
    }
    max = max > currentConnectedComponentCount ? max : currentConnectedComponentCount
}

if max == 0 {
    print(1)
} else {
    print(max)
}

//20분
