//
//  main.swift
//  MakingAMaze
//
//  Created by Kay on 2023/07/27.
//

/*
 2665
 미로 만들기
 */

/*
 문제 파악:
    결국엔 모든 곳을 다 가야한다. 다만 현재 도착한 위치는 블랙을 몇개 깨고 왔는지 정보를 가지고 있어야하고 visited가 그 역할을 대신한다.
 */

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let x = Int(readLine()!)!
var adjMatrix = [[Int]](repeating: [Int](), count: x)
for i in 0..<x {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

var visited = [[Int]](repeating: [Int](repeating: Int.max, count: x), count: x)

var bfsQueue: [(Int,Int)] = [], idx = 0
bfsQueue.append((0,0))
visited[0][0] = 0

func bfs() -> Int {
    while idx < bfsQueue.count {
        let current = bfsQueue[idx]; idx += 1

        let currentY = current.0
        let currentX = current.1

        // 현재 위치에서 4방향 탐색
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= x || nx >= x { continue }
            if adjMatrix[ny][nx] == 1 {  // 흰색 방
                if visited[ny][nx] > visited[currentY][currentX] {
                    visited[ny][nx] = visited[currentY][currentX]
                    bfsQueue.append((ny,nx))
                }
            } else {                    // 검은색 방
                if visited[ny][nx] > visited[currentY][currentX] + 1 {
                    visited[ny][nx] = visited[currentY][currentX] + 1
                    bfsQueue.append((ny,nx))
                }
            }
        }
    }
    return visited[x-1][x-1]
}
print(bfs())
