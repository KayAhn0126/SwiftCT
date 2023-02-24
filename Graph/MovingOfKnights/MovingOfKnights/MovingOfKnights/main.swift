//
//  main.swift
//  MovingOfKnights
//
//  Created by Kay on 2023/02/23.
//

/*
 7562
 나이트의 이동
 */


/*
 BFS + 최단거리
 현재 위치에서 말이 갈 수 있는 위치를 가면서 최단거리 구하기
 
 let dy = [-1,0,1,0]
 let dx = [0,1,0,-1]
 
 뮤탈리스크와 비슷한 문제
 */

import Foundation

let testCase = Int(readLine()!)!
let possibleLocation: [(Int,Int)] = [(-1,-2),(-2,-1),(-2,1),(-1,2),(1,2),(2,1),(2,-1),(1,-2)]


for _ in 0..<testCase {
    let N = Int(readLine()!)!
    var visited = [[Int]](repeating: [Int](repeating: 0, count: N), count: N)
    let fromLocation = readLine()!.split(separator: " ").map { Int(String($0))! }
    let fromY = fromLocation[0]
    let fromX = fromLocation[1]
    let toLocation = readLine()!.split(separator: " ").map { Int(String($0))! }
    let toY = toLocation[0]
    let toX = toLocation[1]
    
    var bfsQueue = [(Int,Int)](), idx = 0
    
    visited[fromY][fromX] = 1
    bfsQueue.append((fromY, fromX))
    // bfs
    while idx < bfsQueue.count {
        let currentLocation = bfsQueue[idx]; idx += 1
        let currentY = currentLocation.0
        let currentX = currentLocation.1
        if currentY == toY && currentX == toX {
            print(visited[currentY][currentX] - 1)
            break
        }
        for i in possibleLocation {
            let ny = currentY + i.0
            let nx = currentX + i.1
            if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
            if visited[ny][nx] > 0 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            bfsQueue.append((ny,nx))
        }
    }
}
