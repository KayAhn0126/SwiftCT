//
//  main.swift
//  SavePrincess
//
//  Created by Kay on 2023/08/24.
//

/*
 17836
 공주님을 구해라!
 */

/*
 N, M <= 100
 T <= 10000
 O(NM)
 */

import Foundation

let NMT = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMT[0]
let M = NMT[1]
let T = NMT[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: M), count: N), count: 2)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

var bfsQueue = [(Int, Int, Int)](), idx = 0
bfsQueue.append((0,0,0))
visited[0][0][0] = 1

var result = 0

while idx < bfsQueue.count {
    let current = bfsQueue[idx]; idx += 1
    let curS = current.0 // 검을 가지고 있는지 상태
    let curY = current.1
    let curX = current.2
    if curY == N-1 && curX == M-1 {
        result = visited[curS][N-1][M-1] - 1
        break
    }
    for i in 0..<4 {
        let ny = curY + dy[i]
        let nx = curX + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if visited[curS][ny][nx] != 0 { continue }
        if curS == 0 && adjMatrix[ny][nx] == 1 { continue }
        if curS == 0 { // 검을 아직 못찼았다면
            if adjMatrix[ny][nx] == 2 { // 다음 갈곳이 검이라면
                visited[1][ny][nx] = visited[0][curY][curX] + 1
                bfsQueue.append((1,ny,nx))
                continue
            }
        }
        // 아직 검을 못찾았고 다음 갈곳이 검이 있는곳도 아니거나,
        // 검을 찾은 상태라면, 기본 BFS 진행
        visited[curS][ny][nx] = visited[curS][curY][curX] + 1
        bfsQueue.append((curS,ny,nx))
    }
}
if result != 0 && result <= T {
    print(result)
} else {
    print("Fail")
}
