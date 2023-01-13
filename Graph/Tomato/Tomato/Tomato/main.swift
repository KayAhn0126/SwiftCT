//
//  main.swift
//  Tomato
//
//  Created by Kay on 2023/01/13.
//

/*
 7576
 토마토
 */

/*
 문제 설계
 BFS + 최단거리
 1 익은 토마토
 0 익지않은 토마토
 -1 벽
 
 저장될때 모든 토마토가 익어있는 상태면 0 출력
 토마토가 모두 익지 못하는 상황이라면 -1 출력
 
 */

import Foundation

struct Queue<T> {
    var enQueue: [T] = []
    var deQueue: [T] = []
    
    var count: Int {
        return enQueue.count + deQueue.count
    }
    
    var isEmpty: Bool {
        return enQueue.isEmpty && deQueue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enQueue.append(element)
    }
    
    mutating func dequeue() -> T {
        if deQueue.isEmpty {
            deQueue = enQueue.reversed()
            enQueue.removeAll()
        }
        return deQueue.popLast()!
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let MN = readLine()!.split(separator: " ").map { Int(String($0))! }
let M = MN[0] // 가로
let N = MN[1] // 세로

var adjMatrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

var bfsQueue = Queue<(Int,Int)>()


for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

func result() -> Int {
    var result = 0
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] != -1 && visited[i][j] == 0 {
                return -1
            } else {
                result = visited[i][j] > result ? visited[i][j] : result
            }
        }
    }
    return result - 1
}

func bfs() {
    while !bfsQueue.isEmpty {
        let next = bfsQueue.dequeue()
        let currentY = next.0
        let currentX = next.1
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if adjMatrix[ny][nx] == -1 { continue }
            if visited[ny][nx] != 0 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            bfsQueue.enqueue((ny,nx))
        }
    }
}

var alreadyRipe = 0
var wallCount = 0
for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == 1 {
            visited[i][j] = 1
            bfsQueue.enqueue((i,j))
        }
    }
}


bfs()
print(result())
