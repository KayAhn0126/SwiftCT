//
//  main.swift
//  NumberingOnHouse
//
//  Created by Kay on 2023/02/23.
//

/*
 2667
 단지번호붙이기
 */

import Foundation

let N = Int(readLine()!)!
var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
var result: [Int] = []
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]
var tempResult = 0
var totalHouse = 0

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

func dfs(_ y: Int, _ x: Int) {
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
        if visited[ny][nx] != 0 || adjMatrix[ny][nx] == 0 { continue }
        visited[ny][nx] = 1
        tempResult += 1
        dfs(ny,nx)
    }
}

for i in 0..<N {
    for j in 0..<N {
        if visited[i][j] == 0 && adjMatrix[i][j] == 1 {
            totalHouse += 1
            tempResult = 1
            visited[i][j] = 1
            dfs(i,j)
            result.append(tempResult)
        }
    }
}

print(totalHouse)
result.sorted().enumerated().forEach {
    print($0.element)
}
