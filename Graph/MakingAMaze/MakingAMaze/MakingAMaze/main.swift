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
 접근 방법:
    치킨 배달처럼 브루트포스 + 조합인가?
    벽 부수고 이동하기 같이 3차원 배열로 풀어야하나? ->
    가지 못하는곳이 있나? / 모든곳을 다 가야하나?
    
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

// (x-1, x-1)위치에 나중에 들어오는값이 더 적을 수도 있다. 그렇기 때문에 큐를 다 뺄때까지 돌려야한다.
// 검은방을 가장 적게 부수고 x-1, x-1에 도달하는 수를 구해야 하므로, visited를 모두 아주 크게 해놓고 다른 칸에 도달 할 때마다, 현재 가장 작게 도달하는 값으로 갱신한다.
// bfsQueue에 집어넣는 위치 조심하기

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
            if adjMatrix[ny][nx] == 1 { // 흰색 방
                if visited[ny][nx] > visited[currentY][currentX] {
                    visited[ny][nx] = visited[currentY][currentX]
                    bfsQueue.append((ny,nx))
                }
            } else { // 검은색 방
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


