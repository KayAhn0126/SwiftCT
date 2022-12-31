//
//  main.swift
//  MazeSearch
//
//  Created by Kay on 2022/12/31.
//

/*
#2178
 미로탐색
 */

// 2nd week fast-campus
import Foundation

struct Queue<T> {
    var queue: [T] = []
    
    var count: Int {
        return queue.count
    }
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    mutating func dequeue() -> T {
        queue = queue.reversed()
        let firstElement = queue.popLast()!
        queue = queue.reversed()
        return firstElement
    }
}

var rowcol = readLine()!.split(separator: " ").map { Int($0)! }
let N = rowcol[0]
let M = rowcol[1]

var adjMatrix = [[Int]]()
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]


for _ in 0..<N {
    adjMatrix.append(readLine()!.map { Int(String($0))! })
}

func bfs(_ y: Int, _ x: Int) {
    var queue = Queue<(Int,Int)>()
    visited[y][x] = 1
    queue.enqueue((y,x))
    
    while !queue.isEmpty {
        let currentYX = queue.dequeue()
        let y = currentYX.0
        let x = currentYX.1
        
        for i in 0..<4 {
            let ny = y + dy[i]
            let nx = x + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if adjMatrix[ny][nx] == 0 { continue }
            if visited[ny][nx] != 0 { continue }
            visited[ny][nx] = visited[y][x] + 1
            queue.enqueue((ny,nx))
        }
    }
}

bfs(0,0)
print(visited[N-1][M-1])
