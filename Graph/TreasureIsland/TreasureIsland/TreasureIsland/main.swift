//
//  main.swift
//  TreasureIsland
//
//  Created by Kay on 2023/01/17.
//

/*
 2589
 보물섬
 */
// 가중치가 같은 그래프에서 최단거리 -> BFS
// 3rd week fast campus

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
            return dequeueList.popLast()
        }
        return dequeueList.popLast()
    }
}

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var landList: [(Int,Int)] = []
var adjMatrix = [[Character]](repeating: [Character](), count: N)
var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!)
}

for i in 0..<N {
    for j in 0..<M {
        if adjMatrix[i][j] == "L" {
            landList.append((i,j))
        }
    }
}

func bfs(_ y: Int, _ x: Int) -> Int {
    var max = -987654321
    var queue = Queue<(Int,Int)>()
    var visited = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    visited[y][x] = 1
    queue.enqueue((y,x))
    while !queue.isEmpty {
        let currentLocation = queue.dequeue()!
        let currentY = currentLocation.0
        let currentX = currentLocation.1
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
            if adjMatrix[ny][nx] == "W" { continue }
            if visited[ny][nx] != 0 { continue }
            visited[ny][nx] = visited[currentY][currentX] + 1
            max = max > visited[ny][nx] ? max : visited[ny][nx]
            queue.enqueue((ny,nx))
        }
    }
    return max
}

var maximum = -987654321
for i in 0..<landList.count {
    let tryNumber = bfs(landList[i].0, landList[i].1)
    maximum = tryNumber > maximum ? tryNumber : maximum
}
print(maximum - 1)
