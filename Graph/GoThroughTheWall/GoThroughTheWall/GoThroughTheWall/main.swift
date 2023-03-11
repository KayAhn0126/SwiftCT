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
 
 처음에 시도했던 방법 -> 시간초과
 시간 복잡도 1000 * 1000 * BFS
 인접 행렬의 BFS는 시간복잡도가 O(N*M) = O(1,000,000)
 O(1,000,000 * 1,000,000) = O(10^12) 안된다.
 
 새로운 방법
 3차원 배열을 만들고 마지막 배열을 부셨는지 안부셨는지 판단하도록 한다.
 처음에는 부시지 않은 상태이니 0으로 두고 그 상태에서 처음 벽을 만나면 1로 변환한 상태로 계속 BFS를 진행한다.
 
 0100
 1110
 1000
 0000
 0111
 0000
 
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

// 3차원 배열
var visited = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 2), count: M), count: N)

func bfs() -> Int {
    var bfsQueue: [(Int,Int,Int)] = [], idx = 0
    visited[0][0][0] = 1
    bfsQueue.append((0,0,0))
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        let currentY = currentLocation.0
        let currentX = currentLocation.1
        let currentShatterStatus = currentLocation.2
        if currentY == N - 1 && currentX == M - 1 { // 목표 위치에 도달 했다면..?
            return visited[N-1][M-1][currentShatterStatus]
        }
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if visited[ny][nx][currentShatterStatus] > 0 { continue } // 문제의 특성상 여기서 벽 체크 하지 않음
            if adjMatrix[ny][nx] == 0 { // 맵에서 다음 가려는 곳이 벽이 아니라면..? -> 일반적인 BFS 상황처럼 흘러감
                visited[ny][nx][currentShatterStatus] = visited[currentY][currentX][currentShatterStatus] + 1
                bfsQueue.append((ny,nx,currentShatterStatus))
            } else { // 맵에서 다음 가려는 곳이 벽이라면..?? -> 이전에 벽을 부쉈는지 체크 후 분기처리
                if currentShatterStatus == 0 { // 아직 벽을 부시지 않음
                    visited[ny][nx][1] = visited[currentY][currentX][currentShatterStatus] + 1
                    bfsQueue.append((ny,nx,1))
                } else { // 여기까지 오면서 벽을 부신적이 있음
                    continue
                }
            }
        }
    }
    return -1
}
print(bfs())
