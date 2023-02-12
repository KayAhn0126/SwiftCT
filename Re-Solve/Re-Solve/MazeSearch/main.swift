//
//  main.swift
//  MazeSearch
//
//  Created by Kay on 2023/02/12.
//

/*
 2178
 미로 탐색
 */

/*
 BFS + 최단거리
 */

import Foundation

struct Queue<T> {
    var enqueueList: [T] = []
    var dequeueList: [T] = []
    
    var count: Int {
        return enqueueList.count + dequeueList.count
    }
    
    var isEmpty: Bool {
        return enqueueList.isEmpty && dequeueList.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        enqueueList.append(element)
    }
    
    mutating func dequeue() -> T? {
        if dequeueList.isEmpty {
            dequeueList = enqueueList.reversed()
            enqueueList.removeAll()
        }
        return dequeueList.popLast()
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]



let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var matrix = [[Int]](repeating: [Int](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

func bfs(_ y: Int, _ x: Int) {
    var queue = Queue<(Int,Int)>()
    visited[y][x] = 1
    queue.enqueue((y,x))
    while !queue.isEmpty {
        let currentYX = queue.dequeue()!
        let currentY = currentYX.0
        let currentX = currentYX.1
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if matrix[ny][nx] == 0 || visited[ny][nx] > 0 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            queue.enqueue((ny,nx))
        }
    }
}
for i in 0..<N {
    matrix[i].append(contentsOf: readLine()!.map { Int(String($0))! })
}

bfs(0,0)
print(visited[N-1][M-1])

// 40분, 큐 구현 잘못함.
