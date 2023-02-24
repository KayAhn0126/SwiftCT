//
//  main.swift
//  GoThroughTheWall
//
//  Created by Kay on 2023/02/24.
//

/*
 2206
 벽 부수고 이동하기
 */

/*
 1의 위치 구하기
 N,M까지 도착한다면 (백트래킹 + BFS + 최단거리)
 N,M까지 도착하지 못하면 -1
 BFS(0,0)
 
 시간 복잡도 1000 * 1000 * BFS
 O(1,000,000 * BFS)
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

var oneLocation: [(Int, Int)] = []
for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 1 {
            oneLocation.append((i,j))
        }
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var result = 987654321
for i in oneLocation {
    var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    var bfsQueue: [(Int,Int)] = [], idx = 0
    adjMatrix[i.0][i.1] = 0
    
    visited[0][0] = 1
    bfsQueue.append((0,0))
    
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        let currentY = currentLocation.0
        let currentX = currentLocation.1
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx] > 0 || adjMatrix[ny][nx] == 1 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            bfsQueue.append((ny,nx))
        }
    }
    adjMatrix[i.0][i.1] = 1
    let roundResult = visited[N-1][M-1]
    if roundResult == 0 { // 가는 방법이 없다면
        continue
    } else { // 가는 방법이 있다면
        result = result > roundResult ? roundResult : result
    }
    
}
if result == 987654321 {
    print(-1)
} else {
    print(result)
}
